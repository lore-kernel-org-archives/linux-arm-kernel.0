From: anup.patel@linaro.org (Anup Patel)
Date: Tue, 21 Jan 2014 18:31:39 +0530
Subject: [RFC PATCH 1/3] KVM: Add capability to advertise PSCI v0.2 support
In-Reply-To: <1390309301-28424-1-git-send-email-anup.patel@linaro.org>
References: <1390309301-28424-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1390309301-28424-2-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

User space (i.e. QEMU or KVMTOOL) should be able to check whether KVM
ARM/ARM64 supports in-kernel PSCI v0.2 emulation. For this purpose, we
define KVM_CAP_ARM_PSCI_0_2 in KVM user space interface header.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
---
 include/uapi/linux/kvm.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 902f124..d64349e 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -674,6 +674,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_ARM_EL1_32BIT 93
 #define KVM_CAP_SPAPR_MULTITCE 94
 #define KVM_CAP_EXT_EMUL_CPUID 95
+#define KVM_CAP_ARM_PSCI_0_2 96
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.7.9.5
