From: robherring2@gmail.com (Rob Herring)
Date: Sun, 30 Dec 2012 10:15:04 -0600
Subject: [PATCH 3/6] ARM: highbank: fix typos with hignbank in power request
 functions
In-Reply-To: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
References: <1356884107-30991-1-git-send-email-robherring2@gmail.com>
Message-ID: <1356884107-30991-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

s/hignbank/highbank/

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/highbank.c |    2 +-
 arch/arm/mach-highbank/pm.c       |    2 +-
 arch/arm/mach-highbank/sysregs.h  |    8 ++++----
 arch/arm/mach-highbank/system.c   |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-highbank/highbank.c b/arch/arm/mach-highbank/highbank.c
index dc24816..981dc1e 100644
--- a/arch/arm/mach-highbank/highbank.c
+++ b/arch/arm/mach-highbank/highbank.c
@@ -135,7 +135,7 @@ static struct sys_timer highbank_timer = {
 
 static void highbank_power_off(void)
 {
-	hignbank_set_pwr_shutdown();
+	highbank_set_pwr_shutdown();
 
 	while (1)
 		cpu_do_idle();
diff --git a/arch/arm/mach-highbank/pm.c b/arch/arm/mach-highbank/pm.c
index 74aa135..0f4ffd6 100644
--- a/arch/arm/mach-highbank/pm.c
+++ b/arch/arm/mach-highbank/pm.c
@@ -32,7 +32,7 @@ static int highbank_suspend_finish(unsigned long val)
 
 static int highbank_pm_enter(suspend_state_t state)
 {
-	hignbank_set_pwr_suspend();
+	highbank_set_pwr_suspend();
 	highbank_set_cpu_jump(0, cpu_resume);
 	cpu_suspend(0, highbank_suspend_finish);
 
diff --git a/arch/arm/mach-highbank/sysregs.h b/arch/arm/mach-highbank/sysregs.h
index e13e8ea..707cfd3 100644
--- a/arch/arm/mach-highbank/sysregs.h
+++ b/arch/arm/mach-highbank/sysregs.h
@@ -44,25 +44,25 @@ static inline void highbank_set_core_pwr(void)
 		writel_relaxed(1, sregs_base + SREG_CPU_PWR_CTRL(cpu));
 }
 
-static inline void hignbank_set_pwr_suspend(void)
+static inline void highbank_set_pwr_suspend(void)
 {
 	writel(HB_PWR_SUSPEND, sregs_base + HB_SREG_A9_PWR_REQ);
 	highbank_set_core_pwr();
 }
 
-static inline void hignbank_set_pwr_shutdown(void)
+static inline void highbank_set_pwr_shutdown(void)
 {
 	writel(HB_PWR_SHUTDOWN, sregs_base + HB_SREG_A9_PWR_REQ);
 	highbank_set_core_pwr();
 }
 
-static inline void hignbank_set_pwr_soft_reset(void)
+static inline void highbank_set_pwr_soft_reset(void)
 {
 	writel(HB_PWR_SOFT_RESET, sregs_base + HB_SREG_A9_PWR_REQ);
 	highbank_set_core_pwr();
 }
 
-static inline void hignbank_set_pwr_hard_reset(void)
+static inline void highbank_set_pwr_hard_reset(void)
 {
 	writel(HB_PWR_HARD_RESET, sregs_base + HB_SREG_A9_PWR_REQ);
 	highbank_set_core_pwr();
diff --git a/arch/arm/mach-highbank/system.c b/arch/arm/mach-highbank/system.c
index aed96ad..37d8384 100644
--- a/arch/arm/mach-highbank/system.c
+++ b/arch/arm/mach-highbank/system.c
@@ -22,9 +22,9 @@
 void highbank_restart(char mode, const char *cmd)
 {
 	if (mode == 'h')
-		hignbank_set_pwr_hard_reset();
+		highbank_set_pwr_hard_reset();
 	else
-		hignbank_set_pwr_soft_reset();
+		highbank_set_pwr_soft_reset();
 
 	while (1)
 		cpu_do_idle();
-- 
1.7.10.4
