From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Apr 2016 18:37:49 -0700
Subject: [PATCH] ARM: pxa: Remove CLK_IS_ROOT
Message-ID: <1461116269-2555-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-pxa/eseries.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index e838b11fb8c7..fa9d71d194f0 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -128,7 +128,7 @@ struct resource eseries_tmio_resources[] = {
 /* Some e-series hardware cannot control the 32K clock */
 static void __init __maybe_unused eseries_register_clks(void)
 {
-	clk_register_fixed_rate(NULL, "CLK_CK32K", NULL, CLK_IS_ROOT, 32768);
+	clk_register_fixed_rate(NULL, "CLK_CK32K", NULL, 0, 32768);
 }
 
 #ifdef CONFIG_MACH_E330
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
