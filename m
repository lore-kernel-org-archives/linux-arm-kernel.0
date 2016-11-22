From: eric@anholt.net (Eric Anholt)
Date: Tue, 22 Nov 2016 12:45:28 -0800
Subject: [PATCH] clk: bcm2835: Fix ->fixed_divider of pllh_aux
Message-ID: <20161122204528.18435-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

There is no fixed divider on pllh_aux.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Eric Anholt <eric@anholt.net>
---

This was copy and paste failure on my (anholt's) part.  The divider of
10 is on PLLH_PIX.  No need to worry about backporting, as this
channel is only used for the VEC support I'm hoping to land for
4.11.

 drivers/clk/bcm/clk-bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index b68bf573dcfb..82568bfe5a72 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1599,7 +1599,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.a2w_reg = A2W_PLLH_AUX,
 		.load_mask = CM_PLLH_LOADAUX,
 		.hold_mask = 0,
-		.fixed_divider = 10),
+		.fixed_divider = 1),
 	[BCM2835_PLLH_PIX]	= REGISTER_PLL_DIV(
 		.name = "pllh_pix",
 		.source_pll = "pllh",
-- 
2.10.2
