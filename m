From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 28 Sep 2018 14:39:08 +0100
Subject: [RFC PATCH v2 04/23] KVM: arm64: Add missing #include of
 <linux/bitmap.h> to kvm_host.h
In-Reply-To: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1538141967-15375-5-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kvm_host.h uses DECLARE_BITMAP() to declare the features member of
struct vcpu_arch, but the corresponding #include for this is
missing.

This patch adds a suitable #include for <linux/bitmap.h>.  Although
the header builds without it today, this should help to avoid
future surprises.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 3d6d733..6316a57 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -22,6 +22,7 @@
 #ifndef __ARM64_KVM_HOST_H__
 #define __ARM64_KVM_HOST_H__
 
+#include <linux/bitmap.h>
 #include <linux/types.h>
 #include <linux/kvm_types.h>
 #include <asm/cpufeature.h>
-- 
2.1.4
