From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:38 +0530
Subject: [PATCH 00/14] ux500 re-org and U5500 support
Message-ID: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series reorganizes the ux500 files to allow sharing of
code between different SoCs in the Ux500 family, and adds
basic support for U5500.

Rabin Vincent (14):
  ux500: add SOC Kconfig variables
  ux500: add per-SoC register definitions
  ux500: allow choice of the DEBUG_LL UART
  ux500: move irq and common maps to cpu.c
  ux500: move gpio macros to common header
  ux500: put common devices into devices.c
  ux500: put DB8500-specific devices in devices-db8500.c
  ux500: move UART devices to devices.c
  ux500: reorganize i2c devices
  ux500: move gpio devices to devices-db8500.c
  ux500: move sys_timer to cpu.c
  ux500: use UX500_* macros instead of U8500_*
  ux500: rename cpu-u8500.c to cpu-db8500.c
  ux500: add U5500 support

 arch/arm/mach-ux500/Kconfig                    |   40 ++++-
 arch/arm/mach-ux500/Makefile                   |    6 +-
 arch/arm/mach-ux500/board-mop500.c             |  116 +++-----------
 arch/arm/mach-ux500/board-u5500.c              |   41 +++++
 arch/arm/mach-ux500/clock.c                    |    4 +
 arch/arm/mach-ux500/cpu-db5500.c               |   50 ++++++
 arch/arm/mach-ux500/cpu-db8500.c               |   78 +++++++++
 arch/arm/mach-ux500/cpu-u8500.c                |  202 ------------------------
 arch/arm/mach-ux500/cpu.c                      |   99 ++++++++++++
 arch/arm/mach-ux500/devices-db5500.c           |   46 ++++++
 arch/arm/mach-ux500/devices-db8500.c           |  107 +++++++++++++
 arch/arm/mach-ux500/devices.c                  |   88 ++++++++++
 arch/arm/mach-ux500/include/mach/db5500-regs.h |  103 ++++++++++++
 arch/arm/mach-ux500/include/mach/db8500-regs.h |  135 ++++++++++++++++
 arch/arm/mach-ux500/include/mach/debug-macro.S |   12 ++-
 arch/arm/mach-ux500/include/mach/devices.h     |   29 ++++
 arch/arm/mach-ux500/include/mach/entry-macro.S |    2 +-
 arch/arm/mach-ux500/include/mach/gpio.h        |   38 +++++
 arch/arm/mach-ux500/include/mach/hardware.h    |  196 ++++++++++--------------
 arch/arm/mach-ux500/include/mach/irqs.h        |    1 +
 arch/arm/mach-ux500/include/mach/setup.h       |   23 +++-
 arch/arm/mach-ux500/platsmp.c                  |   10 +-
 22 files changed, 991 insertions(+), 435 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-u5500.c
 create mode 100644 arch/arm/mach-ux500/cpu-db5500.c
 create mode 100644 arch/arm/mach-ux500/cpu-db8500.c
 delete mode 100644 arch/arm/mach-ux500/cpu-u8500.c
 create mode 100644 arch/arm/mach-ux500/cpu.c
 create mode 100644 arch/arm/mach-ux500/devices-db5500.c
 create mode 100644 arch/arm/mach-ux500/devices-db8500.c
 create mode 100644 arch/arm/mach-ux500/devices.c
 create mode 100644 arch/arm/mach-ux500/include/mach/db5500-regs.h
 create mode 100644 arch/arm/mach-ux500/include/mach/db8500-regs.h
 create mode 100644 arch/arm/mach-ux500/include/mach/devices.h
