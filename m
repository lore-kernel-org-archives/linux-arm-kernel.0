From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 14:53:51 +0530
Subject: [PATCH V2 4/7] Clk : SPEAr13xx: Register con_id for Ethernet phy clks
In-Reply-To: <cover.1342171151.git.vipulkumar.samar@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
Message-ID: <1edacddddd5d29111c611c779f0756cf779a240c.1342171151.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On kernel-3.5 stmmac Ethernet phy is not register as a separate device. So this
patch is to register con_id for phy clk.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Acked-by: Viiresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/spear1310_clock.c |   10 +++++-----
 drivers/clk/spear/spear1340_clock.c |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index 3d83ffc..a711662 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -619,7 +619,7 @@ void __init spear1310_clk_init(void)
 			ARRAY_SIZE(gmac_phy_parents), 0,
 			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GMAC_PHY_CLK_SHIFT,
 			SPEAR1310_GMAC_PHY_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "stmmacphy.0");
+	clk_register_clkdev(clk, "stmmacphy.0", NULL);
 
 	/* clcd */
 	clk = clk_register_mux(NULL, "clcd_syn_mclk", clcd_synth_parents,
@@ -920,15 +920,15 @@ void __init spear1310_clk_init(void)
 			SPEAR1310_RAS_CTRL_REG1,
 			SPEAR1310_SMII_RGMII_PHY_CLK_SHIFT,
 			SPEAR1310_PHY_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "stmmacphy.1");
-	clk_register_clkdev(clk, NULL, "stmmacphy.2");
-	clk_register_clkdev(clk, NULL, "stmmacphy.4");
+	clk_register_clkdev(clk, "stmmacphy.1", NULL);
+	clk_register_clkdev(clk, "stmmacphy.2", NULL);
+	clk_register_clkdev(clk, "stmmacphy.4", NULL);
 
 	clk = clk_register_mux(NULL, "rmii_phy_mclk", rmii_phy_parents,
 			ARRAY_SIZE(rmii_phy_parents), 0,
 			SPEAR1310_RAS_CTRL_REG1, SPEAR1310_RMII_PHY_CLK_SHIFT,
 			SPEAR1310_PHY_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "stmmacphy.3");
+	clk_register_clkdev(clk, "stmmacphy.3", NULL);
 
 	clk = clk_register_mux(NULL, "uart1_mclk", uart_parents,
 			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 7815cbd..2cd5520 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -683,7 +683,7 @@ void __init spear1340_clk_init(void)
 			ARRAY_SIZE(gmac_phy_parents), 0,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GMAC_PHY_CLK_SHIFT,
 			SPEAR1340_GMAC_PHY_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "stmmacphy.0");
+	clk_register_clkdev(clk, "stmmacphy.0", NULL);
 
 	/* clcd */
 	clk = clk_register_mux(NULL, "clcd_syn_mclk", clcd_synth_parents,
-- 
1.7.2.2
