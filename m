From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 23:26:52 +0100
Subject: [PATCH 3/9] clk: sunxi: remove stale Makefile entry
In-Reply-To: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
References: <1360880818-4071454-1-git-send-email-arnd@arndb.de>
Message-ID: <1360880818-4071454-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 85a18198 "clk: sunxi: Use common of_clk_init() function"
removed the clk-sunxi.c file but left the Makefile entry, which
causes a build error in multi_v7_defconfig:

make[4]: *** No rule to make target `drivers/clk/clk-sunxi.o', needed by `drivers/clk/built-in.o'.

The obvious fix is to remove the extraneous line from the
Makefile.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: Maxime Ripard <maxime.ripard@anandra.org>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index ce77077..be9392e 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -25,7 +25,6 @@ endif
 obj-$(CONFIG_MACH_LOONGSON1)	+= clk-ls1x.o
 obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
-obj-$(CONFIG_ARCH_SUNXI)	+= clk-sunxi.o
 obj-$(CONFIG_ARCH_ZYNQ)		+= clk-zynq.o
 obj-$(CONFIG_X86)		+= x86/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
-- 
1.8.1.2
