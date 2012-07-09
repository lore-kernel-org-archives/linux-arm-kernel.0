From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Mon, 9 Jul 2012 16:01:04 +0530
Subject: [PATCH 4/6] Clk: SPEAr13xx: Initialize con_id for Ethernet phy clks
In-Reply-To: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
References: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
Message-ID: <1341829866-26091-4-git-send-email-shiraz.hashim@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 drivers/clk/spear/spear1310_clock.c |   10 +++++-----
 drivers/clk/spear/spear1340_clock.c |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
index 3a246b4..b6a6325 100644
--- a/drivers/clk/spear/spear1310_clock.c
+++ b/drivers/clk/spear/spear1310_clock.c
@@ -621,7 +621,7 @@ void __init spear1310_clk_init(void)
 			ARRAY_SIZE(gmac_phy_parents), 0,
 			SPEAR1310_PERIP_CLK_CFG, SPEAR1310_GMAC_PHY_CLK_SHIFT,
 			SPEAR1310_GMAC_PHY_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "stmmacphy.0");
+	clk_register_clkdev(clk, "stmmacphy.0", NULL);
 
 	/* clcd */
 	clk = clk_register_mux(NULL, "clcd_synth_mux_clk", clcd_synth_parents,
@@ -922,15 +922,15 @@ void __init spear1310_clk_init(void)
 			SPEAR1310_RAS_CTRL_REG1,
 			SPEAR1310_SMII_RGMII_PHY_CLK_SHIFT,
 			SPEAR1310_PHY_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "stmmacphy.1");
-	clk_register_clkdev(clk, NULL, "stmmacphy.2");
-	clk_register_clkdev(clk, NULL, "stmmacphy.4");
+	clk_register_clkdev(clk, "stmmacphy.1", NULL);
+	clk_register_clkdev(clk, "stmmacphy.2", NULL);
+	clk_register_clkdev(clk, "stmmacphy.4", NULL);
 
 	clk = clk_register_mux(NULL, "rmii_phy_mux_clk", rmii_phy_parents,
 			ARRAY_SIZE(rmii_phy_parents), 0,
 			SPEAR1310_RAS_CTRL_REG1, SPEAR1310_RMII_PHY_CLK_SHIFT,
 			SPEAR1310_PHY_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "stmmacphy.3");
+	clk_register_clkdev(clk, "stmmacphy.3", NULL);
 
 	clk = clk_register_mux(NULL, "uart1_mux_clk", uart_parents,
 			ARRAY_SIZE(uart_parents), 0, SPEAR1310_RAS_CTRL_REG0,
diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index a7d5d32..e69c542 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -686,7 +686,7 @@ void __init spear1340_clk_init(void)
 			ARRAY_SIZE(gmac_phy_parents), 0,
 			SPEAR1340_PERIP_CLK_CFG, SPEAR1340_GMAC_PHY_CLK_SHIFT,
 			SPEAR1340_GMAC_PHY_CLK_MASK, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "stmmacphy.0");
+	clk_register_clkdev(clk, "stmmacphy.0", NULL);
 
 	/* clcd */
 	clk = clk_register_mux(NULL, "clcd_synth_mux_clk", clcd_synth_parents,
-- 
1.7.10
