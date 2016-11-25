From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:39:08 +0000
Subject: [RFC PATCH 20/29] arm64/sve: traps: Add descriptive string for SVE
 exceptions
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-21-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for SVE trapping in userspace, let's print something
relevant instead of "UNREGOCNIZED EC" when an unhandled SVE
exception occurs.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/esr.h | 3 ++-
 arch/arm64/kernel/traps.c    | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index d14c478..87729f3 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -42,7 +42,8 @@
 #define ESR_ELx_EC_HVC64	(0x16)
 #define ESR_ELx_EC_SMC64	(0x17)
 #define ESR_ELx_EC_SYS64	(0x18)
-/* Unallocated EC: 0x19 - 0x1E */
+#define ESR_ELx_EC_SVE		(0x19)
+/* Unallocated EC: 0x1A - 0x1E */
 #define ESR_ELx_EC_IMP_DEF	(0x1f)
 #define ESR_ELx_EC_IABT_LOW	(0x20)
 #define ESR_ELx_EC_IABT_CUR	(0x21)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c9986b3..aaab1dd 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -569,6 +569,7 @@ static const char *esr_class_str[] = {
 	[ESR_ELx_EC_HVC64]		= "HVC (AArch64)",
 	[ESR_ELx_EC_SMC64]		= "SMC (AArch64)",
 	[ESR_ELx_EC_SYS64]		= "MSR/MRS (AArch64)",
+	[ESR_ELx_EC_SVE]		= "SVE",
 	[ESR_ELx_EC_IMP_DEF]		= "EL3 IMP DEF",
 	[ESR_ELx_EC_IABT_LOW]		= "IABT (lower EL)",
 	[ESR_ELx_EC_IABT_CUR]		= "IABT (current EL)",
-- 
2.1.4
