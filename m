From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  6 Jan 2012 16:48:35 +0100
Subject: [PATCH 2/2] at91 : move cpuidle driver to drivers/cpuidle directory
In-Reply-To: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
References: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1325864915-794-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch follows the discussion about moving the cpuidle code which
is located in the architecture specific to the drivers directory.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-at91/Kconfig                         |    5 +++++
 arch/arm/mach-at91/Makefile                        |    1 -
 drivers/cpuidle/Makefile                           |    1 +
 .../cpuidle.c => drivers/cpuidle/at91_idle.c       |    0
 4 files changed, 6 insertions(+), 1 deletions(-)
 rename arch/arm/mach-at91/cpuidle.c => drivers/cpuidle/at91_idle.c (100%)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 4f991f2..ddeaf0e 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -18,6 +18,11 @@ config HAVE_AT91_USART4
 config HAVE_AT91_USART5
 	bool
 
+config AT91_IDLE
+	bool
+	default y
+	depends on CPU_IDLE
+
 menu "Atmel AT91 System-on-Chip"
 
 choice
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 242174f..ce0cd4c 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -91,7 +91,6 @@ obj-y				+= leds.o
 # Power Management
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_AT91_SLOW_CLOCK)	+= pm_slowclock.o
-obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
 
 ifeq ($(CONFIG_PM_DEBUG),y)
 CFLAGS_pm.o += -DDEBUG
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 5634f88..31c9b5f 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-y += cpuidle.o driver.o governor.o sysfs.o governors/
+obj-$(CONFIG_AT91_IDLE) += at91_idle.o
diff --git a/arch/arm/mach-at91/cpuidle.c b/drivers/cpuidle/at91_idle.c
similarity index 100%
rename from arch/arm/mach-at91/cpuidle.c
rename to drivers/cpuidle/at91_idle.c
-- 
1.7.4.1
