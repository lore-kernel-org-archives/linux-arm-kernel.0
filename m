From: drjones@redhat.com (Andrew Jones)
Date: Sat, 14 Sep 2013 14:10:54 +0200
Subject: [PATCH 1/3] arm: kvm: clamp NR_VCPUS to MAX_VCPUS
In-Reply-To: <1379160656-28050-1-git-send-email-drjones@redhat.com>
References: <1379160656-28050-1-git-send-email-drjones@redhat.com>
Message-ID: <1379160656-28050-2-git-send-email-drjones@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arch/arm/kvm/arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 741f66a2edbd7..9ebf8ac3a12ff 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -201,7 +201,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 		r = 1;
 		break;
 	case KVM_CAP_NR_VCPUS:
-		r = num_online_cpus();
+		r = min(num_online_cpus(), KVM_MAX_VCPUS);
 		break;
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_MAX_VCPUS;
-- 
1.8.1.4
