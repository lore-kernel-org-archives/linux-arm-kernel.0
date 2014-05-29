From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 29 May 2014 10:27:11 +0530
Subject: [PATCH 2/5] ARM: imx: Use PTR_ERR_OR_ZERO in mach-mx31moboard.c
In-Reply-To: <1401339434-26085-1-git-send-email-sachin.kamat@linaro.org>
References: <1401339434-26085-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1401339434-26085-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PTR_ERR_OR_ZERO simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-imx/mach-mx31moboard.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/mach-mx31moboard.c
index 6bed57040973..bb6f8a52a6b8 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -435,10 +435,8 @@ static int __init moboard_usbh2_init(void)
 		return -ENODEV;
 
 	pdev = imx31_add_mxc_ehci_hs(2, &usbh2_pdata);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(pdev);
 }
 
 static const struct gpio_led mx31moboard_leds[] __initconst = {
-- 
1.7.9.5
