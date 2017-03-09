From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  9 Mar 2017 17:07:17 +0000
Subject: [PATCH 05/15] arm64: sysreg: add physical timer registers
In-Reply-To: <1489079247-31092-1-git-send-email-mark.rutland@arm.com>
References: <1489079247-31092-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489079247-31092-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds sysreg definitions for system registers used to control
the architected physical timer. Subsequent patches will make use of
these definitions.

The encodings were taken from ARM DDI 0487A.k_iss10775, Table C5-6.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9dc30bc..3e281b1 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -182,6 +182,10 @@
 
 #define SYS_CNTFRQ_EL0			sys_reg(3, 3, 14, 0, 0)
 
+#define SYS_CNTP_TVAL_EL0		sys_reg(3, 3, 14, 2, 0)
+#define SYS_CNTP_CTL_EL0		sys_reg(3, 3, 14, 2, 1)
+#define SYS_CNTP_CVAL_EL0		sys_reg(3, 3, 14, 2, 2)
+
 #define __PMEV_op2(n)			((n) & 0x7)
 #define __CNTR_CRm(n)			(0x8 | (((n) >> 3) & 0x3))
 #define SYS_PMEVCNTRn_EL0(n)		sys_reg(3, 3, 14, __CNTR_CRm(n), __PMEV_op2(n))
-- 
1.9.1
