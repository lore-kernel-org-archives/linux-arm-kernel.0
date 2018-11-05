From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  5 Nov 2018 13:06:40 +0000
Subject: [PATCH 01/10] arm64: remove bitop exports
In-Reply-To: <20181105130649.29429-1-mark.rutland@arm.com>
References: <20181105130649.29429-1-mark.rutland@arm.com>
Message-ID: <20181105130649.29429-2-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the arm64 bitops are inlines built atop of the regular atomics,
we don't need to export anything.

Remove the redundant exports.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/arm64ksyms.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 72f63a59b008..c4003c18a18b 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -62,14 +62,6 @@ EXPORT_SYMBOL(__memset);
 EXPORT_SYMBOL(__memcpy);
 EXPORT_SYMBOL(__memmove);
 
-	/* atomic bitops */
-EXPORT_SYMBOL(set_bit);
-EXPORT_SYMBOL(test_and_set_bit);
-EXPORT_SYMBOL(clear_bit);
-EXPORT_SYMBOL(test_and_clear_bit);
-EXPORT_SYMBOL(change_bit);
-EXPORT_SYMBOL(test_and_change_bit);
-
 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(_mcount);
 NOKPROBE_SYMBOL(_mcount);
-- 
2.11.0
