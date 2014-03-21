From: anup.patel@linaro.org (Anup Patel)
Date: Fri, 21 Mar 2014 18:23:24 +0530
Subject: [PATCH v5 01/11] KVM: Add capability to advertise PSCI v0.2 support
In-Reply-To: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
References: <1395406414-11707-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1395406414-11707-2-git-send-email-anup.patel@linaro.org>
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
index a7518be..260d3ae 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -741,6 +741,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_EXT_EMUL_CPUID 95
 #define KVM_CAP_HYPERV_TIME 96
 #define KVM_CAP_IOAPIC_POLARITY_IGNORED 97
+#define KVM_CAP_ARM_PSCI_0_2 98
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.7.9.5
