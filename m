From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Wed,  6 Oct 2010 01:30:50 +0200
Subject: [PATCH] ARM: SAMSUNG: Fix warning 's3c_pm_show_resume_irqs' defined
	but not used
Message-ID: <4cabb531.cf7d0e0a.19d7.08b2@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c_pm_show_resume_irqs() is used by some s3c_pm_arch_show_resume_irqs()
implementations, which get included through mach/pm-core.h. Add __maybe_unused
to silence warnings when it isn't used (e.g. on S3C64XX platforms).

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
---
 arch/arm/plat-samsung/pm.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
index 27cfca5..ad6dd63 100644
--- a/arch/arm/plat-samsung/pm.c
+++ b/arch/arm/plat-samsung/pm.c
@@ -214,8 +214,9 @@ void s3c_pm_do_restore_core(struct sleep_save *ptr, int count)
  *
  * print any IRQs asserted at resume time (ie, we woke from)
 */
-static void s3c_pm_show_resume_irqs(int start, unsigned long which,
-				    unsigned long mask)
+static void __maybe_unused s3c_pm_show_resume_irqs(int start,
+						   unsigned long which,
+						   unsigned long mask)
 {
 	int i;
 
-- 
1.7.2.3
