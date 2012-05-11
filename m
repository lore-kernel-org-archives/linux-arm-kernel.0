From: sr@denx.de (Stefan Roese)
Date: Fri, 11 May 2012 10:41:18 +0200
Subject: [PATCH] clk: SPEAr600: Fix ethernet clock name for DT based probing
Message-ID: <1336725678-29327-1-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: "Mike Turquette" <mturquette@ti.com>
---
 drivers/clk/spear/spear6xx_clock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index f9a20b3..bf33c1d 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -298,7 +298,7 @@ void __init spear6xx_clk_init(void)
 
 	clk = clk_register_gate(NULL, "gmac_clk", "ahb_clk", 0, PERIP1_CLK_ENB,
 			GMAC_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "gmac");
+	clk_register_clkdev(clk, NULL, "e0800000.ethernet");
 
 	clk = clk_register_gate(NULL, "i2c_clk", "ahb_clk", 0, PERIP1_CLK_ENB,
 			I2C_CLK_ENB, 0, &_lock);
-- 
1.7.10.1
