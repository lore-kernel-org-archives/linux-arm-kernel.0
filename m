From: olof@lixom.net (Olof Johansson)
Date: Sun,  9 Oct 2011 22:28:04 -0700
Subject: [PATCH v2 14/14] ARM: tegra: cpu-tegra: unexport two functions
In-Reply-To: <1318224484-2090-1-git-send-email-olof@lixom.net>
References: <1317956064-17650-1-git-send-email-olof@lixom.net>
	<1318224484-2090-1-git-send-email-olof@lixom.net>
Message-ID: <1318224484-2090-15-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two static functions that are not exported:

arch/arm/mach-tegra/cpu-tegra.c:59:5: warning: symbol 'tegra_verify_speed' was not declared. Should it be static?
arch/arm/mach-tegra/cpu-tegra.c:64:14: warning: symbol 'tegra_getspeed' was not declared. Should it be static?

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/cpu-tegra.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/cpu-tegra.c b/arch/arm/mach-tegra/cpu-tegra.c
index f15b689..b2647ec 100644
--- a/arch/arm/mach-tegra/cpu-tegra.c
+++ b/arch/arm/mach-tegra/cpu-tegra.c
@@ -57,12 +57,12 @@ static unsigned long target_cpu_speed[NUM_CPUS];
 static DEFINE_MUTEX(tegra_cpu_lock);
 static bool is_suspended;
 
-int tegra_verify_speed(struct cpufreq_policy *policy)
+static int tegra_verify_speed(struct cpufreq_policy *policy)
 {
 	return cpufreq_frequency_table_verify(policy, freq_table);
 }
 
-unsigned int tegra_getspeed(unsigned int cpu)
+static unsigned int tegra_getspeed(unsigned int cpu)
 {
 	unsigned long rate;
 
-- 
1.7.4.1
