From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 19 Aug 2016 09:12:07 -0400
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Don't attempt to enable
 schedutil governor as module
In-Reply-To: <1471612328-6467-1-git-send-email-javier@osg.samsung.com>
References: <1471612328-6467-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1471612328-6467-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The schedutil CPUFreq governor could be built as a module but the commit
58919e83c85c ("cpufreq / sched: Pass flags to cpufreq_update_util()")
made it non-modular so attempting to enable as module leads to a warning:

warning: symbol value 'm' invalid for CPU_FREQ_GOV_SCHEDUTIL

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 0ccaa519f588..65b5b6172e83 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -136,7 +136,7 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=m
 CONFIG_CPU_FREQ_GOV_USERSPACE=m
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
-CONFIG_CPU_FREQ_GOV_SCHEDUTIL=m
+CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
 CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_QORIQ_CPUFREQ=y
 CONFIG_CPU_IDLE=y
-- 
2.5.5
