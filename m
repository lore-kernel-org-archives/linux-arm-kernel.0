From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 29 May 2014 10:27:13 +0530
Subject: [PATCH 4/5] ARM: imx: Use PTR_ERR_OR_ZERO in mx31moboard-marxbot.c
In-Reply-To: <1401339434-26085-1-git-send-email-sachin.kamat@linaro.org>
References: <1401339434-26085-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1401339434-26085-4-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PTR_ERR_OR_ZERO simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-imx/mx31moboard-marxbot.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mx31moboard-marxbot.c b/arch/arm/mach-imx/mx31moboard-marxbot.c
index 699d01a4fef8..2e62192394c1 100644
--- a/arch/arm/mach-imx/mx31moboard-marxbot.c
+++ b/arch/arm/mach-imx/mx31moboard-marxbot.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -328,10 +329,8 @@ static int __init marxbot_usbh1_init(void)
 	usbh1_pdata.otg = phy;
 
 	pdev = imx31_add_mxc_ehci_hs(1, &usbh1_pdata);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(pdev);
 }
 
 static const struct fsl_usb2_platform_data usb_pdata __initconst = {
-- 
1.7.9.5
