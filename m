From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 04 Jul 2014 19:48:03 +0200
Subject: [PATCH 03/19] cpufreq: s3c24xx: Remove some dead code
In-Reply-To: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
References: <1404496099-26708-1-git-send-email-t.figa@samsung.com>
Message-ID: <1404496099-26708-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no use for the .resume_clocks() callback now and in fact all
the provided functions are empty, so this patch just removes it in
preparation for further patches.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm at vger.kernel.org
---
 drivers/cpufreq/s3c2410-cpufreq.c | 2 --
 drivers/cpufreq/s3c2412-cpufreq.c | 3 ---
 drivers/cpufreq/s3c2440-cpufreq.c | 3 ---
 drivers/cpufreq/s3c24xx-cpufreq.c | 1 -
 4 files changed, 9 deletions(-)

diff --git a/drivers/cpufreq/s3c2410-cpufreq.c b/drivers/cpufreq/s3c2410-cpufreq.c
index cfa0dd8..b8e5da8 100644
--- a/drivers/cpufreq/s3c2410-cpufreq.c
+++ b/drivers/cpufreq/s3c2410-cpufreq.c
@@ -26,7 +26,6 @@
 #include <mach/regs-clock.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
 #include <plat/cpu-freq-core.h>
 
 /* Note, 2410A has an extra mode for 1:4:4 ratio, bit 2 of CLKDIV */
@@ -104,7 +103,6 @@ static struct s3c_cpufreq_info s3c2410_cpufreq_info = {
 	.calc_iotiming	= s3c2410_iotiming_calc,
 	.set_iotiming	= s3c2410_iotiming_set,
 	.get_iotiming	= s3c2410_iotiming_get,
-	.resume_clocks	= s3c2410_setup_clocks,
 
 	.set_fvco	= s3c2410_set_fvco,
 	.set_refresh	= s3c2410_cpufreq_setrefresh,
diff --git a/drivers/cpufreq/s3c2412-cpufreq.c b/drivers/cpufreq/s3c2412-cpufreq.c
index 4645b48..eb26213 100644
--- a/drivers/cpufreq/s3c2412-cpufreq.c
+++ b/drivers/cpufreq/s3c2412-cpufreq.c
@@ -28,7 +28,6 @@
 #include <mach/s3c2412.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
 #include <plat/cpu-freq-core.h>
 
 /* our clock resources. */
@@ -188,8 +187,6 @@ static struct s3c_cpufreq_info s3c2412_cpufreq_info = {
 	.set_iotiming	= s3c2412_iotiming_set,
 	.get_iotiming	= s3c2412_iotiming_get,
 
-	.resume_clocks	= s3c2412_setup_clocks,
-
 	.debug_io_show  = s3c_cpufreq_debugfs_call(s3c2412_iotiming_debugfs),
 };
 
diff --git a/drivers/cpufreq/s3c2440-cpufreq.c b/drivers/cpufreq/s3c2440-cpufreq.c
index f84ed10..0129f5c 100644
--- a/drivers/cpufreq/s3c2440-cpufreq.c
+++ b/drivers/cpufreq/s3c2440-cpufreq.c
@@ -29,7 +29,6 @@
 
 #include <plat/cpu.h>
 #include <plat/cpu-freq-core.h>
-#include <plat/clock.h>
 
 static struct clk *xtal;
 static struct clk *fclk;
@@ -262,8 +261,6 @@ static struct s3c_cpufreq_info s3c2440_cpufreq_info = {
 	.calc_divs	= s3c2440_cpufreq_calcdivs,
 	.calc_freqtable	= s3c2440_cpufreq_calctable,
 
-	.resume_clocks	= s3c244x_setup_clocks,
-
 	.debug_io_show  = s3c_cpufreq_debugfs_call(s3c2410_iotiming_debugfs),
 };
 
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 227ebf7..d00f1ce 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -27,7 +27,6 @@
 #include <asm/mach/map.h>
 
 #include <plat/cpu.h>
-#include <plat/clock.h>
 #include <plat/cpu-freq-core.h>
 
 #include <mach/regs-clock.h>
-- 
1.9.3
