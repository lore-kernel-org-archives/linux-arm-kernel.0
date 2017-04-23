From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:08:18 +0200
Subject: [PULL 08/79] KVM: arm64: add SYS_DESC()
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-9-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

This patch adds a macro enabling us to initialise sys_reg_desc
structures based on common sysreg encoding definitions in
<asm/sysreg.h>. Subsequent patches will use this to simplify the KVM
code.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
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
2.9.0
