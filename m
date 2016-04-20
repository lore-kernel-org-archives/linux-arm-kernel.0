From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Apr 2016 18:38:50 -0700
Subject: [PATCH] ARM: orion5x: Remove CLK_IS_ROOT
Message-ID: <1461116330-2922-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-orion5x/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 70c3366c8d03..058994e99570 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -66,8 +66,7 @@ static struct clk *tclk;
 
 void __init clk_init(void)
 {
-	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, CLK_IS_ROOT,
-				       orion5x_tclk);
+	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, 0, orion5x_tclk);
 
 	orion_clkdev_init(tclk);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
