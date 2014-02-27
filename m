From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 27 Feb 2014 16:42:44 +0800
Subject: [PATCH 2/3] ARM: imx6: rename pm-imx6q.c to pm-imx6.c
In-Reply-To: <1393490565-26387-1-git-send-email-shawn.guo@linaro.org>
References: <1393490565-26387-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1393490565-26387-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pm-imx6q.c works for all i.MX6 SoCs, so let's rename it to pm-imx6.c
and have the build controlled by option CONFIG_SOC_IMX6.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Makefile                  |    4 +---
 arch/arm/mach-imx/{pm-imx6q.c => pm-imx6.c} |    0
 2 files changed, 1 insertion(+), 3 deletions(-)
 rename arch/arm/mach-imx/{pm-imx6q.c => pm-imx6.c} (100%)

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 9c776a0..19a6d0e 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -104,9 +104,7 @@ obj-$(CONFIG_SOC_IMX6SL) += clk-imx6sl.o mach-imx6sl.o
 
 AFLAGS_suspend-imx6.o :=-Wa,-march=armv7-a
 obj-$(CONFIG_SUSPEND) += suspend-imx6.o
-obj-$(CONFIG_SOC_IMX6Q) += pm-imx6q.o
-# i.MX6SL reuses i.MX6Q code
-obj-$(CONFIG_SOC_IMX6SL) += pm-imx6q.o
+obj-$(CONFIG_SOC_IMX6) += pm-imx6.o
 
 # i.MX5 based machines
 obj-$(CONFIG_MACH_MX51_BABBAGE) += mach-mx51_babbage.o
diff --git a/arch/arm/mach-imx/pm-imx6q.c b/arch/arm/mach-imx/pm-imx6.c
similarity index 100%
rename from arch/arm/mach-imx/pm-imx6q.c
rename to arch/arm/mach-imx/pm-imx6.c
-- 
1.7.9.5
