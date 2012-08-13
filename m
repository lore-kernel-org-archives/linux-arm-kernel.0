From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:37 +0800
Subject: [PATCH 17/17] ARM: imx51: build in pinctrl support
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-18-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the imx51 DT board having pinctrl setup define in device tree,
it's time to remove dummy pinctrl state and build in the real imx51
pinctrl support.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/Kconfig    |    2 ++
 arch/arm/mach-imx/imx51-dt.c |    3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 374fcc2..7ca5fe4 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -101,6 +101,8 @@ config	SOC_IMX51
 	select SOC_IMX5
 	select ARCH_MX5
 	select ARCH_MX51
+	select PINCTRL
+	select PINCTRL_IMX51
 
 if ARCH_IMX_V4_V5
 
diff --git a/arch/arm/mach-imx/imx51-dt.c b/arch/arm/mach-imx/imx51-dt.c
index d4067fe..f5261e6 100644
--- a/arch/arm/mach-imx/imx51-dt.c
+++ b/arch/arm/mach-imx/imx51-dt.c
@@ -13,7 +13,6 @@
 #include <linux/irq.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/pinctrl/machine.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
@@ -55,8 +54,6 @@ static void __init imx51_dt_init(void)
 	const struct of_device_id *of_id;
 	void (*func)(void);
 
-	pinctrl_provide_dummies();
-
 	node = of_find_matching_node(NULL, imx51_iomuxc_of_match);
 	if (node) {
 		of_id = of_match_node(imx51_iomuxc_of_match, node);
-- 
1.7.5.4
