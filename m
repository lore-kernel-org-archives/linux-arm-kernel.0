From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  9 Jan 2017 17:28:27 +0000
Subject: [PATCH v4 4/9] arm64: cpufeature: Document the rules of safe value
 for features
In-Reply-To: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
References: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1483982912-27215-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the rules for choosing the safe value for different types
of features.

Cc: Dave Martin <dave.martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v3:
 - Reworded the comment
---
 arch/arm64/include/asm/cpufeature.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b4989df..10d5624 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -29,7 +29,20 @@
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 
-/* CPU feature register tracking */
+/*
+ * CPU feature register tracking
+ *
+ * The safe value of a CPUID feature field is dependent on the implications
+ * of the values assigned to it by the architecture. Based on the relationship
+ * between the values, the features are classified into 3 types - LOWER_SAFE,
+ * HIGHER_SAFE and EXACT.
+ *
+ * The lowest value of all the CPUs is chosen for LOWER_SAFE and highest
+ * for HIGHER_SAFE. It is expected that all CPUs have the same value for
+ * a field when EXACT is specified, failing which, the safe value specified
+ * in the table is chosen.
+ */
+
 enum ftr_type {
 	FTR_EXACT,	/* Use a predefined safe value */
 	FTR_LOWER_SAFE,	/* Smaller value is safe */
-- 
2.7.4
