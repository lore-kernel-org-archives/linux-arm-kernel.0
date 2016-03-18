From: eric@anholt.net (Eric Anholt)
Date: Thu, 17 Mar 2016 18:38:50 -0700
Subject: [GIT PULL] bcm2835 clk changes for 4.6 maybe
Message-ID: <1458265130-30734-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is late, so feel free to drop it, but I figured I'd send it to
you in case you were still open to merges.  I've pounded on it a bit
today (modesets to all sorts of resolutions on HDMI, used it for
testing the DPI panel support that I'm hoping to have for 4.7, and did
a whole lot of browsing of clk_summary as I debugged DPI), and kbuild
test robot came back clean, so I'm pretty happy with it.

The following changes since commit 4d3ac6662452060721599a3392bc2f524af984cb:

  clk: bcm2835: fix check of error code returned by devm_ioremap_resource() (2016-03-15 18:14:11 -0700)

are available in the git repository at:

  git at github.com:anholt/linux.git tags/bcm2835-clk-next-2016-03-17

for you to fetch changes up to d3d6f15fd376e3dbba851724057b112558c70b79:

  clk: bcm2835: add missing osc and per clocks (2016-03-17 10:42:17 -0700)

----------------------------------------------------------------
This pull request against clk/clk-next brings in fixes for fractional
clocks on 2835, add the PCM clock that used to be driven directly by
the bcm2835-i2s driver (that driver has been broken since this driver
was introduced), and adds many other new clocks.

----------------------------------------------------------------
Martin Sperl (11):
      clk: bcm2835: pll_off should only update CM_PLL_ANARST
      clk: bcm2835: add locking to pll*_on/off methods
      clk: bcm2835: divider value has to be 1 or more
      clk: bcm2835: correctly enable fractional clock support
      clk: bcm2835: clean up coding style issues
      clk: bcm2835: expose raw clock-registers via debugfs
      clk: bcm2835: remove use of BCM2835_CLOCK_COUNT in driver
      clk: bcm2835: reorganize bcm2835_clock_array assignment
      clk: bcm2835: enable management of PCM clock
      clk: bcm2835: add missing PLL clock dividers
      clk: bcm2835: add missing osc and per clocks

 drivers/clk/bcm/clk-bcm2835.c       | 1203 +++++++++++++++++++++--------------
 include/dt-bindings/clock/bcm2835.h |   20 +-
 2 files changed, 733 insertions(+), 490 deletions(-)
