From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 3 Nov 2011 19:00:45 +0200
Subject: [PATCH 1/3] ARM: ARCH_NR_GPIO: Make ARCH_NR_GPIO a Kconfig variable
In-Reply-To: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
References: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1320339647-30255-2-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change ARCH_NR_GPIO into a Kconfig variable as suggested by Russel King. This
makes ARCH_NR_GPIO single zImage friendly. The default value for tegra is
defined as well.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/Kconfig            |    9 +++++++++
 arch/arm/include/asm/gpio.h |    4 ++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7e8ffe7..924f685 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1507,6 +1507,15 @@ config LOCAL_TIMERS
 	  accounting to be spread across the timer interval, preventing a
 	  "thundering herd" at every timer tick.
 
+config ARCH_NR_GPIO
+	int
+	default 1024 if ARCH_TEGRA
+	default 0
+	help
+	  Maximum number of GPIOs in the system.
+
+	  If unsure, leave the default value.
+
 source kernel/Kconfig.preempt
 
 config HZ
diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
index 11ad0bf..7151753 100644
--- a/arch/arm/include/asm/gpio.h
+++ b/arch/arm/include/asm/gpio.h
@@ -1,6 +1,10 @@
 #ifndef _ARCH_ARM_GPIO_H
 #define _ARCH_ARM_GPIO_H
 
+#if CONFIG_ARCH_NR_GPIO > 0
+#define ARCH_NR_GPIO CONFIG_ARCH_NR_GPIO
+#endif
+
 /* not all ARM platforms necessarily support this API ... */
 #include <mach/gpio.h>
 
-- 
1.7.7.rc0.72.g4b5ea.dirty
