From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 18 Aug 2016 13:45:54 +0100
Subject: [PATCH v2 2/8] ARM: V7M: Add addresses for mem-mapped V7M cache
 operations
In-Reply-To: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
References: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1471524360-31554-3-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

V7M implements cache operations similarly to V7A/R, however all operations
are performed via memory-mapped IO instead of co-processor operations.

This patch adds register definitions relevant to the V7M ARM architecture's
cache architecture.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/v7m.h |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
index 615781c..1fd775c 100644
--- a/arch/arm/include/asm/v7m.h
+++ b/arch/arm/include/asm/v7m.h
@@ -24,6 +24,9 @@
 
 #define V7M_SCB_CCR			0x14
 #define V7M_SCB_CCR_STKALIGN			(1 << 9)
+#define V7M_SCB_CCR_DC				(1 << 16)
+#define V7M_SCB_CCR_IC				(1 << 17)
+#define V7M_SCB_CCR_BP				(1 << 18)
 
 #define V7M_SCB_SHPR2			0x1c
 #define V7M_SCB_SHPR3			0x20
@@ -47,6 +50,25 @@
 #define EXC_RET_STACK_MASK			0x00000004
 #define EXC_RET_THREADMODE_PROCESSSTACK		0xfffffffd
 
+/* Cache related definitions */
+
+#define	V7M_SCB_CLIDR		0x78	/* Cache Level ID register */
+#define	V7M_SCB_CTR		0x7c	/* Cache Type register */
+#define	V7M_SCB_CCSIDR		0x80	/* Cache size ID register */
+#define	V7M_SCB_CSSELR		0x84	/* Cache size selection register */
+
+/* Cache opeartions */
+#define	V7M_SCB_ICIALLU		0x250	/* I-cache invalidate all to PoU */
+#define	V7M_SCB_ICIMVAU		0x258	/* I-cache invalidate by MVA to PoU */
+#define	V7M_SCB_DCIMVAC		0x25c	/* D-cache invalidate by MVA to PoC */
+#define	V7M_SCB_DCISW		0x260	/* D-cache invalidate by set-way */
+#define	V7M_SCB_DCCMVAU		0x264	/* D-cache clean by MVA to PoU */
+#define	V7M_SCB_DCCMVAC		0x268	/* D-cache clean by MVA to PoC */
+#define	V7M_SCB_DCCSW		0x26c	/* D-cache clean by set-way */
+#define	V7M_SCB_DCCIMVAC	0x270	/* D-cache clean and invalidate by MVA to PoC */
+#define	V7M_SCB_DCCISW		0x274	/* D-cache clean and invalidate by set-way */
+#define	V7M_SCB_BPIALL		0x278	/* D-cache clean and invalidate by set-way */
+
 #ifndef __ASSEMBLY__
 
 enum reboot_mode;
-- 
1.7.9.5
