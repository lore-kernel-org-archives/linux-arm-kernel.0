From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:32 +0800
Subject: [PATCH 12/17] ARM: imx53: build in pinctrl support
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-13-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all imx53 boards booting from device tree have pinctrl set up in dts,
it's time to remove the dummy pinctrl state and build in the real imx53
pinctrl support.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig    |    2 ++
 arch/arm/mach-imx/imx53-dt.c |    3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index e4aa082..1afdc67 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -108,6 +108,8 @@ config	SOC_IMX53
 	select ARCH_MX5
 	select ARCH_MX53
 	select HAVE_CAN_FLEXCAN if CAN
+	select PINCTRL
+	select PINCTRL_IMX53
 
 if ARCH_IMX_V4_V5
 
diff --git a/arch/arm/mach-imx/imx53-dt.c b/arch/arm/mach-imx/imx53-dt.c
index 1b7a2fc..7f47391 100644
--- a/arch/arm/mach-imx/imx53-dt.c
+++ b/arch/arm/mach-imx/imx53-dt.c
@@ -17,7 +17,6 @@
 #include <linux/irq.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/pinctrl/machine.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
@@ -78,8 +77,6 @@ static void __init imx53_dt_init(void)
 	const struct of_device_id *of_id;
 	void (*func)(void);
 
-	pinctrl_provide_dummies();
-
 	node = of_find_matching_node(NULL, imx53_iomuxc_of_match);
 	if (node) {
 		of_id = of_match_node(imx53_iomuxc_of_match, node);
-- 
1.7.5.4
