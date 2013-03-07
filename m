From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Thu, 7 Mar 2013 12:35:24 +0530
Subject: [PATCH] clk:SPEAr1340: Correct parent clock configuration
Message-ID: <9c65c93de3e7269bfc6e31bcdddc2ecd64338761.1362639296.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch corrects wrongly configured parent clock for following
devices:

   * Video enc/decoder
   * Video ip
   * Pin control
   * ACP
   * camx

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
Reviewed-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 drivers/clk/spear/spear1340_clock.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
index 82abea3..35e7e26 100644
--- a/drivers/clk/spear/spear1340_clock.c
+++ b/drivers/clk/spear/spear1340_clock.c
@@ -960,47 +960,47 @@ void __init spear1340_clk_init(void)
 			SPEAR1340_SPDIF_IN_CLK_ENB, 0, &_lock);
 	clk_register_clkdev(clk, NULL, "d0100000.spdif-in");
 
-	clk = clk_register_gate(NULL, "acp_clk", "acp_mclk", 0,
+	clk = clk_register_gate(NULL, "acp_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP2_CLK_ENB, SPEAR1340_ACP_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "acp_clk");
 
-	clk = clk_register_gate(NULL, "plgpio_clk", "plgpio_mclk", 0,
+	clk = clk_register_gate(NULL, "plgpio_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_PLGPIO_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "e2800000.gpio");
 
-	clk = clk_register_gate(NULL, "video_dec_clk", "video_dec_mclk", 0,
+	clk = clk_register_gate(NULL, "video_dec_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_VIDEO_DEC_CLK_ENB,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "video_dec");
 
-	clk = clk_register_gate(NULL, "video_enc_clk", "video_enc_mclk", 0,
+	clk = clk_register_gate(NULL, "video_enc_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_VIDEO_ENC_CLK_ENB,
 			0, &_lock);
 	clk_register_clkdev(clk, NULL, "video_enc");
 
-	clk = clk_register_gate(NULL, "video_in_clk", "video_in_mclk", 0,
+	clk = clk_register_gate(NULL, "video_in_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_VIDEO_IN_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "spear_vip");
 
-	clk = clk_register_gate(NULL, "cam0_clk", "cam0_mclk", 0,
+	clk = clk_register_gate(NULL, "cam0_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_CAM0_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "d0200000.cam0");
 
-	clk = clk_register_gate(NULL, "cam1_clk", "cam1_mclk", 0,
+	clk = clk_register_gate(NULL, "cam1_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_CAM1_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "d0300000.cam1");
 
-	clk = clk_register_gate(NULL, "cam2_clk", "cam2_mclk", 0,
+	clk = clk_register_gate(NULL, "cam2_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_CAM2_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "d0400000.cam2");
 
-	clk = clk_register_gate(NULL, "cam3_clk", "cam3_mclk", 0,
+	clk = clk_register_gate(NULL, "cam3_clk", "ahb_clk", 0,
 			SPEAR1340_PERIP3_CLK_ENB, SPEAR1340_CAM3_CLK_ENB, 0,
 			&_lock);
 	clk_register_clkdev(clk, NULL, "d0500000.cam3");
-- 
1.7.3.4
