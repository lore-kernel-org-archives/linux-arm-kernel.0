From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 14:53:49 +0530
Subject: [PATCH V2 2/7] clk: SPEAr1340: Fix clk enable register for uart1 and
 i2c1.
In-Reply-To: <cover.1342171151.git.vipulkumar.samar@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
Message-ID: <331cbb10bd162ca25d60f6c9951c00785d6b9ce7.1342171151.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to fix typing mistake of clk enable register of i2c1 and uart1.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Acked-by: Viiresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/spear/spear1340_clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 0f2324b..4484698 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -617,7 +617,7 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk, "uart1_mclk", NULL);
 
 	clk = clk_register_gate(NULL, "uart1_clk", "uart1_mclk", 0,
-			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_UART1_CLK_ENB, 0,
+			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_UART1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "b4100000.serial");
 
@@ -741,7 +741,7 @@ void __init spear1340_clk_init(void)
 	clk_register_clkdev(clk, NULL, "e0280000.i2c");
 
 	clk = clk_register_gate(NULL, "i2c1_clk", "ahb_clk", 0,
-			SPEAR1340_PERIP1_CLK_ENB, SPEAR1340_I2C1_CLK_ENB, 0,
+			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_I2C1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "b4000000.i2c");
 
-- 
1.7.2.2
