From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue,  9 Jun 2015 22:47:07 +0100
Subject: [PATCH] ARM: STi: Remove platform call to trace_hardirqs_off()
Message-ID: <1433886427-29295-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling trace_hardirqs_off() from the platform specific
secondary startup code as not been necessary since Dec 2010
when Russell King consolidated the call into the common SMP
code.

2c0136d ARM: SMP: consolidate trace_hardirqs_off() into common SMP code

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/mach-sti/platsmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index d4b624f..a39f812 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -38,8 +38,6 @@ static DEFINE_SPINLOCK(boot_lock);
 
 static void sti_secondary_init(unsigned int cpu)
 {
-	trace_hardirqs_off();
-
 	/*
 	 * let the primary processor know we're out of the
 	 * pen, then head off into the C entry point
-- 
1.9.1
