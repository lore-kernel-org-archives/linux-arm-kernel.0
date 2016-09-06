From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  6 Sep 2016 14:53:25 +0200
Subject: [PATCH] ARM: imx: build cpuidle-imx6sx.o for imx6ul
Message-ID: <20160906125338.1530603-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6ul soc code gained support for cpuidle, but that causes
a link failure if CONFIG_SOC_IMX6SX is disabled:

arch/arm/mach-imx/mach-imx6ul.o: In function `imx6ul_init_late':
mach-imx6ul.c:(.init.text+0xc): undefined reference to `imx6sx_cpuidle_init'

This adds the file containing the imx6sx_cpuidle_init function
to the kernel for 6ul-only configurations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 547e8f526959 ("ARM: imx: add cpuidle support for i.mx6ul")
---
 arch/arm/mach-imx/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index edce8dfa581d..737450fe790c 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_SOC_IMX5) += cpuidle-imx5.o
 obj-$(CONFIG_SOC_IMX6Q) += cpuidle-imx6q.o
 obj-$(CONFIG_SOC_IMX6SL) += cpuidle-imx6sl.o
 obj-$(CONFIG_SOC_IMX6SX) += cpuidle-imx6sx.o
+obj-$(CONFIG_SOC_IMX6UL) += cpuidle-imx6sx.o
 endif
 
 ifdef CONFIG_SND_IMX_SOC
-- 
2.9.0
