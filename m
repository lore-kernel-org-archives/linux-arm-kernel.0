From: sachin.kamat@samsung.com (Sachin Kamat)
Date: Tue, 24 Jun 2014 17:13:48 +0530
Subject: [PATCH Resend 1/8] ARM: sti: Staticize local variables
Message-ID: <1403610235-22654-1-git-send-email-sachin.kamat@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sachin Kamat <sachin.kamat@linaro.org>

Symbols local to this file are made static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
Cc: kernel at stlinux.com
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/mach-sti/platsmp.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index fa2c33ffac04..d4b624f8dfcb 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -36,7 +36,7 @@ static void write_pen_release(int val)
 
 static DEFINE_SPINLOCK(boot_lock);
 
-void sti_secondary_init(unsigned int cpu)
+static void sti_secondary_init(unsigned int cpu)
 {
 	trace_hardirqs_off();
 
@@ -53,7 +53,7 @@ void sti_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
+static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	unsigned long timeout;
 
@@ -97,7 +97,7 @@ int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return pen_release != -1 ? -ENOSYS : 0;
 }
 
-void __init sti_smp_prepare_cpus(unsigned int max_cpus)
+static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 {
 	void __iomem *scu_base = NULL;
 	struct device_node *np = of_find_compatible_node(
-- 
1.7.9.5
