From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 20:18:47 +0200
Subject: [PATCH 01/16] KVM: Add capability to advertise PSCI v0.2 support
In-Reply-To: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
References: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1401041942-23471-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anup Patel <anup.patel@linaro.org>

User space (i.e. QEMU or KVMTOOL) should be able to check whether KVM
ARM/ARM64 supports in-kernel PSCI v0.2 emulation. For this purpose, we
define KVM_CAP_ARM_PSCI_0_2 in KVM user space interface header.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 836e15b..f3252b1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -746,6 +746,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_IRQCHIP 99
 #define KVM_CAP_IOEVENTFD_NO_LENGTH 100
 #define KVM_CAP_VM_ATTRIBUTES 101
+#define KVM_CAP_ARM_PSCI_0_2 102
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.8.5.2
