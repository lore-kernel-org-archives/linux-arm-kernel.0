From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri,  8 Apr 2016 15:02:10 -0400
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable CPUFreq governors as
 modules
In-Reply-To: <1460142130-31822-1-git-send-email-javier@osg.samsung.com>
References: <1460142130-31822-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1460142130-31822-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently only the ondemand and performance CPUFreq policy governors are
enabled in multi_v7 defconfig. But the other governors are also useful
for some cases, enable them to allow users change the default if needed.

The options are enabled as module to keep the kernel image size minimal.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 arch/arm/configs/multi_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4eb10f5ea493..a8afbd9d4ead 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -131,6 +131,10 @@ CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_STAT_DETAILS=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=m
+CONFIG_CPU_FREQ_GOV_USERSPACE=m
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
+CONFIG_CPU_FREQ_GOV_SCHEDUTIL=m
 CONFIG_QORIQ_CPUFREQ=y
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
-- 
2.5.0
