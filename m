From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 16 Nov 2012 23:56:50 +0100
Subject: [GIT PULL] ARM: sunxi: Add basic support for Allwinner SoCs
Message-ID: <1353106610-18681-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is a pull request to add the basic support for Allwinner A1X SoCs.

Thanks,
Maxime

The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:

  Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)

are available in the git repository at:

  git://github.com/mripard/linux.git tags/tags/sunxi-support-for-3.8

for you to fetch changes up to 1b106699647b56313bac707e12e7ad67180cb147:

  ARM: sunxi: Add entry to MAINTAINERS (2012-11-16 21:56:53 +0100)

----------------------------------------------------------------
Allwinner SoC support for 3.8

----------------------------------------------------------------
Maxime Ripard (7):
      clk: sunxi: Add dummy fixed rate clock for Allwinner A1X SoCs
      clocksource: sunxi: Add Allwinner A1X Timer Driver
      irqchip: sunxi: Add irq controller driver
      ARM: sunxi: Add basic support for Allwinner A1x SoCs
      ARM: sunxi: Add earlyprintk support
      ARM: sunxi: Add device tree for the A13 and the Olinuxino board
      ARM: sunxi: Add entry to MAINTAINERS

 Documentation/arm/sunxi/README                     |   19 +++
 .../interrupt-controller/allwinner,sunxi-ic.txt    |  104 ++++++++++++
 .../bindings/timer/allwinner,sunxi-timer.txt       |   17 ++
 MAINTAINERS                                        |    6 +
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Kconfig.debug                             |    8 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/Makefile                         |    1 +
 arch/arm/boot/dts/sun5i-olinuxino.dts              |   26 +++
 arch/arm/boot/dts/sun5i.dtsi                       |   74 +++++++++
 arch/arm/include/debug/sunxi.S                     |   24 +++
 arch/arm/mach-sunxi/Kconfig                        |    9 ++
 arch/arm/mach-sunxi/Makefile                       |    1 +
 arch/arm/mach-sunxi/Makefile.boot                  |    1 +
 arch/arm/mach-sunxi/sunxi.c                        |   60 +++++++
 arch/arm/mach-sunxi/sunxi.h                        |   20 +++
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-sunxi.c                            |   30 ++++
 drivers/clocksource/Kconfig                        |    3 +
 drivers/clocksource/Makefile                       |    1 +
 drivers/clocksource/sunxi_timer.c                  |  170 ++++++++++++++++++++
 drivers/irqchip/Makefile                           |    1 +
 drivers/irqchip/irq-sunxi.c                        |  150 +++++++++++++++++
 include/linux/clk/sunxi.h                          |   22 +++
 include/linux/irqchip/sunxi.h                      |   27 ++++
 include/linux/sunxi_timer.h                        |   24 +++
 26 files changed, 802 insertions(+)
 create mode 100644 Documentation/arm/sunxi/README
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sunxi-ic.txt
 create mode 100644 Documentation/devicetree/bindings/timer/allwinner,sunxi-timer.txt
 create mode 100644 arch/arm/boot/dts/sun5i-olinuxino.dts
 create mode 100644 arch/arm/boot/dts/sun5i.dtsi
 create mode 100644 arch/arm/include/debug/sunxi.S
 create mode 100644 arch/arm/mach-sunxi/Kconfig
 create mode 100644 arch/arm/mach-sunxi/Makefile
 create mode 100644 arch/arm/mach-sunxi/Makefile.boot
 create mode 100644 arch/arm/mach-sunxi/sunxi.c
 create mode 100644 arch/arm/mach-sunxi/sunxi.h
 create mode 100644 drivers/clk/clk-sunxi.c
 create mode 100644 drivers/clocksource/sunxi_timer.c
 create mode 100644 drivers/irqchip/irq-sunxi.c
 create mode 100644 include/linux/clk/sunxi.h
 create mode 100644 include/linux/irqchip/sunxi.h
 create mode 100644 include/linux/sunxi_timer.h
