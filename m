From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Apr 2016 18:40:04 -0700
Subject: [PATCH] ARM: mv78xx0: Remove CLK_IS_ROOT
Message-ID: <1461116404-3285-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason at lakedaemon.net
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-mv78xx0/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index 99cc93900a24..45a05207b418 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -168,8 +168,7 @@ static struct clk *tclk;
 
 static void __init clk_init(void)
 {
-	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, CLK_IS_ROOT,
-				       get_tclk());
+	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, 0, get_tclk());
 
 	orion_clkdev_init(tclk);
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
