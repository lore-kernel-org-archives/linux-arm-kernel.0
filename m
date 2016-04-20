From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Apr 2016 18:45:48 -0700
Subject: [PATCH] ARM: dove: Remove CLK_IS_ROOT
Message-ID: <1461116748-5444-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
CLK_IS_ROOT", 2016-02-02) so remove it.

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-dove/common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 0cdaa3851d2e..0d420a2bfe3e 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -88,8 +88,7 @@ static void __init dove_clk_init(void)
 	struct clk *nand, *camera, *i2s0, *i2s1, *crypto, *ac97, *pdma;
 	struct clk *xor0, *xor1, *ge, *gephy;
 
-	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, CLK_IS_ROOT,
-				       dove_tclk);
+	tclk = clk_register_fixed_rate(NULL, "tclk", NULL, 0, dove_tclk);
 
 	usb0 = dove_register_gate("usb0", "tclk", CLOCK_GATING_BIT_USB0);
 	usb1 = dove_register_gate("usb1", "tclk", CLOCK_GATING_BIT_USB1);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
