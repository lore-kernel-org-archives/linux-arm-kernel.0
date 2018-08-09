From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Thu,  9 Aug 2018 18:52:17 +0200
Subject: [PATCH 5/5] clk: sunxi-ng: a83t: Add max. rate constraint to video
 PLLs
In-Reply-To: <20180809165217.30680-1-jernej.skrabec@siol.net>
References: <20180809165217.30680-1-jernej.skrabec@siol.net>
Message-ID: <20180809165217.30680-6-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It may happen that clock framework finds optimal video PLL rate above
that which is really supported by HW.

User manual doesn't really say what is upper limit for video PLLs on
A83T. Because of that, use the maximum rate defined in BSP clk driver
which is 3 GHz.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 7d08015b980d..2d6555d73170 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -108,6 +108,7 @@ static struct ccu_nkmp pll_video0_clk = {
 	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.p		= _SUNXI_CCU_DIV(0, 2), /* output divider */
+	.max_rate	= 3000000000UL,
 	.common		= {
 		.reg		= 0x010,
 		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
@@ -220,6 +221,7 @@ static struct ccu_nkmp pll_video1_clk = {
 	.n		= _SUNXI_CCU_MULT_OFFSET_MIN_MAX(8, 8, 0, 12, 0),
 	.m		= _SUNXI_CCU_DIV(16, 1), /* input divider */
 	.p		= _SUNXI_CCU_DIV(0, 2), /* external divider p */
+	.max_rate	= 3000000000UL,
 	.common		= {
 		.reg		= 0x04c,
 		.lock_reg	= CCU_SUN8I_A83T_LOCK_REG,
-- 
2.18.0
