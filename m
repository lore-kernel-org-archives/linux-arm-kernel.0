From: viresh.linux@gmail.com (Viresh Kumar)
Date: Fri, 20 Apr 2012 22:52:40 +0530
Subject: [PATCH 0/9] Add support for SPEAr13xx SoCs
Message-ID: <cover.1334942163.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Sorry for yet another patchset for you :(

This one adds in support for SPEAr1310 and SPEAr1340. It supports:
- DT probing
- pinctrl drivers
- common clock framework

All you requested to get this upstream. :)

I have CC-ed Linus and Mike for their patches and would ask them for their Acks,
as this would evantually make through your ARM-SoC tree.

Few devices/drivers mentioned in dts files have their DT probing patches under
review.

Viresh Kumar (9):
  SPEAr13xx: Add header files
  SPEAr13xx: Add source files
  SPEAr13xx: Add common clock framework support
  pinctrl: SPEAr: Create macro for declaring GPIO PINS
  pinctrl: Add SPEAr13xx pinctrl drivers
  SPEAr13xx: Add dts and dtsi files
  SPEAr13xx: Add compilation support
  SPEAr13xx: Add defconfig
  SPEAr: Update MAINTAINERS and Documentation

 Documentation/arm/SPEAr/overview.txt               |   32 +-
 Documentation/devicetree/bindings/arm/spear.txt    |   14 +-
 .../devicetree/bindings/pinctrl/pinctrl_spear.txt  |   47 +
 MAINTAINERS                                        |   13 +
 arch/arm/Makefile                                  |    2 +
 arch/arm/boot/dts/spear1310-evb.dts                |  267 +++
 arch/arm/boot/dts/spear1310.dtsi                   |  184 ++
 arch/arm/boot/dts/spear1340-evb.dts                |  291 +++
 arch/arm/boot/dts/spear1340.dtsi                   |   56 +
 arch/arm/boot/dts/spear13xx.dtsi                   |  258 +++
 arch/arm/configs/spear13xx_defconfig               |   91 +
 arch/arm/mach-spear13xx/Kconfig                    |   20 +
 arch/arm/mach-spear13xx/Makefile                   |   10 +
 arch/arm/mach-spear13xx/Makefile.boot              |    6 +
 arch/arm/mach-spear13xx/headsmp.S                  |   47 +
 arch/arm/mach-spear13xx/hotplug.c                  |  119 ++
 arch/arm/mach-spear13xx/include/mach/debug-macro.S |   14 +
 arch/arm/mach-spear13xx/include/mach/dma.h         |  128 ++
 arch/arm/mach-spear13xx/include/mach/generic.h     |   49 +
 arch/arm/mach-spear13xx/include/mach/gpio.h        |   19 +
 arch/arm/mach-spear13xx/include/mach/hardware.h    |    1 +
 arch/arm/mach-spear13xx/include/mach/irqs.h        |   23 +
 arch/arm/mach-spear13xx/include/mach/spear.h       |  173 ++
 arch/arm/mach-spear13xx/include/mach/timex.h       |   19 +
 arch/arm/mach-spear13xx/include/mach/uncompress.h  |   19 +
 arch/arm/mach-spear13xx/platsmp.c                  |  127 ++
 arch/arm/mach-spear13xx/spear1310.c                |   88 +
 arch/arm/mach-spear13xx/spear1340.c                |  192 ++
 arch/arm/mach-spear13xx/spear13xx.c                |  210 ++
 arch/arm/plat-spear/Kconfig                        |   12 +
 arch/arm/plat-spear/Makefile                       |    5 +-
 arch/arm/plat-spear/restart.c                      |    5 +
 drivers/clk/spear/Makefile                         |    2 +
 drivers/clk/spear/spear1310_clock.c                | 1051 ++++++++++
 drivers/clk/spear/spear1340_clock.c                |  968 +++++++++
 drivers/pinctrl/spear/Kconfig                      |   10 +
 drivers/pinctrl/spear/Makefile                     |    2 +
 drivers/pinctrl/spear/pinctrl-spear.h              |  251 +++
 drivers/pinctrl/spear/pinctrl-spear1310.c          | 2198 ++++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear1340.c          | 1989 ++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear3xx.c           |  103 +-
 41 files changed, 8989 insertions(+), 126 deletions(-)
 create mode 100644 arch/arm/boot/dts/spear1310-evb.dts
 create mode 100644 arch/arm/boot/dts/spear1310.dtsi
 create mode 100644 arch/arm/boot/dts/spear1340-evb.dts
 create mode 100644 arch/arm/boot/dts/spear1340.dtsi
 create mode 100644 arch/arm/boot/dts/spear13xx.dtsi
 create mode 100644 arch/arm/configs/spear13xx_defconfig
 create mode 100644 arch/arm/mach-spear13xx/Kconfig
 create mode 100644 arch/arm/mach-spear13xx/Makefile
 create mode 100644 arch/arm/mach-spear13xx/Makefile.boot
 create mode 100644 arch/arm/mach-spear13xx/headsmp.S
 create mode 100644 arch/arm/mach-spear13xx/hotplug.c
 create mode 100644 arch/arm/mach-spear13xx/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-spear13xx/include/mach/dma.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/generic.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/gpio.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/hardware.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/irqs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1310_misc_regs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1340_misc_regs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/timex.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-spear13xx/platsmp.c
 create mode 100644 arch/arm/mach-spear13xx/spear1310.c
 create mode 100644 arch/arm/mach-spear13xx/spear1340.c
 create mode 100644 arch/arm/mach-spear13xx/spear13xx.c
 create mode 100644 drivers/clk/spear/spear1310_clock.c
 create mode 100644 drivers/clk/spear/spear1340_clock.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear1310.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear1340.c

-- 
1.7.9
