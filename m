From: eric@anholt.net (Eric Anholt)
Date: Thu, 15 Oct 2015 11:54:04 -0700
Subject: [GIT PULL] DT changes for BCM2835 for 4.4
Message-ID: <87pp0gotdf.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  http://github.com/anholt/linux tags/bcm2835-dt-for-4.4-v1

for you to fetch changes up to 9450d58953f947ecb666e552096d6faa3476f71d:

  ARM: bcm2835: Switch to using the new clock driver support. (2015-10-14 15:41:20
-0700)

----------------------------------------------------------------
This pull request contains the DT changes for BCM2835 in 4.4.  It
pulls in clk/clk-bcm2835 (which Stephen Boyd has said would be stable)
because the DT changes to enable the clock driver need the driver
itself to be present.

----------------------------------------------------------------
Eric Anholt (6):
      clk: bcm2835: Move under bcm/ with other Broadcom SoC clk drivers.
      clk: bcm2835: Add binding docs for the new platform clock driver.
      clk: bcm2835: Add support for programming the audio domain clocks
      ARM: bcm2835: Add the DDC I2C controller to the device tree.
      Merge remote-tracking branch 'clk/clk-bcm2835' into bcm2835-dt-next
      ARM: bcm2835: Switch to using the new clock driver support.

Lubomir Rintel (3):
      ARM: bcm2835: dt: Raspberry Pi Model B had no I2S
      ARM: bcm2835: dt: Add Raspberry Pi Model B rev2
      ARM: bcm2835: dt: Add Raspberry Pi Model A+

Stefan Wahren (1):
      ARM: bcm2835: add label for uart0

 .../bindings/clock/brcm,bcm2835-cprman.txt         |   45 +
 arch/arm/boot/dts/Makefile                         |    4 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts           |   30 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts           |   23 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |    8 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |    4 +
 arch/arm/boot/dts/bcm2835.dtsi                     |   64 +-
 drivers/clk/Makefile                               |    1 -
 drivers/clk/bcm/Makefile                           |    1 +
 drivers/clk/bcm/clk-bcm2835.c                      | 1575 ++++++++++++++++++++
 drivers/clk/clk-bcm2835.c                          |   55 -
 include/dt-bindings/clock/bcm2835.h                |   47 +
 12 files changed, 1768 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/brcm,bcm2835-cprman.txt
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts
 create mode 100644 drivers/clk/bcm/clk-bcm2835.c
 delete mode 100644 drivers/clk/clk-bcm2835.c
 create mode 100644 include/dt-bindings/clock/bcm2835.h
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151015/ea6a9852/attachment.sig>
