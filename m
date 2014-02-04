From: anup.patel@linaro.org (Anup Patel)
Date: Tue,  4 Feb 2014 15:18:14 +0530
Subject: [PATCH v3 2/4] KVM: Add capability to advertise PSCI v0.2 support
In-Reply-To: <1391507296-2099-1-git-send-email-anup.patel@linaro.org>
References: <1391507296-2099-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1391507296-2099-3-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

User space (i.e. QEMU or KVMTOOL) should be able to check whether KVM
ARM/ARM64 supports in-kernel PSCI v0.2 emulation. For this purpose, we
define KVM_CAP_ARM_PSCI_0_2 in KVM user space interface header.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 arch/arm/kvm/arm.c       |    1 +
 include/uapi/linux/kvm.h |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 1d8248e..c8a71df 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -197,6 +197,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
 	case KVM_CAP_ONE_REG:
 	case KVM_CAP_ARM_PSCI:
+	case KVM_CAP_ARM_PSCI_0_2:
 		r = 1;
 		break;
 	case KVM_CAP_COALESCED_MMIO:
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 932d7f2..fb3c3f3 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -675,6 +675,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_SPAPR_MULTITCE 94
 #define KVM_CAP_EXT_EMUL_CPUID 95
 #define KVM_CAP_HYPERV_TIME 96
+#define KVM_CAP_ARM_PSCI_0_2 97
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.7.9.5
