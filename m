From: mark.rutland@arm.com (Mark Rutland)
Date: Thu,  9 Mar 2017 17:07:20 +0000
Subject: [PATCH 08/15] KVM: arm64: add SYS_DESC()
In-Reply-To: <1489079247-31092-1-git-send-email-mark.rutland@arm.com>
References: <1489079247-31092-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1489079247-31092-9-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a macro enabling us to initialise sys_reg_desc
structures based on common sysreg encoding definitions in
<asm/sysreg.h>. Subsequent patches will use this to simplify the KVM
code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: kvmarm at lists.cs.columbia.edu
---
 arch/arm64/kvm/sys_regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 9c6ffd0..66859a5 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -147,4 +147,9 @@ const struct sys_reg_desc *find_reg_by_id(u64 id,
 #define CRm(_x) 	.CRm = _x
 #define Op2(_x) 	.Op2 = _x
 
+#define SYS_DESC(reg)					\
+	Op0(sys_reg_Op0(reg)), Op1(sys_reg_Op1(reg)),	\
+	CRn(sys_reg_CRn(reg)), CRm(sys_reg_CRm(reg)),	\
+	Op2(sys_reg_Op2(reg))
+
 #endif /* __ARM64_KVM_SYS_REGS_LOCAL_H__ */
-- 
1.9.1
