From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 8 Dec 2015 20:47:22 +0800
Subject: [PATCH v6 03/21] KVM: ARM64: Add offset defines for PMU registers
In-Reply-To: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
References: <1449578860-15808-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1449578860-15808-4-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

We are about to trap and emulate accesses to each PMU register
individually. This adds the context offsets for the AArch64 PMU
registers and their AArch32 counterparts.

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/include/asm/kvm_asm.h | 45 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 5e37710..fb3a2a0 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -48,12 +48,29 @@
 #define MDSCR_EL1	22	/* Monitor Debug System Control Register */
 #define MDCCINT_EL1	23	/* Monitor Debug Comms Channel Interrupt Enable Reg */
 
+/* Performance Monitors Registers */
+#define PMCR_EL0	24	/* Control Register */
+#define PMOVSSET_EL0	25	/* Overflow Flag Status Set Register */
+#define PMSELR_EL0	26	/* Event Counter Selection Register */
+#define PMCEID0_EL0	27	/* Common Event Identification Register 0 */
+#define PMCEID1_EL0	28	/* Common Event Identification Register 1 */
+#define PMEVCNTR0_EL0	29	/* Event Counter Register (0-30) */
+#define PMEVCNTR30_EL0	59
+#define PMCCNTR_EL0	60	/* Cycle Counter Register */
+#define PMEVTYPER0_EL0	61	/* Event Type Register (0-30) */
+#define PMEVTYPER30_EL0	91
+#define PMCCFILTR_EL0	92	/* Cycle Count Filter Register */
+#define PMCNTENSET_EL0	93	/* Count Enable Set Register */
+#define PMINTENSET_EL1	94	/* Interrupt Enable Set Register */
+#define PMUSERENR_EL0	95	/* User Enable Register */
+#define PMSWINC_EL0	96	/* Software Increment Register */
+
 /* 32bit specific registers. Keep them at the end of the range */
-#define	DACR32_EL2	24	/* Domain Access Control Register */
-#define	IFSR32_EL2	25	/* Instruction Fault Status Register */
-#define	FPEXC32_EL2	26	/* Floating-Point Exception Control Register */
-#define	DBGVCR32_EL2	27	/* Debug Vector Catch Register */
-#define	NR_SYS_REGS	28
+#define	DACR32_EL2	97	/* Domain Access Control Register */
+#define	IFSR32_EL2	98	/* Instruction Fault Status Register */
+#define	FPEXC32_EL2	99	/* Floating-Point Exception Control Register */
+#define	DBGVCR32_EL2	100	/* Debug Vector Catch Register */
+#define	NR_SYS_REGS	101
 
 /* 32bit mapping */
 #define c0_MPIDR	(MPIDR_EL1 * 2)	/* MultiProcessor ID Register */
@@ -75,6 +92,19 @@
 #define c6_IFAR		(c6_DFAR + 1)	/* Instruction Fault Address Register */
 #define c7_PAR		(PAR_EL1 * 2)	/* Physical Address Register */
 #define c7_PAR_high	(c7_PAR + 1)	/* PAR top 32 bits */
+
+/* Performance Monitors*/
+#define c9_PMCR		(PMCR_EL0 * 2)
+#define c9_PMOVSSET	(PMOVSSET_EL0 * 2)
+#define c9_PMCCNTR	(PMCCNTR_EL0 * 2)
+#define c9_PMSELR	(PMSELR_EL0 * 2)
+#define c9_PMCEID0	(PMCEID0_EL0 * 2)
+#define c9_PMCEID1	(PMCEID1_EL0 * 2)
+#define c9_PMCNTENSET	(PMCNTENSET_EL0 * 2)
+#define c9_PMINTENSET	(PMINTENSET_EL1 * 2)
+#define c9_PMUSERENR	(PMUSERENR_EL0 * 2)
+#define c9_PMSWINC	(PMSWINC_EL0 * 2)
+
 #define c10_PRRR	(MAIR_EL1 * 2)	/* Primary Region Remap Register */
 #define c10_NMRR	(c10_PRRR + 1)	/* Normal Memory Remap Register */
 #define c12_VBAR	(VBAR_EL1 * 2)	/* Vector Base Address Register */
@@ -86,6 +116,11 @@
 #define c10_AMAIR1	(c10_AMAIR0 + 1)/* Aux Memory Attr Indirection Reg */
 #define c14_CNTKCTL	(CNTKCTL_EL1 * 2) /* Timer Control Register (PL1) */
 
+/* Performance Monitors*/
+#define c14_PMEVCNTR0	(PMEVCNTR0_EL0 * 2)
+#define c14_PMEVTYPER0	(PMEVTYPER0_EL0 * 2)
+#define c14_PMCCFILTR	(PMCCFILTR_EL0 * 2)
+
 #define cp14_DBGDSCRext	(MDSCR_EL1 * 2)
 #define cp14_DBGBCR0	(DBGBCR0_EL1 * 2)
 #define cp14_DBGBVR0	(DBGBVR0_EL1 * 2)
-- 
2.0.4
