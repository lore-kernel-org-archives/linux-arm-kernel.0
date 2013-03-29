From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 29 Mar 2013 11:31:32 +0100
Subject: [PATCH 6/9] ARM: tegra: cpuidle: remove useless initialization
In-Reply-To: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364553095-25110-6-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dev->state_count is initialized automatically by cpuidle_register_device.

When drv->state_count is equal to dev->state_count, no need to init this
field, so removing it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-tegra/cpuidle-tegra114.c |    1 -
 arch/arm/mach-tegra/cpuidle-tegra20.c  |    1 -
 arch/arm/mach-tegra/cpuidle-tegra30.c  |    1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
index 0f4e8c4..c527cff 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra114.c
@@ -49,7 +49,6 @@ int __init tegra114_cpuidle_init(void)
 		dev = &per_cpu(tegra_idle_device, cpu);
 		dev->cpu = cpu;
 
-		dev->state_count = drv->state_count;
 		ret = cpuidle_register_device(dev);
 		if (ret) {
 			pr_err("CPU%u: CPUidle device registration failed\n",
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
index 1ad1a67..b94d76a 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
@@ -243,7 +243,6 @@ int __init tegra20_cpuidle_init(void)
 		dev->coupled_cpus = *cpu_possible_mask;
 #endif
 
-		dev->state_count = drv->state_count;
 		ret = cpuidle_register_device(dev);
 		if (ret) {
 			pr_err("CPU%u: CPUidle device registration failed\n",
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
index 8b50cf4..c4e01fe 100644
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ b/arch/arm/mach-tegra/cpuidle-tegra30.c
@@ -176,7 +176,6 @@ int __init tegra30_cpuidle_init(void)
 		dev = &per_cpu(tegra_idle_device, cpu);
 		dev->cpu = cpu;
 
-		dev->state_count = drv->state_count;
 		ret = cpuidle_register_device(dev);
 		if (ret) {
 			pr_err("CPU%u: CPUidle device registration failed\n",
-- 
1.7.9.5
