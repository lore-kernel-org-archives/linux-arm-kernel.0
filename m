From: n.nikolaev@virtualopensystems.com (Nikolay Nikolaev)
Date: Sat, 24 Jan 2015 14:00:02 +0200
Subject: [PATCH v3 5/5] ARM: enable KVM_CAP_IOEVENTFD
In-Reply-To: <20150124115815.11052.20755.stgit@i3820>
References: <20150124115815.11052.20755.stgit@i3820>
Message-ID: <20150124120002.11052.25542.stgit@i3820>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM on arm will support the eventfd extension.

Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
---
 arch/arm/kvm/arm.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 6fbfa5f..ec5ebef 100644
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
