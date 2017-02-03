From: cdall@linaro.org (Christoffer Dall)
Date: Fri,  3 Feb 2017 15:56:55 +0100
Subject: [PATCH v2 5/5] KVM: arm/arm64: Advertise support for
 KVM_CAP_ARM_USER_IRQ
In-Reply-To: <20170203145655.15007-1-cdall@linaro.org>
References: <20170203145655.15007-1-cdall@linaro.org>
Message-ID: <20170203145655.15007-6-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Now when we support both the virtual timer and PMU reporting interrupts
to userspace, we can advertise this support.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 92f38f6..71cf78e 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -226,6 +226,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		else
 			r = kvm->arch.vgic.msis_require_devid;
 		break;
+	case KVM_CAP_ARM_USER_IRQ:
+		/*
+		 * 1: EL1_VTIMER, EL1_PTIMER, and PMU.
+		 * (bump this number if adding more devices)
+		 */
+		r = 1;
+		break;
 	default:
 		r = kvm_arch_dev_ioctl_check_extension(kvm, ext);
 		break;
-- 
2.9.0
