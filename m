From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 22 Oct 2014 14:05:48 +0200
Subject: [GIT PULL] RealView DeviceTree support for v3.19
Message-ID: <CACRpkdbtbE6nT0rz0SEKcp67YJ2n7GW=ABxwqek4jYfSPViv0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

here is a first pull request for the v3.19 series, with some RealView
Device Tree support code!

This is basically the two paches that didn't make it into v3.18 and
incremental DTS changes in top of it that was sent out some week
ago.

It would be nice to get this into linux-next for some testing so please
pull this into ARM SoC!

Yours,
Linus Walleij

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/arm-realview-dt-for-arm-soc

for you to fetch changes up to 10d8ddee10b886e4aec0d3e44a73cfa7c35e72e0:

  ARM: realview: add MMCI to the PB1176 DTS (2014-10-22 13:49:13 +0200)

----------------------------------------------------------------
- Device Tree implementation for the ARM RealView boards
- DTS file for the ARM RealView PB1176
- Updates on top of the same DTS file

----------------------------------------------------------------
Linus Walleij (10):
      ARM: realview: basic device tree implementation
      ARM: realview: add device tree and bindings for PB1176
      ARM: realview: move DT GIC to FPGA node
      ARM: realview: add PL061 GPIO to the PB1176 DTS
      ARM: realview: add charlcd to PB1176 device tree
      ARM: realview: add RTC clocks to device tree
      ARM: realview: add PL022 SSP/SPI block to PB1176 DTS
      ARM: realview: add FPGA UART4 to PB1176 DTS
      ARM: realview: add KMIs to the PB1176 DTS
      ARM: realview: add MMCI to the PB1176 DTS

 Documentation/devicetree/bindings/arm/arm-boards |  65 ++++
 Documentation/devicetree/bindings/arm/gic.txt    |   1 +
 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/arm-realview-pb1176.dts        | 412 +++++++++++++++++++++++
 arch/arm/mach-realview/Kconfig                   |  13 +
 arch/arm/mach-realview/Makefile                  |   1 +
 arch/arm/mach-realview/realview-dt.c             |  32 ++
 drivers/irqchip/irq-gic.c                        |   2 +
 8 files changed, 527 insertions(+)
 create mode 100644 arch/arm/boot/dts/arm-realview-pb1176.dts
 create mode 100644 arch/arm/mach-realview/realview-dt.c
