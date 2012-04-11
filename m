From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 Apr 2012 17:35:15 +0200
Subject: [PATCH 0/9] AT91: more DT soc and boards support
Message-ID: <20120411153515.GK16641@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI,

	In this patch series you will found the support for

	 - at91sam9260 (nearly the same as 9g20)
	 - at91sam9263

	and boards
	 - at91sam9g20ek (1 mmc and 2mmc version)
	 - at91sam9263ek
	 - Calao USB A9260
	 - Calao TNY A9260 & A9G20

The following changes since commit 0b51efa18140c8a134e64a987417ff02d30f7363:

  gpio: drop CONFIG_OF_GPIO in the definition of the struct gpio_chip (2012-04-10 21:37:22 +0800)

are available in the git repository at:

  git at github.com:at91linux/linux-at91.git j/for-3.5

for you to fetch changes up to c8a6a45dd44db2526caeda45606e6c47621878d2:

  ARM: at91: add at91sam9263ek DT support (2012-04-11 23:43:06 +0800)

----------------------------------------------------------------
Jean-Christophe PLAGNIOL-VILLARD (9):
      ARM: at91: add at91sam9260 DT support
      arm: at91: add Calao TNY-A9260 and TNY-A9G20 board support
      ARM: at91: add at91sam9g20ek boards dt support
      ARM: at91: USB A926x update nand partition
      ARM: at91: Calao USB A926x factorize common binding in usb_a9260_common
      ARM: at91: DT: add Calao USB A9260 DT support
      ARM: at91: standard device init only if DT is not populated.
      ARM: at91: add at91sam9263 DT support
      ARM: at91: add at91sam9263ek DT support

 arch/arm/boot/dts/at91sam9260.dtsi          |  239 +++++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9263.dtsi          |  221 +++++++++++++++++++++++++
 arch/arm/boot/dts/at91sam9263ek.dts         |  156 +++++++++++++++++
 arch/arm/boot/dts/at91sam9g20.dtsi        
  |  227 +-------------------------
 arch/arm/boot/dts/at91sam9g20ek.dts         |   29 ++++
 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts    |   29 ++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  142 ++++++++++++++++
 arch/arm/boot/dts/tny_a9260.dts             |   15 ++
 arch/arm/boot/dts/tny_a9260_common.dtsi     |   83 +++++++++
 arch/arm/boot/dts/tny_a9g20.dts             |   15 ++
 arch/arm/boot/dts/usb_a9260.dts             |   23 +++
 arch/arm/boot/dts/usb_a9260_common.dtsi     |  117 +++++++++++++
 arch/arm/boot/dts/usb_a9g20.dts             |  102 +-----------
 arch/arm/mach-at91/Makefile.boot            |    8 +
 arch/arm/mach-at91/at91sam9260_devices.c    |   20 +--
 arch/arm/mach-at91/at91sam9263.c            |   10 +
 arch/arm/mach-at91/at91sam9263_devices.c    |   20 +++
 arch/arm/mach-at91/at91sam9g45_devices.c    |   30 +---
 arch/arm/mach-at91/board-usb-a926x.c        |    4 +
 19 files changed, 1122 insertions(+), 368 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9260.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9263.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9263ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9g20ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
 create mode 100644 arch/arm/boot/dts/at91sam9g20ek_common.dtsi
 create mode 100644 arch/arm/boot/dts/tny_a9260.dts
 create mode 100644 arch/arm/boot/dts/tny_a9260_common.dtsi
 create mode 100644 arch/arm/boot/dts/tny_a9g20.dts
 create mode 100644 arch/arm/boot/dts/usb_a9260.dts
 create mode 100644 arch/arm/boot/dts/usb_a9260_common.dtsi

Best Regards,
J.
