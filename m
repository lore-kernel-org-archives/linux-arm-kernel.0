From: shiraz.hashim@st.com (Shiraz Hashim)
Date: Mon, 9 Jul 2012 16:01:02 +0530
Subject: [PATCH 2/6] clk: SPEAr1340: Fix clk enable register for uart1 and
 i2c1.
In-Reply-To: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
References: <1341829866-26091-1-git-send-email-shiraz.hashim@st.com>
Message-ID: <1341829866-26091-2-git-send-email-shiraz.hashim@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vipul Kumar Samar <vipulkumar.samar@st.com>

This patch is to fix typing mistake of clk enable register of i2c1 and uart1.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 drivers/clk/spear/spear1340_clock.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index e3ea721..d77f54f 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -619,7 +619,7 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk, "uart1_mux_clk", NULL);
 
 	clk = clk_register_gate(NULL, "uart1_clk", "uart1_mux_clk", 0,
-			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_UART1_CLK_ENB, 0,
+			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_UART1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "b4100000.serial");
 
@@ -744,7 +744,7 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk, NULL, "e0280000.i2c");
 
 	clk = clk_register_gate(NULL, "i2c1_clk", "ahb_clk", 0,
-			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_I2C1_CLK_ENB, 0,
+			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_I2C1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "b4000000.i2c");
 
-- 
1.7.10
