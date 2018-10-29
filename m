From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 29 Oct 2018 20:25:30 +1300
Subject: [PATCH v5 3/8] ARM: aurora-l2: add defines for parity and ECC
 registers
In-Reply-To: <20181029072535.31667-1-chris.packham@alliedtelesis.co.nz>
References: <20181029072535.31667-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20181029072535.31667-4-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jan Luebbe <jlu@pengutronix.de>

These defines will be used by subsequent patches to add support for the
parity check and error correction functionality in the Aurora L2 cache
controller.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../include/asm/hardware/cache-aurora-l2.h    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/include/asm/hardware/cache-aurora-l2.h b/arch/arm/include/asm/hardware/cache-aurora-l2.h
index dc5c479ec4c3..39769ffa0051 100644
--- a/arch/arm/include/asm/hardware/cache-aurora-l2.h
+++ b/arch/arm/include/asm/hardware/cache-aurora-l2.h
@@ -31,6 +31,9 @@
 #define AURORA_ACR_REPLACEMENT_TYPE_SEMIPLRU \
 	(3 << AURORA_ACR_REPLACEMENT_OFFSET)
 
+#define AURORA_ACR_PARITY_EN	(1 << 21)
+#define AURORA_ACR_ECC_EN	(1 << 20)
+
 #define AURORA_ACR_FORCE_WRITE_POLICY_OFFSET	0
 #define AURORA_ACR_FORCE_WRITE_POLICY_MASK	\
 	(0x3 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
@@ -41,6 +44,51 @@
 #define AURORA_ACR_FORCE_WRITE_THRO_POLICY	\
 	(2 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
 
+#define AURORA_ERR_CNT_REG          0x600
+#define AURORA_ERR_ATTR_CAP_REG     0x608
+#define AURORA_ERR_ADDR_CAP_REG     0x60c
+#define AURORA_ERR_WAY_CAP_REG      0x610
+#define AURORA_ERR_INJECT_CTL_REG   0x614
+#define AURORA_ERR_INJECT_MASK_REG  0x618
+
+#define AURORA_ERR_CNT_CLR_OFFSET         31
+#define AURORA_ERR_CNT_CLR		   \
+	(0x1 << AURORA_ERR_CNT_CLR_OFFSET)
+#define AURORA_ERR_CNT_UE_OFFSET          16
+#define AURORA_ERR_CNT_UE_MASK             \
+	(0x7fff << AURORA_ERR_CNT_UE_OFFSET)
+#define AURORA_ERR_CNT_CE_OFFSET           0
+#define AURORA_ERR_CNT_CE_MASK             \
+	(0xffff << AURORA_ERR_CNT_CE_OFFSET)
+
+#define AURORA_ERR_ATTR_SRC_OFF           16
+#define AURORA_ERR_ATTR_SRC_MSK            \
+	(0x7 << AURORA_ERR_ATTR_SRC_OFF)
+#define AURORA_ERR_ATTR_TXN_OFF           12
+#define AURORA_ERR_ATTR_TXN_MSK            \
+	(0xf << AURORA_ERR_ATTR_TXN_OFF)
+#define AURORA_ERR_ATTR_ERR_OFF            8
+#define AURORA_ERR_ATTR_ERR_MSK            \
+	(0x3 << AURORA_ERR_ATTR_ERR_OFF)
+#define AURORA_ERR_ATTR_CAP_VALID_OFF      0
+#define AURORA_ERR_ATTR_CAP_VALID          \
+	(0x1 << AURORA_ERR_ATTR_CAP_VALID_OFF)
+
+#define AURORA_ERR_ADDR_CAP_ADDR_MASK 0xffffffe0
+
+#define AURORA_ERR_WAY_IDX_OFF             8
+#define AURORA_ERR_WAY_IDX_MSK             \
+	(0xfff << AURORA_ERR_WAY_IDX_OFF)
+#define AURORA_ERR_WAY_CAP_WAY_OFFSET      1
+#define AURORA_ERR_WAY_CAP_WAY_MASK        \
+	(0xf << AURORA_ERR_WAY_CAP_WAY_OFFSET)
+
+#define AURORA_ERR_INJECT_CTL_ADDR_MASK 0xfffffff0
+#define AURORA_ERR_ATTR_TXN_OFF   12
+#define AURORA_ERR_INJECT_CTL_EN_MASK          0x3
+#define AURORA_ERR_INJECT_CTL_EN_PARITY        0x2
+#define AURORA_ERR_INJECT_CTL_EN_ECC           0x1
+
 #define AURORA_MAX_RANGE_SIZE	1024
 
 #define AURORA_WAY_SIZE_SHIFT	2
-- 
2.19.1
