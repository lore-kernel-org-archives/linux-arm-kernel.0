From: fabf@skynet.be (Fabian Frederick)
Date: Fri,  4 Jul 2014 21:03:10 +0200
Subject: [PATCH 1/1] ARM: imx: use PTR_ERR_OR_ZERO
Message-ID: <1404500590-21712-1-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

replace IS_ERR/PTR_ERR

Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---

This is untested.

 arch/arm/mach-imx/devices/platform-mxc_rnga.c | 5 +----
 arch/arm/mach-imx/mach-mx31moboard.c          | 4 +---
 arch/arm/mach-imx/mx31moboard-devboard.c      | 4 +---
 arch/arm/mach-imx/mx31moboard-marxbot.c       | 4 +---
 arch/arm/mach-imx/mx31moboard-smartbot.c      | 4 +---
 5 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/devices/platform-mxc_rnga.c b/arch/arm/mach-imx/devices/platform-mxc_rnga.c
index c58404b..851fbc8a 100644
--- a/arch/arm/mach-imx/devices/platform-mxc_rnga.c
+++ b/arch/arm/mach-imx/devices/platform-mxc_rnga.c
@@ -48,9 +48,6 @@ static int __init imxXX_add_mxc_rnga(void)
 #endif /* if defined(CONFIG_SOC_IMX31) */
 		ret = ERR_PTR(-ENODEV);
 
-	if (IS_ERR(ret))
-		return PTR_ERR(ret);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(ret);
 }
 arch_initcall(imxXX_add_mxc_rnga);
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 08730f2..7839efa 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -434,10 +434,8 @@ static int __init moboard_usbh2_init(void)
 		return -ENODEV;
 
 	pdev = imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(pdev);
 }
 
 static const struct gpio_led mx31moboard_leds[] __initconst = {
diff --git a/arch/arm/mach-imx/mx31moboard-devboard.c b/arch/arm/mach-imx/mx31moboard-devboard.c
index 52d5b15..0636369 100644
--- a/arch/arm/mach-imx/mx31moboard-devboard.c
+++ b/arch/arm/mach-imx/mx31moboard-devboard.c
@@ -213,10 +213,8 @@ static int __init devboard_usbh1_init(void)
 	usbh1_pdata.otg = phy;
 
 	pdev = imx31_add_mxc_ehci_hs(1, &usbh1_pdata);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(pdev);
 }
 
 
diff --git a/arch/arm/mach-imx/mx31moboard-marxbot.c b/arch/arm/mach-imx/mx31moboard-marxbot.c
index a4f43e9..b38d6d8 100644
--- a/arch/arm/mach-imx/mx31moboard-marxbot.c
+++ b/arch/arm/mach-imx/mx31moboard-marxbot.c
@@ -327,10 +327,8 @@ static int __init marxbot_usbh1_init(void)
 	usbh1_pdata.otg = phy;
 
 	pdev = imx31_add_mxc_ehci_hs(1, &usbh1_pdata);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(pdev);
 }
 
 static const struct fsl_usb2_platform_data usb_pdata __initconst = {
diff --git a/arch/arm/mach-imx/mx31moboard-smartbot.c b/arch/arm/mach-imx/mx31moboard-smartbot.c
index 04ae45d..0c6ac75 100644
--- a/arch/arm/mach-imx/mx31moboard-smartbot.c
+++ b/arch/arm/mach-imx/mx31moboard-smartbot.c
@@ -141,10 +141,8 @@ static int __init smartbot_otg_host_init(void)
 		return -ENODEV;
 
 	pdev = imx31_add_mxc_ehci_otg(&otg_host_pdata);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(pdev);
 }
 #else
 static inline int smartbot_otg_host_init(void) { return 0; }
-- 
1.9.1
