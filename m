From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri,  9 Aug 2013 07:30:13 -0700
Subject: [PATCH 2/3] KVM: ARM: Get rid of KVM_HPAGE_ defines
In-Reply-To: <1376021239-10532-1-git-send-email-christoffer.dall@linaro.org>
References: <1376021239-10532-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1376058613-26400-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The KVM_HPAGE_DEFINES are a little artificial on ARM, since the huge
page size is statically defined at compile time and there is only a
single huge page size.

Now when the main kvm code relying on these defines has been moved to
the x86 specific part of the world, we can get rid of these.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---

[Resending this because the KVM list filter caught the subject of the
previous message due to the letter X]

 arch/arm/include/asm/kvm_host.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 7d22517..e45a74b 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -38,11 +38,6 @@
 
 #define KVM_VCPU_MAX_FEATURES 1
 
-/* We don't currently support large pages. */
-#define KVM_HPAGE_GFN_SHIFT(x)	0
-#define KVM_NR_PAGE_SIZES	1
-#define KVM_PAGES_PER_HPAGE(x)	(1UL<<31)
-
 #include <kvm/arm_vgic.h>
 
 struct kvm_vcpu;
-- 
1.7.10.4
