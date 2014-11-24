From: n.nikolaev@virtualopensystems.com (Nikolay Nikolaev)
Date: Mon, 24 Nov 2014 23:27:14 +0200
Subject: [RFC PATCH 5/5] ARM: enable KVM_CAP_IOEVENTFD
In-Reply-To: <20141124212240.10605.46770.stgit@i3820>
References: <20141124212240.10605.46770.stgit@i3820>
Message-ID: <20141124212714.10605.63574.stgit@i3820>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM on arm will support the eventfd extension.

Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
---
 arch/arm/kvm/arm.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index c3d0fbd..266b618 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -197,6 +197,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
 		break;
+	case KVM_CAP_IOEVENTFD:
+		r = 1;
+		break;
 	default:
 		r = kvm_arch_dev_ioctl_check_extension(ext);
 		break;
