From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 29 May 2014 10:27:14 +0530
Subject: [PATCH 5/5] ARM: imx: Use PTR_ERR_OR_ZERO in mx31moboard-smartbot.c
In-Reply-To: <1401339434-26085-1-git-send-email-sachin.kamat@linaro.org>
References: <1401339434-26085-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1401339434-26085-5-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PTR_ERR_OR_ZERO simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-imx/mx31moboard-smartbot.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mx31moboard-smartbot.c b/arch/arm/mach-imx/mx31moboard-smartbot.c
index 4b3d66eb8d34..b73a4b36e040 100644
--- a/arch/arm/mach-imx/mx31moboard-smartbot.c
+++ b/arch/arm/mach-imx/mx31moboard-smartbot.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -142,10 +143,8 @@ static int __init smartbot_otg_host_init(void)
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
1.7.9.5
