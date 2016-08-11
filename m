From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Aug 2016 17:59:26 +0100
Subject: [PATCH] arm: remove traces of perf_ops_bp
Message-ID: <1470934766-4009-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even though perf_ops_bp was removed/renamed back in commit
b0a873ebbf87bf38 ("perf: Register PMU implementations"), as part of
v2.6.37, its definition still lives on in some arch headers.

This patch removes the vestigal definition from arm.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/hw_breakpoint.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index 8e427c7..afcaf8b 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -114,7 +114,6 @@ struct notifier_block;
 struct perf_event;
 struct pmu;
 
-extern struct pmu perf_ops_bp;
 extern int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
 				  int *gen_len, int *gen_type);
 extern int arch_check_bp_in_kernelspace(struct perf_event *bp);
-- 
1.9.1
