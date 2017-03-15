From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Wed, 15 Mar 2017 12:23:58 +0100
Subject: [PATCH] clk: sunxi-ng: Fix div/mult settings for osc12M on A64
Message-ID: <1489577038-34773-1-git-send-email-philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mult/div for osc12M was previously backwards (giving a 48M rate
for osc12M). Fix it.

X-AffectedPlatforms: A64-uQ7
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Tested-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index e3c084c..f54114c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -566,7 +566,7 @@ static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 			     0x1a0, 0, 3, BIT(31), CLK_SET_RATE_PARENT);
 
 /* Fixed Factor clocks */
-static CLK_FIXED_FACTOR(osc12M_clk, "osc12M", "osc24M", 1, 2, 0);
+static CLK_FIXED_FACTOR(osc12M_clk, "osc12M", "osc24M", 2, 1, 0);
 
 /* We hardcode the divider to 4 for now */
 static CLK_FIXED_FACTOR(pll_audio_clk, "pll-audio",
-- 
1.9.1
