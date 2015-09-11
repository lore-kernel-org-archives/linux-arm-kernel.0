From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Fri, 11 Sep 2015 16:54:58 +0800
Subject: [PATCH v2 05/22] KVM: ARM64: Add a helper for CP15 registers reset to
 UNKNOWN
In-Reply-To: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
References: <1441961715-11688-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1441961715-11688-6-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 arch/arm64/kvm/sys_regs.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index d411e25..a0b3811 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -104,6 +104,14 @@ static inline void reset_unknown(struct kvm_vcpu *vcpu,
 	vcpu_sys_reg(vcpu, r->reg) = 0x1de7ec7edbadc0deULL;
 }
 
+static inline void reset_unknown_cp15(struct kvm_vcpu *vcpu,
+				      const struct sys_reg_desc *r)
+{
+	BUG_ON(!r->reg);
+	BUG_ON(r->reg >= NR_COPRO_REGS);
+	vcpu_cp15(vcpu, r->reg) = 0xdecafbad;
+}
+
 static inline void reset_val(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r)
 {
 	BUG_ON(!r->reg);
-- 
2.0.4
