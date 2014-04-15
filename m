From: anup.patel@linaro.org (Anup Patel)
Date: Tue, 15 Apr 2014 11:44:04 +0530
Subject: [PATCH v9 01/12] KVM: Add capability to advertise PSCI v0.2 support
In-Reply-To: <1397542455-354-1-git-send-email-anup.patel@linaro.org>
References: <1397542455-354-1-git-send-email-anup.patel@linaro.org>
Message-ID: <1397542455-354-2-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

User space (i.e. QEMU or KVMTOOL) should be able to check whether KVM
ARM/ARM64 supports in-kernel PSCI v0.2 emulation. For this purpose, we
define KVM_CAP_ARM_PSCI_0_2 in KVM user space interface header.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/uapi/linux/kvm.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a8f4ee5..01c5624 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -743,6 +743,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_IOAPIC_POLARITY_IGNORED 97
 #define KVM_CAP_ENABLE_CAP_VM 98
 #define KVM_CAP_S390_IRQCHIP 99
+#define KVM_CAP_ARM_PSCI_0_2 100
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.7.9.5
