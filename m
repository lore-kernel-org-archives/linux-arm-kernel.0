From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 18 Apr 2012 09:14:56 +0530
Subject: [GIT PULL] ARM: spear-soc support for 3.5
Message-ID: <4F8E38B8.20907@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd/Olof,

The following changes since commit a82c81fb238811d4eea6d36b5e0b4c4dda004982:

  Add linux-next specific files for 20120416 (2012-04-16 16:00:03 +1000)

are available in the git repository at:

  git://git.stlinux.com/spear/linux-2.6.git spear-v3.5

for you to fetch changes up to 40652c37b478ad3624000a339e5adc62a97094df:

  ARM: spear: remove most mach/*.h header contents (2012-04-17 13:51:27 +0530)

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: spear: remove most mach/*.h header contents

Stefan Roese (1):
      ARM: SPEAr600: Change FSMC and SMI clock names

Viresh Kumar (11):
      SPEAr: Use CLKDEV_INIT for defining clk_lookups
      SPEAr3xx: Add clock instance of usb hosts - ehci and ohci 0 and 1
      SPEAr6xx: Add compilation support for dtbs using 'make dtbs'
      SPEAr3xx: Replace printk() with pr_*()
      ARM: SPEAr3xx: Add device-tree support to SPEAr3xx architecture
      SPEAr: Add PL080 DMA support for 3xx and 6xx
      SPEAr: Update defconfigs
      SPEAr: Remove existing padmux support for SPEAr
      pinctrl: Add SPEAr pinctrl drivers
      pinctrl: Add SPEAr3xx pinctrl drivers
      SPEAr3xx: Add pinctrl support for boards

 Documentation/arm/SPEAr/overview.txt               |   13 +-
 Documentation/devicetree/bindings/arm/spear.txt    |   18 +
 .../devicetree/bindings/pinctrl/pinctrl_spear.txt  |  108 +
 MAINTAINERS                                        |   23 +-
 arch/arm/boot/dts/spear300-evb.dts                 |  221 ++
 arch/arm/boot/dts/spear300.dtsi                    |   77 +
 arch/arm/boot/dts/spear310-evb.dts                 |  172 +
 arch/arm/boot/dts/spear310.dtsi                    |   80 +
 arch/arm/boot/dts/spear320-evb.dts                 |  173 +
 arch/arm/boot/dts/spear320.dtsi                    |   95 +
 arch/arm/boot/dts/spear3xx.dtsi                    |  144 +
 arch/arm/boot/dts/spear600-evb.dts                 |    4 +
 arch/arm/boot/dts/spear600.dtsi                    |    8 +
 arch/arm/configs/spear3xx_defconfig                |   52 +-
 arch/arm/configs/spear6xx_defconfig                |   41 +-
 arch/arm/mach-spear3xx/Kconfig                     |   37 +-
 arch/arm/mach-spear3xx/Makefile                    |   13 +-
 arch/arm/mach-spear3xx/Makefile.boot               |    4 +
 arch/arm/mach-spear3xx/clock.c                     |  280 ++-
 arch/arm/mach-spear3xx/include/mach/generic.h      |  164 +-
 arch/arm/mach-spear3xx/include/mach/hardware.h     |   24 +-
 arch/arm/mach-spear3xx/include/mach/irqs.h         |  130 +-
 arch/arm/mach-spear3xx/include/mach/misc_regs.h    |  144 -
 arch/arm/mach-spear3xx/include/mach/spear.h        |   47 +-
 arch/arm/mach-spear3xx/include/mach/spear300.h     |   54 -
 arch/arm/mach-spear3xx/include/mach/spear310.h     |   58 -
 arch/arm/mach-spear3xx/include/mach/spear320.h     |   67 -
 arch/arm/mach-spear3xx/spear300.c                  |  654 ++---
 arch/arm/mach-spear3xx/spear300_evb.c              |   75 -
 arch/arm/mach-spear3xx/spear310.c                  |  476 ++-
 arch/arm/mach-spear3xx/spear310_evb.c              |   81 -
 arch/arm/mach-spear3xx/spear320.c                  |  725 ++---
 arch/arm/mach-spear3xx/spear320_evb.c              |   79 -
 arch/arm/mach-spear3xx/spear3xx.c                  |  547 +---
 arch/arm/mach-spear6xx/Makefile.boot               |    2 +
 arch/arm/mach-spear6xx/clock.c                     |  186 +-
 arch/arm/mach-spear6xx/include/mach/generic.h      |   29 +-
 arch/arm/mach-spear6xx/include/mach/hardware.h     |   24 +-
 arch/arm/mach-spear6xx/include/mach/irqs.h         |   75 +-
 arch/arm/mach-spear6xx/include/mach/misc_regs.h    |  154 -
 arch/arm/mach-spear6xx/include/mach/spear.h        |   55 +-
 arch/arm/mach-spear6xx/include/mach/spear600.h     |   21 -
 arch/arm/mach-spear6xx/spear6xx.c                  |  417 +++-
 arch/arm/plat-spear/Kconfig                        |    4 +-
 arch/arm/plat-spear/Makefile                       |    4 +-
 arch/arm/plat-spear/include/plat/debug-macro.S     |    2 +-
 arch/arm/plat-spear/include/plat/hardware.h        |   17 -
 arch/arm/plat-spear/include/plat/padmux.h          |   92 -
 arch/arm/plat-spear/include/plat/pl080.h           |   21 +
 arch/arm/plat-spear/include/plat/uncompress.h      |    2 +-
 arch/arm/plat-spear/padmux.c                       |  164 -
 arch/arm/plat-spear/pl080.c                        |   80 +
 arch/arm/plat-spear/restart.c                      |    2 +-
 arch/arm/plat-spear/time.c                         |   17 +-
 drivers/of/address.c                               |    1 +
 drivers/pinctrl/Kconfig                            |    2 +
 drivers/pinctrl/Makefile                           |    2 +
 drivers/pinctrl/spear/Kconfig                      |   34 +
 drivers/pinctrl/spear/Makefile                     |    7 +
 drivers/pinctrl/spear/pinctrl-spear.c              |  354 ++
 drivers/pinctrl/spear/pinctrl-spear.h              |  142 +
 drivers/pinctrl/spear/pinctrl-spear300.c           |  708 ++++
 drivers/pinctrl/spear/pinctrl-spear310.c           |  431 +++
 drivers/pinctrl/spear/pinctrl-spear320.c           | 3468 ++++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear3xx.c           |  588 ++++
 drivers/pinctrl/spear/pinctrl-spear3xx.h           |   92 +
 66 files changed, 8929 insertions(+), 3156 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl_spear.txt
 create mode 100644 arch/arm/boot/dts/spear300-evb.dts
 create mode 100644 arch/arm/boot/dts/spear300.dtsi
 create mode 100644 arch/arm/boot/dts/spear310-evb.dts
 create mode 100644 arch/arm/boot/dts/spear310.dtsi
 create mode 100644 arch/arm/boot/dts/spear320-evb.dts
 create mode 100644 arch/arm/boot/dts/spear320.dtsi
 create mode 100644 arch/arm/boot/dts/spear3xx.dtsi
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/spear300.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/spear310.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/spear320.h
 delete mode 100644 arch/arm/mach-spear3xx/spear300_evb.c
 delete mode 100644 arch/arm/mach-spear3xx/spear310_evb.c
 delete mode 100644 arch/arm/mach-spear3xx/spear320_evb.c
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/spear600.h
 delete mode 100644 arch/arm/plat-spear/include/plat/hardware.h
 delete mode 100644 arch/arm/plat-spear/include/plat/padmux.h
 create mode 100644 arch/arm/plat-spear/include/plat/pl080.h
 delete mode 100644 arch/arm/plat-spear/padmux.c
 create mode 100644 arch/arm/plat-spear/pl080.c
 create mode 100644 drivers/pinctrl/spear/Kconfig
 create mode 100644 drivers/pinctrl/spear/Makefile
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear.h
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear300.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear310.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear320.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear3xx.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear3xx.h

--
viresh
