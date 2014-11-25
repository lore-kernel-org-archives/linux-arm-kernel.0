From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 25 Nov 2014 13:27:42 +0000
Subject: [PATCH 2/3] arm64: sanity checks: add missing newline to print
In-Reply-To: <1416922063-8693-1-git-send-email-mark.rutland@arm.com>
References: <1416922063-8693-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1416922063-8693-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A missing newline in the WARN_TAINT_ONCE string results in ugly and
somewhat difficult to read output in the case of a sanity check failure,
as the next print does not appear on a new line:

  Unsupported CPU feature variation.Modules linked in:

This patch adds the missing newline, fixing the output formatting.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpuinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index a9ab5b0..1191472 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -160,7 +160,7 @@ static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
 	 * pretend to support them.
 	 */
 	WARN_TAINT_ONCE(diff, TAINT_CPU_OUT_OF_SPEC,
-			"Unsupported CPU feature variation.");
+			"Unsupported CPU feature variation.\n");
 }
 
 static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
-- 
1.9.1
