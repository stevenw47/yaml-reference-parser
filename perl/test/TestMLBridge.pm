use v5.12;
package TestMLBridge;
use base 'TestML::Bridge';

use lib 'lib';

use Prelude;
use Parser;
use TestReceiver;

sub parse {
  my ($self, $yaml) = @_;

  my $parser = Parser->new(TestReceiver->new);

  eval { $parser->parse($yaml) };
  return $@
    ? do { warn $@; '' }
    : $parser->{receiver}->output;
}

sub unescape {
  my ($self, $yaml) = @_;
  $yaml =~ s/<SPC>/ /g;
  $yaml =~ s/<TAB>/\t/g;
  return $yaml;
}

sub fix1 {
  my ($self, $events) = @_;
  $events =~ s/^\+MAP\ \{\}/+MAP/gm;
  $events =~ s/^\+SEQ\ \[\]/+SEQ/gm;
  return $events;
}

1;
