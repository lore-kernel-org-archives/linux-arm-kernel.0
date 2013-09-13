From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 13 Sep 2013 12:32:46 +0100
Subject: [PATCH] drivers: cpuidle: rename ARM big.LITTLE driver config and
 makefile entries
Message-ID: <1379071966-26757-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the reorganization of CPU idle drivers configurations into an ARM
specific Kconfig, the existing idle drivers Kconfig entries were renamed and
moved to the Kconfig.arm file. Makefile entries were updated accordingly.

This patch renames the entries in Kconfig.arm and makefile to make the newly
added big.LITTLE CPUidle driver compliant with the new naming convention.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/Kconfig.arm | 2 +-
 drivers/cpuidle/Makefile    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e36603..ea0f045 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -27,7 +27,7 @@ config ARM_U8500_CPUIDLE
 	help
 	  Select this to enable cpuidle for ST-E u8500 processors
 
-config CPU_IDLE_BIG_LITTLE
+config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
 	depends on ARCH_VEXPRESS_TC2_PM
 	select ARM_CPU_SUSPEND
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index cea5ef5..3c693c2 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -11,4 +11,4 @@ obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
-obj-$(CONFIG_CPU_IDLE_BIG_LITTLE)	+= cpuidle-big_little.o
+obj-$(CONFIG_ARM_BIG_LITTLE_CPUIDLE)	+= cpuidle-big_little.o
-- 
1.8.2.2
