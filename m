From: joe@perches.com (Joe Perches)
Date: Sat, 13 Apr 2013 22:55:45 -0700
Subject: [PATCH] ARM: KVM: Add missing break;
In-Reply-To: <1365917315-3615-1-git-send-email-linux@prisktech.co.nz>
References: <1365917315-3615-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1365918945.1878.8.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 3401d54696f ("KVM: ARM: Introduce KVM_ARM_SET_DEVICE_ADDR ioctl")
added the case, but omitted adding break;

Add it.

Found with grep version 2.54 pattern:

$ grep -rP --include=*.[ch] "\b(\w+)\s*=[^;]+;\s*(?:case\s+\w+:|default:)\s*\1\s*="

Signed-off-by: Joe Perches <joe@perches.com>
---
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 5777e0c..b9f2228 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -198,6 +198,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 		break;
 	case KVM_CAP_ARM_SET_DEVICE_ADDR:
 		r = 1;
+		break;
 	case KVM_CAP_NR_VCPUS:
 		r = num_online_cpus();
 		break;
