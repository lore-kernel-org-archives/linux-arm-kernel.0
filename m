From: linucherian@gmail.com (linucherian at gmail.com)
Date: Tue,  7 Mar 2017 11:22:42 +0530
Subject: [PATCH V3 2/4] KVM: arm/arm64: Enable KVM_CAP_NR_MEMSLOTS on arm/arm64
In-Reply-To: <1488865964-17346-1-git-send-email-linucherian@gmail.com>
References: <1488865964-17346-1-git-send-email-linucherian@gmail.com>
Message-ID: <1488865964-17346-3-git-send-email-linucherian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

Return KVM_USER_MEM_SLOTS for userspace capability query on
NR_MEMSLOTS.

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
---
 arch/arm/kvm/arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9d74464..b64b47f 100644
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
1.9.1
