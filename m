From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 22 May 2017 14:25:48 +0800
Subject: [PATCH 2/6] clk: sunxi-ng: a83t: Fix audio PLL divider offset
In-Reply-To: <20170522062552.19026-1-wens@csie.org>
References: <20170522062552.19026-1-wens@csie.org>
Message-ID: <20170522062552.19026-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The divider of the audio PLL has an offset of 1.
Fix this in the driver.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index a9c5cc87d9d0..947f9f6e05d2 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -80,7 +80,7 @@ static struct ccu_nm pll_audio_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(2),
 	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
-	.m		= _SUNXI_CCU_DIV_OFFSET(0, 6, 0),
+	.m		= _SUNXI_CCU_DIV(0, 6),
 	.common		= {
 		.reg		= SUN8I_A83T_PLL_AUDIO_REG,
 		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
-- 
2.11.0
