From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 21 Nov 2018 12:19:22 +0100
Subject: [PATCH] clk: meson: Fix GXL HDMI PLL fractional bits width
Message-ID: <20181121111922.1277-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GXL Documentation specifies 12 bits for the Fractional bit field,
bit the last bits have a different purpose that we cannot handle right
now, so update the bitwidth to have correct fractional calculations.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/gxbb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 30fbf8f1f190..aba59aa64d2b 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -219,7 +219,7 @@ static struct clk_regmap gxl_hdmi_pll_dco = {
 		.frac = {
 			.reg_off = HHI_HDMI_PLL_CNTL2,
 			.shift   = 0,
-			.width   = 12,
+			.width   = 10,
 		},
 		.l = {
 			.reg_off = HHI_HDMI_PLL_CNTL,
-- 
2.19.1
