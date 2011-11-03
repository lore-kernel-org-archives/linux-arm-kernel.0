From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 3 Nov 2011 19:00:47 +0200
Subject: [PATCH 3/3] ARM: mach-ux500 Use CONFIG_ARCH_NR_GPIO
In-Reply-To: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
References: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1320339647-30255-4-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add default value for CONFIG_ARCH_NR_GPIO to Kconfig and remove the definition
in gpio.h. We can't remove gpio.h yet as asm/gpio.h still includes it.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-ux500/include/mach/gpio.h |    5 -----
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b9cfa99..8da1f5f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1510,6 +1510,7 @@ config LOCAL_TIMERS
 config ARCH_NR_GPIO
 	int
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
+	default 350 if ARCH_U8500
 	default 0
 	help
 	  Maximum number of GPIOs in the system.
diff --git a/arch/arm/mach-ux500/include/mach/gpio.h b/arch/arm/mach-ux500/include/mach/gpio.h
index 7389df9..c01ef66 100644
--- a/arch/arm/mach-ux500/include/mach/gpio.h
+++ b/arch/arm/mach-ux500/include/mach/gpio.h
@@ -1,10 +1,5 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H
 
-/*
- * 288 (#267 is the highest one actually hooked up) onchip GPIOs, plus enough
- * room for a couple of GPIO expanders.
- */
-#define ARCH_NR_GPIOS	350
 
 #endif /* __ASM_ARCH_GPIO_H */
-- 
1.7.7.rc0.72.g4b5ea.dirty
