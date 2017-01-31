From: eric@anholt.net (Eric Anholt)
Date: Tue, 31 Jan 2017 11:11:20 -0800
Subject: [GIT PULL] bcm2835-dt-next-2017-01-31
Message-ID: <20170131191120.19742-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's another round of DT changes.  The shortlog here came out a bit
funny, because I had to give it a base of either 4.10-rc2 (which is
coming in through the clk tree) or the previous VEC changes you'd
pulled.  I did base off of the patches you pulled with the subjects
fixed, though.

The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:

  Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)

are available in the git repository at:

  https://github.com/anholt/linux tags/bcm2835-dt-next-2017-01-31

for you to fetch changes up to c62e223c9f67721d67a0f07bf524ece447b0cc46:

  ARM: dts: bcm2835: Add the DSI module nodes and clocks. (2017-01-31 10:43:29 -0800)

----------------------------------------------------------------
This pull request brings in some small fixes to (unused) pinmux
groups, a fix for getting the mac address from u-boot, and the
(disabled by default) nodes for the DSI interfaces.

The functional change is adding the DSI clocks that feed into to the
cprman node.  This required merging in a topic branch from the clk
tree (acked by the maintainer), which was based on 4.10-rc2.

----------------------------------------------------------------
Baruch Siach (4):
      ARM: dts: bcm2835: fix uart0 pinctrl node names
      ARM: dts: bcm2835: fix i2c0 pins
      ARM: dts: bcm2835: fix uart0/uart1 pins
      ARM: dts: bcm2835: add index to the ethernet alias

Boris Brezillon (2):
      ARM: dts: bcm283x: Add VEC node in bcm283x.dtsi
      ARM: dts: bcm283x: Enable the VEC IP on all RaspberryPi boards

Eric Anholt (5):
      clk: bcm2835: Don't rate change PLLs on behalf of DSI PLL dividers.
      clk: bcm2835: Register the DSI0/DSI1 pixel clocks.
      clk: bcm2835: Add leaf clock measurement support, disabled by default
      Merge remote-tracking branch 'clk/clk-bcm2835' into bcm2835-dt-next
      ARM: dts: bcm2835: Add the DSI module nodes and clocks.

 .../bindings/clock/brcm,bcm2835-cprman.txt         |  15 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  13 +
 arch/arm/boot/dts/bcm283x-rpi-smsc9512.dtsi        |   2 +-
 arch/arm/boot/dts/bcm283x-rpi-smsc9514.dtsi        |   2 +-
 arch/arm/boot/dts/bcm283x.dtsi                     |  78 +++++-
 drivers/clk/bcm/clk-bcm2835.c                      | 303 +++++++++++++++++----
 include/dt-bindings/clock/bcm2835.h                |   2 +
 7 files changed, 351 insertions(+), 64 deletions(-)
