From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 1 Mar 2011 16:57:28 +0530
Subject: [PATCH V6 00/17] Adding devices support for all spear machines
Message-ID: <cover.1298977727.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds device drivers and their machine support for all SPEAr
Families.

Note: These patches were earlier sent as part of a larger patchset:
"Updating SPEAr Support"

Now it is divided into smaller patchsets. In order to apply these patches
cleanly following order of patchsets must be maintained.
- SPEAr3xx & SPEAr6xx Fixes
- SPEAr3xx & SPEAr6xx: Single Image solution and padmux updates
- Adding SPEAr13xx support
- Adding devices support for all spear machines
- Clock Framework & CPU Freq Updates

Deepak Sikri (2):
  ST SPEAr: Adding machine support for USB host
  ST SPEAr Power Management: Added the support for Standby mode.

Pratyush Anand (1):
  ST SPEAr13xx: Added PCIe host controller base driver support.

Rajeev Kumar (3):
  ST SPEAr: Adding machine support for rtc-spear
  ST SPEAr: adding support for synopsis i2c designware
  ST SPEAr: Adding machine support for keyboard

Vipin Kumar (2):
  ST SPEAr3xx: EMI (External Memory Interface) controller driver
  ST SPEAr: Adding machine support for nand

Viresh Kumar (9):
  ST SPEAr13xx: Added ARM PL061 GPIO Support
  ST SPEAr: Adding PLGPIO driver for spear platform
  ST SPEAr3xx: Adding support for ST's PWM IP
  ST SPEAr: Adding Watchdog support on spear3xx & spear6xx machines
  ST SPEAr3xx: Adding RAS uart devices
  ST SPEAr320: Adding support for CAN
  ST SPEAr: Adding support for SSP PL022
  ST SPEAr: Adding support for SDHCI (SDIO)
  ST SPEAr: Updating defconfigs

 arch/arm/Kconfig                                |    1 +
 arch/arm/configs/spear13xx_defconfig            |   78 ++-
 arch/arm/configs/spear3xx_defconfig             |   80 ++-
 arch/arm/configs/spear6xx_defconfig             |   72 ++-
 arch/arm/mach-spear13xx/Makefile                |    2 +
 arch/arm/mach-spear13xx/include/mach/generic.h  |   15 +
 arch/arm/mach-spear13xx/include/mach/gpio.h     |   18 +
 arch/arm/mach-spear13xx/include/mach/hardware.h |    7 +
 arch/arm/mach-spear13xx/include/mach/irqs.h     |   27 +-
 arch/arm/mach-spear13xx/include/mach/pcie.h     |  170 +++++
 arch/arm/mach-spear13xx/include/mach/suspend.h  |   47 ++
 arch/arm/mach-spear13xx/pcie.c                  |  861 +++++++++++++++++++++++
 arch/arm/mach-spear13xx/pm.c                    |  107 +++
 arch/arm/mach-spear13xx/sleep.S                 |  435 ++++++++++++
 arch/arm/mach-spear13xx/spear1300_evb.c         |   90 +++
 arch/arm/mach-spear13xx/spear1310.c             |   22 +
 arch/arm/mach-spear13xx/spear1310_evb.c         |   91 +++
 arch/arm/mach-spear13xx/spear13xx.c             |  355 ++++++++++
 arch/arm/mach-spear3xx/Makefile                 |    4 +
 arch/arm/mach-spear3xx/emi.c                    |   98 +++
 arch/arm/mach-spear3xx/include/mach/emi.h       |   61 ++
 arch/arm/mach-spear3xx/include/mach/generic.h   |   35 +
 arch/arm/mach-spear3xx/include/mach/gpio.h      |  143 ++++
 arch/arm/mach-spear3xx/include/mach/spear310.h  |    9 +
 arch/arm/mach-spear3xx/include/mach/spear320.h  |    6 +
 arch/arm/mach-spear3xx/include/mach/suspend.h   |   44 ++
 arch/arm/mach-spear3xx/spear300.c               |  146 ++++
 arch/arm/mach-spear3xx/spear300_evb.c           |   85 +++
 arch/arm/mach-spear3xx/spear310.c               |  155 ++++
 arch/arm/mach-spear3xx/spear310_evb.c           |  102 +++
 arch/arm/mach-spear3xx/spear320.c               |  216 ++++++
 arch/arm/mach-spear3xx/spear320_evb.c           |   92 +++
 arch/arm/mach-spear3xx/spear3xx.c               |  168 +++++-
 arch/arm/mach-spear6xx/include/mach/generic.h   |   10 +
 arch/arm/mach-spear6xx/include/mach/gpio.h      |   27 +
 arch/arm/mach-spear6xx/include/mach/suspend.h   |   44 ++
 arch/arm/mach-spear6xx/spear600_evb.c           |   37 +
 arch/arm/mach-spear6xx/spear6xx.c               |  260 +++++++-
 arch/arm/plat-spear/Kconfig                     |    9 +
 arch/arm/plat-spear/Makefile                    |   17 +
 arch/arm/plat-spear/i2c_eval_board.c            |   29 +
 arch/arm/plat-spear/include/plat/gpio.h         |   35 +
 arch/arm/plat-spear/include/plat/keyboard.h     |    7 -
 arch/arm/plat-spear/include/plat/spi.h          |   74 ++
 arch/arm/plat-spear/plgpio.c                    |  473 +++++++++++++
 arch/arm/plat-spear/pm.c                        |  104 +++
 arch/arm/plat-spear/pwm.c                       |  484 +++++++++++++
 arch/arm/plat-spear/sleep.S                     |  288 ++++++++
 48 files changed, 5711 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/mach-spear13xx/include/mach/pcie.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/suspend.h
 create mode 100644 arch/arm/mach-spear13xx/pcie.c
 create mode 100644 arch/arm/mach-spear13xx/pm.c
 create mode 100644 arch/arm/mach-spear13xx/sleep.S
 create mode 100644 arch/arm/mach-spear3xx/emi.c
 create mode 100644 arch/arm/mach-spear3xx/include/mach/emi.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/suspend.h
 create mode 100644 arch/arm/mach-spear6xx/include/mach/suspend.h
 create mode 100644 arch/arm/plat-spear/i2c_eval_board.c
 create mode 100644 arch/arm/plat-spear/include/plat/spi.h
 create mode 100644 arch/arm/plat-spear/plgpio.c
 create mode 100644 arch/arm/plat-spear/pm.c
 create mode 100644 arch/arm/plat-spear/pwm.c
 create mode 100644 arch/arm/plat-spear/sleep.S

-- 
1.7.2.2
