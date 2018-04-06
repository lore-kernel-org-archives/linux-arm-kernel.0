From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Fri, 6 Apr 2018 08:39:30 +0200
Subject: [PATCH 3/6] clk: stm32mp1: fix SAI3 & SAI4 clocks
In-Reply-To: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
References: <1522996773-24129-1-git-send-email-gabriel.fernandez@st.com>
Message-ID: <1522996773-24129-4-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

fix bad copy / paste.
SAI3 & SAI4 used gate of SAI2 instead SAI3 & SAI4

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/clk-stm32mp1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 9a67b1c..eefed49 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1942,8 +1942,8 @@ enum {
 	KCLK(FDCAN_K, "fdcan_k", fdcan_src, 0, G_FDCAN, M_FDCAN),
 	KCLK(SAI1_K, "sai1_k", sai_src, 0, G_SAI1, M_SAI1),
 	KCLK(SAI2_K, "sai2_k", sai2_src, 0, G_SAI2, M_SAI2),
-	KCLK(SAI3_K, "sai3_k", sai_src, 0, G_SAI2, M_SAI3),
-	KCLK(SAI4_K, "sai4_k", sai_src, 0, G_SAI2, M_SAI4),
+	KCLK(SAI3_K, "sai3_k", sai_src, 0, G_SAI3, M_SAI3),
+	KCLK(SAI4_K, "sai4_k", sai_src, 0, G_SAI4, M_SAI4),
 	KCLK(ADC12_K, "adc12_k", adc12_src, 0, G_ADC12, M_ADC12),
 	KCLK(DSI_K, "dsi_k", dsi_src, 0, G_DSI, M_DSI),
 	KCLK(ADFSDM_K, "adfsdm_k", sai_src, 0, G_ADFSDM, M_SAI1),
-- 
1.9.1
