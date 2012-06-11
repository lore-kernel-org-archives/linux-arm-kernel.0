From: rubini@gnudd.com (Alessandro Rubini)
Date: Mon, 11 Jun 2012 22:56:14 +0200
Subject: [PATCH V3 0/3] i2c-nomadik changes
Message-ID: <cover.1339447570.git.rubini@gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V3:
	- fixed according to Linusw feedback (merged the patch he posted)
	- added Tested-by: Linusw on his permission

V2:
        - use linux/platform_data/i2c-nomadik.h not linux/i2c-nomadik.h
        - format patch with -M
        - added lee jones to the Cc: list (for device tree support)
        - minor rewording of the commit messages


Alessandro Rubini (3):
  i2c-nomadik: move header to <linux/platform_data/i2c-nomadik.h>
  i2c-nomadik: turn the platform driver to an amba driver
  i2c-nomadik: depend on ARM_AMBA, not PLAT_NOMADIK

 arch/arm/mach-ux500/board-mop500.c                 |    2 +-
 arch/arm/mach-ux500/devices-common.h               |   24 +---
 drivers/i2c/busses/Kconfig                         |    5 +-
 drivers/i2c/busses/i2c-nomadik.c                   |  145 ++++++++++----------
 .../linux/platform_data/i2c-nomadik.h              |    6 +-
 5 files changed, 87 insertions(+), 95 deletions(-)
 rename arch/arm/plat-nomadik/include/plat/i2c.h => include/linux/platform_data/i2c-nomadik.h (91%)

-- 
1.7.7.2
