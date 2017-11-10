From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Fri, 10 Nov 2017 07:47:17 +0000
Subject: [PATCH] fixup! kvm: arm debug: introduce helper for single-step
In-Reply-To: <20171109170021.2984-2-alex.bennee@linaro.org>
References: <20171109170021.2984-2-alex.bennee@linaro.org>
Message-ID: <20171110074717.30134-1-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm/include/asm/kvm_host.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index a2e881d6108e..26a1ea6c6542 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -286,7 +286,10 @@ static inline void kvm_arm_setup_debug(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arm_clear_debug(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu) {}
 static inline bool kvm_arm_handle_step_debug(struct kvm_vcpu *vcpu,
-					     struct kvm_run *run) {}
+					     struct kvm_run *run)
+{
+	return false;
+}
 
 int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
 			       struct kvm_device_attr *attr);
-- 
2.14.2
