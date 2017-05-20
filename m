From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 20 May 2017 23:42:54 +0200
Subject: [PATCH 5/5 v2] dma: pl08x: use GENMASK() to create bitmasks
In-Reply-To: <20170520214254.21541-1-linus.walleij@linaro.org>
References: <20170520214254.21541-1-linus.walleij@linaro.org>
Message-ID: <20170520214254.21541-5-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches the arbitrary shifting of hex constants in
the pl080 header to use GENMASK().

Suggested-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch at the end of the series in response to
  Vinods request to use GENMASK().
---
 include/linux/amba/pl080.h | 50 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/amba/pl080.h b/include/linux/amba/pl080.h
index 10124c9f9db5..ab036b6b1804 100644
--- a/include/linux/amba/pl080.h
+++ b/include/linux/amba/pl080.h
@@ -70,12 +70,12 @@
 #define FTDMAC020_CH_LLP			(0x10)
 #define FTDMAC020_CH_SIZE			(0x14)
 
-#define PL080_LLI_ADDR_MASK			(0x3fffffff << 2)
+#define PL080_LLI_ADDR_MASK			GENMASK(31, 2)
 #define PL080_LLI_ADDR_SHIFT			(2)
 #define PL080_LLI_LM_AHB2			BIT(0)
 
 #define PL080_CONTROL_TC_IRQ_EN			BIT(31)
-#define PL080_CONTROL_PROT_MASK			(0x7 << 28)
+#define PL080_CONTROL_PROT_MASK			GENMASK(30, 28)
 #define PL080_CONTROL_PROT_SHIFT		(28)
 #define PL080_CONTROL_PROT_CACHE		BIT(30)
 #define PL080_CONTROL_PROT_BUFF			BIT(29)
@@ -84,16 +84,16 @@
 #define PL080_CONTROL_SRC_INCR			BIT(26)
 #define PL080_CONTROL_DST_AHB2			BIT(25)
 #define PL080_CONTROL_SRC_AHB2			BIT(24)
-#define PL080_CONTROL_DWIDTH_MASK		(0x7 << 21)
+#define PL080_CONTROL_DWIDTH_MASK		GENMASK(23, 21)
 #define PL080_CONTROL_DWIDTH_SHIFT		(21)
-#define PL080_CONTROL_SWIDTH_MASK		(0x7 << 18)
+#define PL080_CONTROL_SWIDTH_MASK		GENMASK(20, 18)
 #define PL080_CONTROL_SWIDTH_SHIFT		(18)
-#define PL080_CONTROL_DB_SIZE_MASK		(0x7 << 15)
+#define PL080_CONTROL_DB_SIZE_MASK		GENMASK(17, 15)
 #define PL080_CONTROL_DB_SIZE_SHIFT		(15)
-#define PL080_CONTROL_SB_SIZE_MASK		(0x7 << 12)
+#define PL080_CONTROL_SB_SIZE_MASK		GENMASK(14, 12)
 #define PL080_CONTROL_SB_SIZE_SHIFT		(12)
-#define PL080_CONTROL_TRANSFER_SIZE_MASK	(0xfff << 0)
-#define PL080S_CONTROL_TRANSFER_SIZE_MASK	(0x1ffffff << 0)
+#define PL080_CONTROL_TRANSFER_SIZE_MASK	GENMASK(11, 0)
+#define PL080S_CONTROL_TRANSFER_SIZE_MASK	GENMASK(24, 0)
 #define PL080_CONTROL_TRANSFER_SIZE_SHIFT	(0)
 
 #define PL080_BSIZE_1				(0x0)
@@ -116,11 +116,11 @@
 #define PL080_CONFIG_LOCK			BIT(16)
 #define PL080_CONFIG_TC_IRQ_MASK		BIT(15)
 #define PL080_CONFIG_ERR_IRQ_MASK		BIT(14)
-#define PL080_CONFIG_FLOW_CONTROL_MASK		(0x7 << 11)
+#define PL080_CONFIG_FLOW_CONTROL_MASK		GENMASK(13, 11)
 #define PL080_CONFIG_FLOW_CONTROL_SHIFT		(11)
-#define PL080_CONFIG_DST_SEL_MASK		(0xf << 6)
+#define PL080_CONFIG_DST_SEL_MASK		GENMASK(9, 6)
 #define PL080_CONFIG_DST_SEL_SHIFT		(6)
-#define PL080_CONFIG_SRC_SEL_MASK		(0xf << 1)
+#define PL080_CONFIG_SRC_SEL_MASK		GENMASK(4, 1)
 #define PL080_CONFIG_SRC_SEL_SHIFT		(1)
 #define PL080_CONFIG_ENABLE			BIT(0)
 
@@ -135,24 +135,24 @@
 
 #define FTDMAC020_CH_CSR_TC_MSK			BIT(31)
 /* Later versions have a threshold in bits 24..26,  */
-#define FTDMAC020_CH_CSR_FIFOTH_MSK		(0x7 << 24)
+#define FTDMAC020_CH_CSR_FIFOTH_MSK		GENMASK(26, 24)
 #define FTDMAC020_CH_CSR_FIFOTH_SHIFT		(24)
-#define FTDMAC020_CH_CSR_CHPR1_MSK		(0x3 << 22)
+#define FTDMAC020_CH_CSR_CHPR1_MSK		GENMASK(23, 22)
 #define FTDMAC020_CH_CSR_PROT3			BIT(21)
 #define FTDMAC020_CH_CSR_PROT2			BIT(20)
 #define FTDMAC020_CH_CSR_PROT1			BIT(19)
-#define FTDMAC020_CH_CSR_SRC_SIZE_MSK		(0x7 << 16)
+#define FTDMAC020_CH_CSR_SRC_SIZE_MSK		GENMASK(18, 16)
 #define FTDMAC020_CH_CSR_SRC_SIZE_SHIFT		(16)
 #define FTDMAC020_CH_CSR_ABT			BIT(15)
-#define FTDMAC020_CH_CSR_SRC_WIDTH_MSK		(0x7 << 11)
+#define FTDMAC020_CH_CSR_SRC_WIDTH_MSK		GENMASK(13, 11)
 #define FTDMAC020_CH_CSR_SRC_WIDTH_SHIFT	(11)
-#define FTDMAC020_CH_CSR_DST_WIDTH_MSK		(0x7 << 8)
+#define FTDMAC020_CH_CSR_DST_WIDTH_MSK		GENMASK(10, 8)
 #define FTDMAC020_CH_CSR_DST_WIDTH_SHIFT	(8)
 #define FTDMAC020_CH_CSR_MODE			BIT(7)
 /* 00 = increase, 01 = decrease, 10 = fix */
-#define FTDMAC020_CH_CSR_SRCAD_CTL_MSK		(0x3 << 5)
+#define FTDMAC020_CH_CSR_SRCAD_CTL_MSK		GENMASK(6, 5)
 #define FTDMAC020_CH_CSR_SRCAD_CTL_SHIFT	(5)
-#define FTDMAC020_CH_CSR_DSTAD_CTL_MSK		(0x3 << 3)
+#define FTDMAC020_CH_CSR_DSTAD_CTL_MSK		GENMASK(4, 3)
 #define FTDMAC020_CH_CSR_DSTAD_CTL_SHIFT	(3)
 #define FTDMAC020_CH_CSR_SRC_SEL		BIT(2)
 #define FTDMAC020_CH_CSR_DST_SEL		BIT(1)
@@ -171,7 +171,7 @@
 #define FTDMAC020_CH_CSR_SRCAD_CTL_DEC		(0x1)
 #define FTDMAC020_CH_CSR_SRCAD_CTL_FIXED	(0x2)
 
-#define FTDMAC020_CH_CFG_LLP_CNT_MASK		(0xf << 16)
+#define FTDMAC020_CH_CFG_LLP_CNT_MASK		GENMASK(19, 16)
 #define FTDMAC020_CH_CFG_LLP_CNT_SHIFT		(16)
 #define FTDMAC020_CH_CFG_BUSY			BIT(8)
 #define FTDMAC020_CH_CFG_INT_ABT_MASK		BIT(2)
@@ -180,20 +180,20 @@
 
 /* Inside the LLIs, the applicable CSR fields are mapped differently */
 #define FTDMAC020_LLI_TC_MSK			BIT(28)
-#define FTDMAC020_LLI_SRC_WIDTH_MSK		(0x7 << 25)
+#define FTDMAC020_LLI_SRC_WIDTH_MSK		GENMASK(27, 25)
 #define FTDMAC020_LLI_SRC_WIDTH_SHIFT		(25)
-#define FTDMAC020_LLI_DST_WIDTH_MSK		(0x7 << 22)
+#define FTDMAC020_LLI_DST_WIDTH_MSK		GENMASK(24, 22)
 #define FTDMAC020_LLI_DST_WIDTH_SHIFT		(22)
-#define FTDMAC020_LLI_SRCAD_CTL_MSK		(0x3 << 20)
+#define FTDMAC020_LLI_SRCAD_CTL_MSK		GENMASK(21, 20)
 #define FTDMAC020_LLI_SRCAD_CTL_SHIFT		(20)
-#define FTDMAC020_LLI_DSTAD_CTL_MSK		(0x3 << 18)
+#define FTDMAC020_LLI_DSTAD_CTL_MSK		GENMASK(19, 18)
 #define FTDMAC020_LLI_DSTAD_CTL_SHIFT		(18)
 #define FTDMAC020_LLI_SRC_SEL			BIT(17)
 #define FTDMAC020_LLI_DST_SEL			BIT(16)
-#define FTDMAC020_LLI_TRANSFER_SIZE_MASK	(0xfff << 0)
+#define FTDMAC020_LLI_TRANSFER_SIZE_MASK	GENMASK(11, 0)
 #define FTDMAC020_LLI_TRANSFER_SIZE_SHIFT	(0)
 
-#define FTDMAC020_CFG_LLP_CNT_MASK		(0x0f << 16)
+#define FTDMAC020_CFG_LLP_CNT_MASK		GENMASK(19, 16)
 #define FTDMAC020_CFG_LLP_CNT_SHIFT		(16)
 #define FTDMAC020_CFG_BUSY			BIT(8)
 #define FTDMAC020_CFG_INT_ABT_MSK		BIT(2)
-- 
2.9.4
