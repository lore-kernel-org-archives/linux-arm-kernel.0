From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  9 Mar 2017 09:55:37 +0000
Subject: [PATCH 08/10] KVM: arm/arm64: Enable KVM_CAP_NR_MEMSLOTS on arm/arm64
In-Reply-To: <20170309095539.14512-1-marc.zyngier@arm.com>
References: <20170309095539.14512-1-marc.zyngier@arm.com>
Message-ID: <20170309095539.14512-9-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

Return KVM_USER_MEM_SLOTS for userspace capability query on
NR_MEMSLOTS.

Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index c9a2103faeb9..96dba7cd8be7 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -221,6 +221,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
 		break;
+	case KVM_CAP_NR_MEMSLOTS:
+		r = KVM_USER_MEM_SLOTS;
+		break;
 	case KVM_CAP_MSI_DEVID:
 		if (!kvm)
 			r = -EINVAL;
-- 
2.11.0
