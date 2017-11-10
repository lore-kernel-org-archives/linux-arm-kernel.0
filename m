From: jlu@pengutronix.de (Jan Luebbe)
Date: Fri, 10 Nov 2017 10:03:04 +0100
Subject: [PATCH v3 3/7] ARM: aurora-l2: add defines for parity and ECC
 registers
In-Reply-To: <20171110090308.21562-1-jlu@pengutronix.de>
References: <20171110090308.21562-1-jlu@pengutronix.de>
Message-ID: <20171110090308.21562-4-jlu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These defines will be used by subsequent patches to add support for the
parity check and error correction functionality in the Aurora L2 cache
controller.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 arch/arm/include/asm/hardware/cache-aurora-l2.h | 48 +++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/include/asm/hardware/cache-aurora-l2.h b/arch/arm/include/asm/hardware/cache-aurora-l2.h
index dc5c479ec4c3..c32be689d1f6 100644
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
+#define AURORA_ERR_CNT_CE_OFFSET            0
+#define AURORA_ERR_CNT_CE_MASK              \
+	(0xffff << AURORA_ERR_CNT_CE_OFFSET)
+
+#define AURORA_ERR_ATTR_CAP_ERR_SOURCE_OFFSET       16
+#define AURORA_ERR_ATTR_CAP_ERR_SOURCE_MASK          \
+	(0x7 << AURORA_ERR_ATTR_CAP_ERR_SOURCE_OFFSET)
+#define AURORA_ERR_ATTR_CAP_TRANS_TYPE_OFFSET       12
+#define AURORA_ERR_ATTR_CAP_TRANS_TYPE_MASK          \
+	(0xf << AURORA_ERR_ATTR_CAP_TRANS_TYPE_OFFSET)
+#define AURORA_ERR_ATTR_CAP_ERR_TYPE_OFFSET          8
+#define AURORA_ERR_ATTR_CAP_ERR_TYPE_MASK            \
+	(0x3 << AURORA_ERR_ATTR_CAP_ERR_TYPE_OFFSET)
+#define AURORA_ERR_ATTR_CAP_VALID_OFFSET             0
+#define AURORA_ERR_ATTR_CAP_VALID                    \
+	(0x1 << AURORA_ERR_ATTR_CAP_VALID_OFFSET)
+
+#define AURORA_ERR_ADDR_CAP_ADDR_MASK 0xffffffe0
+
+#define AURORA_ERR_WAY_CAP_INDEX_OFFSET          8
+#define AURORA_ERR_WAY_CAP_INDEX_MASK            \
+	(0xfff << AURORA_ERR_WAY_CAP_INDEX_OFFSET)
+#define AURORA_ERR_WAY_CAP_WAY_OFFSET          1
+#define AURORA_ERR_WAY_CAP_WAY_MASK            \
+	(0xf << AURORA_ERR_WAY_CAP_WAY_OFFSET)
+
+#define AURORA_ERR_INJECT_CTL_ADDR_MASK 0xfffffff0
+#define AURORA_ERR_ATTR_CAP_TRANS_TYPE_OFFSET   12
+#define AURORA_ERR_INJECT_CTL_EN_MASK          0x3
+#define AURORA_ERR_INJECT_CTL_EN_PARITY        0x2
+#define AURORA_ERR_INJECT_CTL_EN_ECC           0x1
+
 #define AURORA_MAX_RANGE_SIZE	1024
 
 #define AURORA_WAY_SIZE_SHIFT	2
-- 
2.11.0
