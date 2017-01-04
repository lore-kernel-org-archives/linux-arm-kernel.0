From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed,  4 Jan 2017 17:49:02 +0000
Subject: [PATCH v3 4/9] arm64: cpufeature: Document the rules of safe value
 for features
In-Reply-To: <1483552147-9605-1-git-send-email-suzuki.poulose@arm.com>
References: <1483552147-9605-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1483552147-9605-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the rules for choosing the safe value for different types
of features.

Cc: Dave Martin <dave.martin@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index b4989df..fb76c81 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -29,7 +29,21 @@
 #include <linux/jump_label.h>
 #include <linux/kernel.h>
 
-/* CPU feature register tracking */
+/*
+ * CPU feature register tracking
+ *
+ * The safe value of a CPUID feature field is dependent on the implications
+ * of the values assigned to it by the architecture. Based on the relationship
+ * between the values, the features are classified into 3 types.
+ *
+ * a) LOWER_SAFE - The value 'n+1' indicates, value 'n' and some
+ *    additional features. (where n >= 0). The smaller value (n) is
+ *    considered safer in this case.
+ * b) HIGHER_SAFE - The value 'n+1' is safer than 'n' (for n>= 0).
+ * c) EXACT - If the values of the feature don't have any relationship,
+ *    a predefined safe value is used.
+ */
+
 enum ftr_type {
 	FTR_EXACT,	/* Use a predefined safe value */
 	FTR_LOWER_SAFE,	/* Smaller value is safe */
-- 
2.7.4
