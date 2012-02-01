From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  1 Feb 2012 09:23:40 +0000
Subject: [PATCH 0/6] ux500: Export SoC information and some platform clean-up
Message-ID: <1328088226-29594-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set satisfies 4 objectives:
 1. Ensures each platform device can specify a suitable parent
 2. Provides a bus for SoC devices as a means to export information
 3. Allows ux500 to make use of the new SoC bus
 4. Cleans up unnecessary complexity from ux500 code

---
 Documentation/ABI/testing/sysfs-devices-soc    |   58 ++++++++
 arch/arm/mach-ux500/Kconfig                    |    1 +
 arch/arm/mach-ux500/board-mop500-sdi.c         |   31 ++--
 arch/arm/mach-ux500/board-mop500.c             |   74 ++++++----
 arch/arm/mach-ux500/board-mop500.h             |    8 +-
 arch/arm/mach-ux500/board-u5500-sdi.c          |    4 +-
 arch/arm/mach-ux500/board-u5500.c              |   27 ++--
 arch/arm/mach-ux500/cpu-db5500.c               |   36 ++++-
 arch/arm/mach-ux500/cpu-db8500.c               |   44 +++++-
 arch/arm/mach-ux500/cpu.c                      |   75 ++++++++++
 arch/arm/mach-ux500/devices-common.c           |   79 ++--------
 arch/arm/mach-ux500/devices-common.h           |   83 ++++++-----
 arch/arm/mach-ux500/devices-db5500.h           |  116 +++++++++------
 arch/arm/mach-ux500/devices-db8500.h           |  176 +++++++++++++----------
 arch/arm/mach-ux500/dma-db5500.c               |    3 +-
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    3 +
 arch/arm/mach-ux500/include/mach/setup.h       |   10 +-
 arch/arm/mach-ux500/include/mach/usb.h         |    4 +-
 arch/arm/mach-ux500/usb.c                      |    7 +-
 drivers/base/Kconfig                           |    3 +
 drivers/base/Makefile                          |    1 +
 drivers/base/soc.c                             |  186 ++++++++++++++++++++++++
 include/linux/syssoc.h                         |   74 ++++++++++
 23 files changed, 799 insertions(+), 304 deletions(-)
