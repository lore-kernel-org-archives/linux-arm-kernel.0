From: anup.patel@linaro.org (Anup Patel)
Date: Tue,  4 Feb 2014 15:18:16 +0530
Subject: [PATCH v3 4/4] ARM/ARM64: KVM: Allow KVM_ARM_VCPU_PSCI_0_2 feature
 for user space
In-Reply-To: <1391507296-2099-1-git-send-email-anup.patel@linaro.org>
References: <1391507296-2099-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1391507296-2099-5-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow user space to set KVM_ARM_VCPU_PSCI_0_2 feature because all
mandatory PSCI v0.2 functions (i.e. complete PSCI v0.2) are available.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/kvm/guest.c   |    3 ---
 arch/arm64/kvm/guest.c |    3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index 89929b6..b23a59c 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -307,9 +307,6 @@ int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 		if (test_bit(i, (void *)init->features)) {
 			if (i >= KVM_VCPU_MAX_FEATURES)
 				return -ENOENT;
-			/* Don't allow setting experimental features */
-			if (i == KVM_ARM_VCPU_PSCI_0_2)
-				return -ENOENT;
 			set_bit(i, vcpu->arch.features);
 		}
 	}
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index b27877c..0874557 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -246,9 +246,6 @@ int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 		if (init->features[i / 32] & (1 << (i % 32))) {
 			if (i >= KVM_VCPU_MAX_FEATURES)
 				return -ENOENT;
-			/* Don't allow setting experimental features */
-			if (i == KVM_ARM_VCPU_PSCI_0_2)
-				return -ENOENT;
 			set_bit(i, vcpu->arch.features);
 		}
 	}
-- 
1.7.9.5
