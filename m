From: avinashphilip@ti.com (Philip Avinash)
Date: Tue, 19 Feb 2013 18:20:16 +0530
Subject: [PATCH v3 0/3] suspend/resume support for OMAP nand driver
Message-ID: <1361278219-23108-1-git-send-email-avinashphilip@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds low power transition support for OMAP NAND driver.
With recent driver conversion of GPMC to platform_driver, pm_runtime calls
can be used to handle module enable & disable of GPMC. This is taken care
patch #1.

patch #2 is for GPMC suspend/resume support.

This includes low power transition support of
- GPMC module
- ELM module

User initiated suspend/resume sequence tested on am335x-evm with NAND
flash support. Also tested in omap3-evm for user initiated
suspend/resume sequence with NAND flash.
This patch series based on [1] and is present in [2].

1. ARM: OMAP2+: AM33XX: Add suspend-resume support
   http://comments.gmane.org/gmane.linux.ports.arm.omap/91405
2. https://github.com/avinashphilip/am335x_linux/commits/NAND_supend_resume_support

Changes Since v2:
- Remove calll back of nand_suspend from omap2 nand driver, as the same call already
  done from suspend activity mtd class driver.

Philip Avinash (3):
  arm: gpmc: Converts GPMC driver to pm_runtime capable
  arm: gpmc: Low power transition support
  mtd: devices: elm: Low power transition support

 arch/arm/mach-omap2/gpmc.c |   30 +++++++++++++++++++++---
 drivers/mtd/devices/elm.c  |   54 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 3 deletions(-)

-- 
1.7.9.5
