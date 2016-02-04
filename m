From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:33 +0100
Subject: [PATCH 2/4] ARM: shmobile: Add includes providing forward declarations
In-Reply-To: <cover.1454595116.git.horms+renesas@verge.net.au>
References: <cover.1454595116.git.horms+renesas@verge.net.au>
Message-ID: <2e41e5fe88f99c03a77c4325870f160378b42268.1454595116.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

make C=1:

    arch/arm/mach-shmobile/timer.c:38:13: warning: symbol 'shmobile_init_delay' was not declared. Should it be static?
    arch/arm/mach-shmobile/suspend.c:37:29: warning: symbol 'shmobile_suspend_ops' was not declared. Should it be static?
    arch/arm/mach-shmobile/suspend.c:44:12: warning: symbol 'shmobile_suspend_init' was not declared. Should it be static?
    arch/arm/mach-shmobile/cpufreq.c:13:12: warning: symbol 'shmobile_cpufreq_init' was not declared. Should it be static?

Include "common.h" to fix these.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/cpufreq.c | 2 ++
 arch/arm/mach-shmobile/suspend.c | 2 ++
 arch/arm/mach-shmobile/timer.c   | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-shmobile/cpufreq.c b/arch/arm/mach-shmobile/cpufreq.c
index 57fbff024dcd..634d701c56a7 100644
--- a/arch/arm/mach-shmobile/cpufreq.c
+++ b/arch/arm/mach-shmobile/cpufreq.c
@@ -10,6 +10,8 @@
 
 #include <linux/platform_device.h>
 
+#include "common.h"
+
 int __init shmobile_cpufreq_init(void)
 {
 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
diff --git a/arch/arm/mach-shmobile/suspend.c b/arch/arm/mach-shmobile/suspend.c
index 5d92b5dd486b..74b30bade2c1 100644
--- a/arch/arm/mach-shmobile/suspend.c
+++ b/arch/arm/mach-shmobile/suspend.c
@@ -17,6 +17,8 @@
 #include <asm/io.h>
 #include <asm/system_misc.h>
 
+#include "common.h"
+
 static int shmobile_suspend_default_enter(suspend_state_t suspend_state)
 {
 	cpu_do_idle();
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index c17d4d3881ff..ad008e4b0c49 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -18,6 +18,8 @@
 #include <linux/delay.h>
 #include <linux/of_address.h>
 
+#include "common.h"
+
 static void __init shmobile_setup_delay_hz(unsigned int max_cpu_core_hz,
 					   unsigned int mult, unsigned int div)
 {
-- 
2.7.0.rc3.207.g0ac5344
