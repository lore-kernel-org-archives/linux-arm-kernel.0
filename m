From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 11 Sep 2015 16:55:08 +0800
Subject: [PATCH v2 15/22] KVM: ARM64: Add a helper for CP15 registers reset to
 specified value
In-Reply-To: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
References: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1441961715-11688-16-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/kvm/sys_regs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index a0b3811..a476b1b 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -119,6 +119,14 @@ static inline void reset_val(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r
 	vcpu_sys_reg(vcpu, r->reg) = r->val;
 }
 
+static inline void reset_val_cp15(struct kvm_vcpu *vcpu,
+				  const struct sys_reg_desc *r)
+{
+	BUG_ON(!r->reg);
+	BUG_ON(r->reg >= NR_SYS_REGS);
+	vcpu_cp15(vcpu, r->reg) = r->val;
+}
+
 static inline int cmp_sys_reg(const struct sys_reg_desc *i1,
 			      const struct sys_reg_desc *i2)
 {
-- 
2.0.4
