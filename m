From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Mar 2018 16:13:18 +0100
Subject: [PATCH 1/2] ARM: imx: fix imx6sll-only build
Message-ID: <20180315151345.3089601-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When selecting SOC_IMX6SLL but not SOC_IMX6SL, we get a link error:

arch/arm/mach-imx/mach-imx6sl.o: In function `imx6sl_init_late':
mach-imx6sl.c:(.init.text+0x14): undefined reference to `imx6sl_cpuidle_init'

This adds the missing line to the Makefile to also build the cpuidle
support that we need here.

Fixes: dee5dee2a5b2 ("ARM: imx: Add basic msl support for imx6sll")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 78fa86aedf34..2327e3e876d8 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -26,6 +26,7 @@ ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
+obj-$(CONFIG_SOC_IMX6SLL) += cpuidle-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
 endif
-- 
2.9.0
