From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jul 2016 18:28:28 +0100
Subject: [PATCH 11/55] arm64: Add ARM64_HYP_OFFSET_LOW capability
In-Reply-To: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
References: <1469208552-4155-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1469208552-4155-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we need to indicate to the rest of the kernel which region of
the HYP VA space is safe to use, add a capability that will
indicate that KVM should use the [VA_BITS-2:0] range.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/cpufeature.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 224efe7..d40edbb 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -36,8 +36,9 @@
 #define ARM64_HAS_VIRT_HOST_EXTN		11
 #define ARM64_WORKAROUND_CAVIUM_27456		12
 #define ARM64_HAS_32BIT_EL0			13
+#define ARM64_HYP_OFFSET_LOW			14
 
-#define ARM64_NCAPS				14
+#define ARM64_NCAPS				15
 
 #ifndef __ASSEMBLY__
 
-- 
2.8.1
