From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Fri, 27 Jun 2014 15:25:11 +0200
Subject: [PATCH v2 14/14] drivers: clk: st: Use round to closest divider flag
In-Reply-To: <1403875511-7710-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1403875511-7710-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1403875511-7710-15-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses CLK_DIVIDER_ROUND_CLOSEST flag to specify
the divider has to round to closest div.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Acked-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/clk/st/clkgen-mux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index 9bdedc8..79dc40b 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -774,7 +774,8 @@ void __init st_of_clkgen_vcc_setup(struct device_node *np)
 		div->reg = reg + VCC_DIV_OFFSET;
 		div->shift = 2 * i;
 		div->width = 2;
-		div->flags = CLK_DIVIDER_POWER_OF_TWO;
+		div->flags = CLK_DIVIDER_POWER_OF_TWO |
+			CLK_DIVIDER_ROUND_CLOSEST;
 
 		mux->reg = reg + VCC_MUX_OFFSET;
 		mux->shift = 2 * i;
-- 
1.9.1
