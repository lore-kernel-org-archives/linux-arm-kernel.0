From: mcuelenaere@gmail.com (Maurus Cuelenaere)
Date: Thu, 21 Oct 2010 18:54:30 -0000
Subject: [PATCH 2/4] ARM: SAMSUNG: Fix warning 's3c_pm_show_resume_irqs'
	defined but not used
In-Reply-To: <cover.1287681256.git.mcuelenaere@gmail.com>
References: <cover.1287681256.git.mcuelenaere@gmail.com>
Message-ID: <f4d162aad052ed332cceb63be6f2d32dc3dfbdd7.1287681256.git.mcuelenaere@gmail.com>
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
