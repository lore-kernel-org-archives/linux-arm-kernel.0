From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 27 Apr 2012 18:47:27 +0200
Subject: [PULL] ARM: at91 more dt bonard and soc conversion
Message-ID: <20120427164727.GV9142@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

please pull
The following changes since commit 39ecc143b4c1f3d42e8300e7f5274681b99f95c2:

  ARM: at91: add defconfig for device tree (2012-04-17 14:47:22 +0200)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git tags/at91-for-next-dt

for you to fetch changes up to 26690863e2c1fa4fee5f6137b219f4b8a1a02287:

  Ethernut 5 board support (2012-04-27 23:23:22 +0800)

----------------------------------------------------------------
ARM: AT91 more DT material

New SoC conversion and boards support

SoC convertion to DT:
 - at91sam9260
 - at91sam9263

boards:
 - Atmel at91sam9g20ek/9263ek
 - Calao TNY-A9260/A9263/A9G20
 - Calao USB-A9260/A9263
 - Ethernnut 5
 - Kizbox

----------------------------------------------------------------
Boris BREZILLON (1):
      ARM: at91: add kizbox board dt support.

Jean-Christophe PLAGNIOL-VILLARD (11):
      ARM: at91: add at91sam9260 DT support
      arm: at91: add Calao TNY-A9260 and TNY-A9G20 board support
      ARM: at91: add at91sam9g20ek boards dt support
      ARM: at91: USB A926x update nand partition
      ARM: at91: Calao USB A926x factorize common binding in usb_a9260_common
      ARM: at91: DT: add Calao USB A9260 DT support
      ARM: at91: standard device init only if DT is not populated.
      ARM: at91: add at91sam9263 DT support
      ARM: at91: add at91sam9263ek DT support
      ARM: at91: DT: add Calao USB A9263 board support
      ARM: at91: DT: add Calao TNY A9263 board support

Tim Schendekehl (1):
      Ethernut 5 board support

 arch/arm/boot/dts/at91sam9260.dtsi          |  238 +++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi          |  220 +++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9263ek.dts         |  156 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9g20.dtsi          |  226 +-------------------------
 arch/arm/boot/dts/at91sam9g20ek.dts         |   29 ++++
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts    |   29 ++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  142 ++++++++++++++++
 arch/arm/boot/dts/ethernut5.dts             |   84 ++++++++++
 arch/arm/boot/dts/kizbox.dts                |  138 ++++++++++++++++
 arch/arm/boot/dts/tny_a9260.dts             |   15 ++
 arch/arm/boot/dts/tny_a9260_common.dtsi     |   83 +++++++++
 arch/arm/boot/dts/tny_a9263.dts             |   97 +++++++++++
 arch/arm/boot/dts/tny_a9g20.dts             |   15 ++
 arch/arm/boot/dts/usb_a9260.dts             |   23 +++
 arch/arm/boot/dts/usb_a9260_common.dtsi     |  117 +++++++++++++
 arch/arm/boot/dts/usb_a9263.dts             |  131 +++++++++++++++
 arch/arm/boot/dts/usb_a9g20.dts             |  102 +-----------
 arch/arm/mach-at91/Makefile.boot            |   12 ++
 arch/arm/mach-at91/at91sam9260_devices.c    |   20 +--
 arch/arm/mach-at91/at91sam9263.c            |   10 +
 arch/arm/mach-at91/at91sam9263_devices.c    |   20 +++
 arch/arm/mach-at91/at91sam9g45_devices.c    |   30 +---
 arch/arm/mach-at91/board-usb-a926x.c        |    4 +
 23 files changed, 1574 insertions(+), 367 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9260.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9263.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9263ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9g20ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
 create mode 100644 arch/arm/boot/dts/at91sam9g20ek_common.dtsi
 create mode 100644 arch/arm/boot/dts/ethernut5.dts
 create mode 100644 arch/arm/boot/dts/kizbox.dts
 create mode 100644 arch/arm/boot/dts/tny_a9260.dts
 create mode 100644 arch/arm/boot/dts/tny_a9260_common.dtsi
 create mode 100644 arch/arm/boot/dts/tny_a9263.dts
 create mode 100644 arch/arm/boot/dts/tny_a9g20.dts
 create mode 100644 arch/arm/boot/dts/usb_a9260.dts
 create mode 100644 arch/arm/boot/dts/usb_a9260_common.dtsi
 create mode 100644 arch/arm/boot/dts/usb_a9263.dts

Best Regards,
J.
