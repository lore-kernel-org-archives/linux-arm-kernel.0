From: cdall@linaro.org (Christoffer Dall)
Date: Thu,  8 Jun 2017 15:34:39 +0200
Subject: [PATCH v3 2/9] KVM: arm: Handle VCPU device attributes in guest.c
In-Reply-To: <20170608133446.3875-1-cdall@linaro.org>
References: <20170608133446.3875-1-cdall@linaro.org>
Message-ID: <20170608133446.3875-3-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are about to support VCPU attributes to set the timer IRQ numbers
in guest.c, move the static inlines for the VCPU attributes handlers
from the header file to guest.c.

Signed-off-by: Christoffer Dall <cdall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_host.h | 22 +++++++--------------
 arch/arm/kvm/guest.c            | 42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 00ad56e..127e2dd 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -291,20 +291,12 @@ static inline void kvm_arm_init_debug(void) {}
 static inline void kvm_arm_setup_debug(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arm_clear_debug(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arm_reset_debug_ptr(struct kvm_vcpu *vcpu) {}
-static inline int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
-					     struct kvm_device_attr *attr)
-{
-	return -ENXIO;
-}
-static inline int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
-					     struct kvm_device_attr *attr)
-{
-	return -ENXIO;
-}
-static inline int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
-					     struct kvm_device_attr *attr)
-{
-	return -ENXIO;
-}
+
+int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
+			       struct kvm_device_attr *attr);
+int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
+			       struct kvm_device_attr *attr);
+int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
+			       struct kvm_device_attr *attr);
 
 #endif /* __ARM_KVM_HOST_H__ */
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index fa6182a..acea05e 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -301,3 +301,45 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 {
 	return -EINVAL;
 }
+
+int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
+			       struct kvm_device_attr *attr)
+{
+	int ret;
+
+	switch (attr->group) {
+	default:
+		ret = -ENXIO;
+		break;
+	}
+
+	return ret;
+}
+
+int kvm_arm_vcpu_arch_get_attr(struct kvm_vcpu *vcpu,
+			       struct kvm_device_attr *attr)
+{
+	int ret;
+
+	switch (attr->group) {
+	default:
+		ret = -ENXIO;
+		break;
+	}
+
+	return ret;
+}
+
+int kvm_arm_vcpu_arch_has_attr(struct kvm_vcpu *vcpu,
+			       struct kvm_device_attr *attr)
+{
+	int ret;
+
+	switch (attr->group) {
+	default:
+		ret = -ENXIO;
+		break;
+	}
+
+	return ret;
+}
-- 
2.9.0
