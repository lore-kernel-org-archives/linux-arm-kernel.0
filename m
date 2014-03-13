From: a.motakis@virtualopensystems.com (Antonios Motakis)
Date: Thu, 13 Mar 2014 16:57:29 +0100
Subject: [RFC PATCH 4/4] ARM: KVM: enable KVM_CAP_IOEVENTFD
In-Reply-To: <1394726249-1547-1-git-send-email-a.motakis@virtualopensystems.com>
References: <1394726249-1547-1-git-send-email-a.motakis@virtualopensystems.com>
Message-ID: <1394726249-1547-5-git-send-email-a.motakis@virtualopensystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM on ARM can now advertise support for the ioeventfd capability.

Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>
Signed-off-by: Nikolay Nikolaev <n.nikolaev@virtualopensystems.com>
---
 arch/arm/kvm/arm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index bd18bb8..08cd89b 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -211,6 +211,9 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
 		break;
+	case KVM_CAP_IOEVENTFD:
+		r = 1;
+		break;
 	default:
 		r = kvm_arch_dev_ioctl_check_extension(ext);
 		break;
-- 
1.8.3.2
