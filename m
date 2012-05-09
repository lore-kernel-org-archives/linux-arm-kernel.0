From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 9 May 2012 16:44:24 +0530
Subject: [GIT PULL] SPEAr13xx support updates for v-3.5
Message-ID: <1336562064-24407-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

The following changes since commit df8e37e5972dd4ea2a4a0e5dbfdab14b00e98b70:

  SPEAr: Switch to common clock framework (2012-05-09 14:44:57 +0530)

are available in the git repository at:

  git://git.stlinux.com/spear/linux-2.6.git for-v3.5-spear13xx

for you to fetch changes up to 0e74bbef7c071aafb90ab10728197b1f325d1b5c:

  SPEAr: Update MAINTAINERS and Documentation (2012-05-09 14:46:46 +0530)

----------------------------------------------------------------
Viresh Kumar (10):
      SPEAr: Add DT bindings for SPEAr's timer
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
 .../devicetree/bindings/arm/spear-timer.txt        |   18 +
 Documentation/devicetree/bindings/arm/spear.txt    |   14 +-
 .../devicetree/bindings/pinctrl/pinctrl_spear.txt  |   47 +
 MAINTAINERS                                        |   13 +
 arch/arm/Makefile                                  |    2 +
 arch/arm/boot/dts/spear1310-evb.dts                |  267 +++
 arch/arm/boot/dts/spear1310.dtsi                   |  184 ++
 arch/arm/boot/dts/spear1340-evb.dts                |  283 +++
 arch/arm/boot/dts/spear1340.dtsi                   |   56 +
 arch/arm/boot/dts/spear13xx.dtsi                   |  262 +++
 arch/arm/boot/dts/spear3xx.dtsi                    |    6 +
 arch/arm/boot/dts/spear600.dtsi                    |    6 +
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
 arch/arm/mach-spear13xx/include/mach/irqs.h        |   20 +
 arch/arm/mach-spear13xx/include/mach/spear.h       |   62 +
 arch/arm/mach-spear13xx/include/mach/timex.h       |   19 +
 arch/arm/mach-spear13xx/include/mach/uncompress.h  |   19 +
 arch/arm/mach-spear13xx/platsmp.c                  |  127 ++
 arch/arm/mach-spear13xx/spear1310.c                |   88 +
 arch/arm/mach-spear13xx/spear1340.c                |  192 ++
 arch/arm/mach-spear13xx/spear13xx.c                |  197 ++
 arch/arm/mach-spear3xx/include/mach/generic.h      |    2 +-
 arch/arm/mach-spear3xx/include/mach/irqs.h         |    1 -
 arch/arm/mach-spear3xx/include/mach/spear.h        |    1 -
 arch/arm/mach-spear3xx/spear3xx.c                  |    2 +-
 arch/arm/mach-spear6xx/include/mach/generic.h      |    2 +-
 arch/arm/mach-spear6xx/include/mach/irqs.h         |    3 -
 arch/arm/mach-spear6xx/include/mach/spear.h        |    1 -
 arch/arm/mach-spear6xx/spear6xx.c                  |    2 +-
 arch/arm/plat-spear/Kconfig                        |   12 +
 arch/arm/plat-spear/Makefile                       |    5 +-
 arch/arm/plat-spear/restart.c                      |    5 +
 arch/arm/plat-spear/time.c                         |   31 +-
 drivers/clk/spear/Makefile                         |    2 +
 drivers/clk/spear/spear1310_clock.c                | 1106 ++++++++++
 drivers/clk/spear/spear1340_clock.c                |  964 +++++++++
 drivers/pinctrl/spear/Kconfig                      |   10 +
 drivers/pinctrl/spear/Makefile                     |    2 +
 drivers/pinctrl/spear/pinctrl-spear.h              |  251 +++
 drivers/pinctrl/spear/pinctrl-spear1310.c          | 2198 ++++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear1340.c          | 1989 ++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear3xx.c           |  103 +-
 53 files changed, 8965 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/spear-timer.txt
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
