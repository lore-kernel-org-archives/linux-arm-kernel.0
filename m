From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 29 May 2014 10:27:12 +0530
Subject: [PATCH 3/5] ARM: imx: Use PTR_ERR_OR_ZERO in mx31moboard-devboard.c
In-Reply-To: <1401339434-26085-1-git-send-email-sachin.kamat@linaro.org>
References: <1401339434-26085-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1401339434-26085-3-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PTR_ERR_OR_ZERO simplifies the code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-imx/mx31moboard-devboard.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mx31moboard-devboard.c b/arch/arm/mach-imx/mx31moboard-devboard.c
index 1e4ea1640a2a..a85377f52647 100644
--- a/arch/arm/mach-imx/mx31moboard-devboard.c
+++ b/arch/arm/mach-imx/mx31moboard-devboard.c
@@ -12,6 +12,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -214,10 +215,8 @@ static int __init devboard_usbh1_init(void)
 	usbh1_pdata.otg = phy;
 
 	pdev = imx31_add_mxc_ehci_hs(1, &usbh1_pdata);
-	if (IS_ERR(pdev))
-		return PTR_ERR(pdev);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(pdev);
 }
 
 
-- 
1.7.9.5
