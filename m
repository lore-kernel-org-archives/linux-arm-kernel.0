From: eric@anholt.net (Eric Anholt)
Date: Thu, 10 Sep 2015 14:58:22 -0700
Subject: [PATCH v2 1/4] clk: bcm2835: Move under bcm/ with other Broadcom SoC
 clk drivers.
Message-ID: <1441922305-2298-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk-bcm2835.c predates the drivers under bcm/, but all the new BCM
drivers are going in there so let's follow them.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/clk/Makefile                | 1 -
 drivers/clk/bcm/Makefile            | 1 +
 drivers/clk/{ => bcm}/clk-bcm2835.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/clk/{ => bcm}/clk-bcm2835.c (100%)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index c4cf075..1bdbe9b 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -19,7 +19,6 @@ endif
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
-obj-$(CONFIG_ARCH_BCM2835)		+= clk-bcm2835.o
 obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
 obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
diff --git a/drivers/clk/bcm/Makefile b/drivers/clk/bcm/Makefile
index 8a7a477..ee2349b 100644
--- a/drivers/clk/bcm/Makefile
+++ b/drivers/clk/bcm/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_CLK_BCM_KONA)	+= clk-kona-setup.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm281xx.o
 obj-$(CONFIG_CLK_BCM_KONA)	+= clk-bcm21664.o
 obj-$(CONFIG_COMMON_CLK_IPROC)	+= clk-iproc-armpll.o clk-iproc-pll.o clk-iproc-asiu.o
+obj-$(CONFIG_ARCH_BCM2835)	+= clk-bcm2835.o
 obj-$(CONFIG_ARCH_BCM_CYGNUS)	+= clk-cygnus.o
diff --git a/drivers/clk/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
similarity index 100%
rename from drivers/clk/clk-bcm2835.c
rename to drivers/clk/bcm/clk-bcm2835.c
-- 
2.1.4
