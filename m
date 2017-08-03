From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu,  3 Aug 2017 15:58:41 +0530
Subject: [PATCH] arm64: defconfig: Enable CONFIG_WQ_POWER_EFFICIENT_DEFAULT
Message-ID: <9fdfdc9f1593f0fb7780641ca0a9fba54baa1441.1501755972.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit cee22a15052f ("workqueues: Introduce new flag WQ_POWER_EFFICIENT
for power oriented workqueues") introduced the concept of power
efficient workqueues (4 years back), but it was never enabled in
upstream kernel configs.

Power efficient workqueues are simply marked as "unbound," so that jobs
queued to them can run on any CPU in the system. It leaves the target
CPU selection to the scheduler, which is the best place for such
decision making. This improves power efficiency for workqueues which are
otherwise pinned to a CPU.

Enable it for ARM64 platforms as ARM platforms were the main target for
the introduction of power efficient workqueues.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f16d5097a8c7..460a7c991a52 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -88,6 +88,7 @@ CONFIG_XEN=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
 CONFIG_HIBERNATION=y
+CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPUFREQ_DT=y
-- 
2.13.0.71.gd7076ec9c9cb
