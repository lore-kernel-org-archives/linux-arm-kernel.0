From: cdall@linaro.org (Christoffer Dall)
Date: Sun, 23 Apr 2017 19:09:24 +0200
Subject: [PULL 74/79] KVM: arm/arm64: Advertise support for
 KVM_CAP_ARM_USER_IRQ
In-Reply-To: <20170423170929.27334-1-cdall@linaro.org>
References: <20170423170929.27334-1-cdall@linaro.org>
Message-ID: <20170423170929.27334-75-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

Now that we support both timers and PMU reporting interrupts
to userspace, we can advertise this support.

Reviewed-by: Alexander Graf <agraf@suse.de>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9eda293..7941699 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -229,6 +229,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
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
