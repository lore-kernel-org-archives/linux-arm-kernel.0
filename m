From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 19 Oct 2015 11:43:10 -0700
Subject: [GIT PULL 1/2] Broadcom Device Tree changes for 4.4 (part 2)
In-Reply-To: <1445280190-8812-1-git-send-email-f.fainelli@gmail.com>
References: <1445280190-8812-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1445280190-8812-2-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit eef228e3191de0b62ef5913be216f25ba6b23a4c:

  ARM: dts: move aliases back to .dts in Cygnus (2015-09-24 18:30:10 -0700)

are available in the git repository at:

  http://github.com/Broadcom/stblinux tags/arm-soc/for-4.4/devicetree-part2

for you to fetch changes up to da6b53a6f7abc3d84260a9f0ff9849a88b44e11f:

  ARM: bcm2835: Switch to using the new clock driver support. (2015-10-19 11:32:24 -0700)

----------------------------------------------------------------
This pull request contains the DT changes for BCM2835 in 4.4.  It
pulls in clk/clk-bcm2835 (which Stephen Boyd has said would be stable)
because the DT changes to enable the clock driver need the driver
itself to be present. These changes include the following:

- Eric Anholt, moves the bcm2835 clock driver under bcm/ where it belongs with
  other Broadcom clock providers drivers, defines the binding for new clock
  driver, adds support for programming the BCM2835 audio domain, adds the DDC I2C
  controller to Device Tree, and finally migrates the Device Tree to use the new
  clock driver binding

- Lubomir Rintel adds support for the Raspberry Pi Model A+ and B revision 2, and
  remove the I2S controller which is non-existent on Raspberry Pi Model B

- Stefan Wahren adds an uart0 label for referencing the UART adapter

----------------------------------------------------------------
Eric Anholt (5):
      ARM: bcm2835: Add the DDC I2C controller to the device tree.
      clk: bcm2835: Move under bcm/ with other Broadcom SoC clk drivers.
      clk: bcm2835: Add binding docs for the new platform clock driver.
      clk: bcm2835: Add support for programming the audio domain clocks
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
