From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 20:18:58 +0200
Subject: [PATCH 12/16] ARM/ARM64: KVM: Advertise KVM_CAP_ARM_PSCI_0_2 to user
 space
In-Reply-To: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
References: <1401041942-23471-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1401041942-23471-13-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anup Patel <anup.patel@linaro.org>

We have PSCI v0.2 emulation available in KVM ARM/ARM64
hence advertise this to user space (i.e. QEMU or KVMTOOL)
via KVM_CHECK_EXTENSION ioctl.

Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/arm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index f0e50a0..3c82b37 100644
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
-- 
1.8.5.2
