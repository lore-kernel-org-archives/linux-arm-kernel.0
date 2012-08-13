From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Aug 2012 21:05:27 +0800
Subject: [PATCH 07/17] ARM: imx6q: remove dummy pinctrl state
In-Reply-To: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
References: <1344863137-6112-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1344863137-6112-8-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all imx6q boards have pinctrl set up in device tree, it's time to
remove the dummy pinctrl state.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/mach-imx6q.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 5ec0608..946cfcc 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -22,7 +22,6 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
-#include <linux/pinctrl/machine.h>
 #include <linux/phy.h>
 #include <linux/micrel_phy.h>
 #include <linux/mfd/anatop.h>
@@ -159,12 +158,6 @@ static void __init imx6q_usb_init(void)
 
 static void __init imx6q_init_machine(void)
 {
-	/*
-	 * This should be removed when all imx6q boards have pinctrl
-	 * states for devices defined in device tree.
-	 */
-	pinctrl_provide_dummies();
-
 	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
 		imx6q_sabrelite_init();
 
-- 
1.7.5.4
