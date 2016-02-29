From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 29 Feb 2016 12:51:40 +0000
Subject: [PATCH 0/3] reorganize clock initialization and add PCM clock
Message-ID: <1456750304-2424-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

As changing entries in the dt-bindings header files is frowned upon
and as we would need to change BCM2835_CLOCK_COUNT for every new
clock added, this patchset moves away from the use of
BCM2835_CLOCK_COUNT and removes it from the dt-bindings alltogether.

Instead - as recommended by Michael Turquette, Geert Uytterhoeven
and Remi Pommarel - patch 1 introduces a new initialization
process in probe that simply uses ARRAY_SIZE on a (sparse) array.

With patch 2 the initialization of the array is simplified and
better grouped together.

Patch 3 introduces the pcm clock of the bcm2835 soc and already
shows the simplification at work - the main reason for this patchset.

Martin Sperl (3):
  clk: bcm2835: remove use of BCM2835_CLOCK_COUNT in driver
  clk: bcm2835: reorganize bcm2835_clock_array assignment
  clk: bcm2835: enable management of PCM clock

 drivers/clk/bcm/clk-bcm2835.c       |  918 +++++++++++++++++------------------
 include/dt-bindings/clock/bcm2835.h |    3 +-
 2 files changed, 441 insertions(+), 480 deletions(-)

--
1.7.10.4
