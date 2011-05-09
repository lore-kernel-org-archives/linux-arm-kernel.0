From: grinberg@compulab.co.il (Igor Grinberg)
Date: Mon,  9 May 2011 14:41:48 +0300
Subject: [PATCH 3/4] arm: pxa3xx: cm-x300: minor style cleanup
In-Reply-To: <1304941309-13288-1-git-send-email-grinberg@compulab.co.il>
References: <1304941309-13288-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1304941309-13288-3-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

introduce pr_fmt, so the pr_* calls will be cleaner

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-pxa/cm-x300.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 880df33..b199596 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -12,6 +12,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#define pr_fmt(fmt) "%s: " fmt, __func__
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -487,8 +488,7 @@ static int cm_x300_ulpi_phy_reset(void)
 	err = gpio_request_one(GPIO_ULPI_PHY_RST, GPIOF_OUT_INIT_LOW,
 			       "ulpi reset");
 	if (err) {
-		pr_err("%s: failed to request ULPI reset GPIO: %d\n",
-		       __func__, err);
+		pr_err("failed to request ULPI reset GPIO: %d\n", err);
 		return err;
 	}
 
@@ -510,8 +510,7 @@ static inline int cm_x300_u2d_init(struct device *dev)
 		pout_clk = clk_get(NULL, "CLK_POUT");
 		if (IS_ERR(pout_clk)) {
 			err = PTR_ERR(pout_clk);
-			pr_err("%s: failed to get CLK_POUT: %d\n",
-			       __func__, err);
+			pr_err("failed to get CLK_POUT: %d\n", err);
 			return err;
 		}
 		clk_enable(pout_clk);
@@ -787,7 +786,7 @@ static void __init cm_x300_init_wi2wi(void)
 	/* Libertas and CSR reset */
 	err = gpio_request_array(ARRAY_AND_SIZE(cm_x300_wi2wi_gpios));
 	if (err) {
-		pr_err("CM-X300: failed to request wifi/bt gpios: %d\n", err);
+		pr_err("failed to request wifi/bt gpios: %d\n", err);
 		return;
 	}
 
-- 
1.7.3.4
