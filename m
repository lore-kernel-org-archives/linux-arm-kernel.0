From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 15 Dec 2015 16:49:23 +0800
Subject: [PATCH v7 03/19] KVM: ARM64: Add offset defines for PMU registers
In-Reply-To: <1450169379-12336-1-git-send-email-zhaoshenglong@huawei.com>
References: <1450169379-12336-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1450169379-12336-4-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

We are about to trap and emulate accesses to each PMU register
individually. This adds the context offsets for the AArch64 PMU
registers.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/include/asm/kvm_asm.h | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 5e37710..1aef220 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -48,12 +48,27 @@
 #define MDSCR_EL1	22	/* Monitor Debug System Control Register */
 #define MDCCINT_EL1	23	/* Monitor Debug Comms Channel Interrupt Enable Reg */
 
+/* Performance Monitors Registers */
+#define PMCR_EL0	24	/* Control Register */
+#define PMOVSSET_EL0	25	/* Overflow Flag Status Set Register */
+#define PMSELR_EL0	26	/* Event Counter Selection Register */
+#define PMEVCNTR0_EL0	27	/* Event Counter Register (0-30) */
+#define PMEVCNTR30_EL0	57
+#define PMCCNTR_EL0	58	/* Cycle Counter Register */
+#define PMEVTYPER0_EL0	59	/* Event Type Register (0-30) */
+#define PMEVTYPER30_EL0	89
+#define PMCCFILTR_EL0	90	/* Cycle Count Filter Register */
+#define PMCNTENSET_EL0	91	/* Count Enable Set Register */
+#define PMINTENSET_EL1	92	/* Interrupt Enable Set Register */
+#define PMUSERENR_EL0	93	/* User Enable Register */
+#define PMSWINC_EL0	94	/* Software Increment Register */
+
 /* 32bit specific registers. Keep them at the end of the range */
-#define	DACR32_EL2	24	/* Domain Access Control Register */
-#define	IFSR32_EL2	25	/* Instruction Fault Status Register */
-#define	FPEXC32_EL2	26	/* Floating-Point Exception Control Register */
-#define	DBGVCR32_EL2	27	/* Debug Vector Catch Register */
-#define	NR_SYS_REGS	28
+#define	DACR32_EL2	95	/* Domain Access Control Register */
+#define	IFSR32_EL2	96	/* Instruction Fault Status Register */
+#define	FPEXC32_EL2	97	/* Floating-Point Exception Control Register */
+#define	DBGVCR32_EL2	98	/* Debug Vector Catch Register */
+#define	NR_SYS_REGS	99
 
 /* 32bit mapping */
 #define c0_MPIDR	(MPIDR_EL1 * 2)	/* MultiProcessor ID Register */
-- 
2.0.4
