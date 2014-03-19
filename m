From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:41 +0100
Subject: [PATCH 44/62] ARM: integrator: refine CPU selection
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-45-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a new Kconfig option for the Integrator platform to
choose between ARMv4/ARMv5 based CPUs and those based on ARMv6/ARMv7,
which is required because we cannot have both classes enabled in the
same kernel at compile time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/Kconfig | 11 +++++++++++
 arch/arm/mm/Kconfig              | 28 ++++++++++++++--------------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index ba43321..8c797e77 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -2,6 +2,17 @@ if ARCH_INTEGRATOR
 
 menu "Integrator Options"
 
+choice
+	prompt "CPU architecture level"
+
+config ARCH_INTEGRATOR_V4_V5
+	bool "ARMv4 or ARMv5 CPUs"
+
+config ARCH_INTEGRATOR_V6_V7
+	bool "ARMv6 or ARMv7 CPUs"
+
+endchoice
+
 config ARCH_INTEGRATOR_AP
 	bool "Support Integrator/AP and Integrator/PP2 platforms"
 	select CLKSRC_MMIO
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 8c94496..af76df4 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -21,7 +21,7 @@ config CPU_ARM7TDMI
 
 # ARM720T
 config CPU_ARM720T
-	bool "Support ARM720T processor" if ARCH_INTEGRATOR
+	bool "Support ARM720T processor" if ARCH_INTEGRATOR_V4_V5
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
 	select CPU_CACHE_V4
@@ -39,7 +39,7 @@ config CPU_ARM720T
 
 # ARM740T
 config CPU_ARM740T
-	bool "Support ARM740T processor" if ARCH_INTEGRATOR
+	bool "Support ARM740T processor" if ARCH_INTEGRATOR_V4_V5
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
@@ -71,7 +71,7 @@ config CPU_ARM9TDMI
 
 # ARM920T
 config CPU_ARM920T
-	bool "Support ARM920T processor" if ARCH_INTEGRATOR
+	bool "Support ARM920T processor" if ARCH_INTEGRATOR_V4_V5
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -89,7 +89,7 @@ config CPU_ARM920T
 
 # ARM922T
 config CPU_ARM922T
-	bool "Support ARM922T processor" if ARCH_INTEGRATOR
+	bool "Support ARM922T processor" if ARCH_INTEGRATOR_V4_V5
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -127,7 +127,7 @@ config CPU_ARM925T
 
 # ARM926T
 config CPU_ARM926T
-	bool "Support ARM926T processor" if ARCH_INTEGRATOR
+	bool "Support ARM926T processor" if ARCH_INTEGRATOR_V4_V5
 	select CPU_32v5
 	select CPU_ABRT_EV5TJ
 	select CPU_CACHE_VIVT
@@ -163,7 +163,7 @@ config CPU_FA526
 
 # ARM940T
 config CPU_ARM940T
-	bool "Support ARM940T processor" if ARCH_INTEGRATOR
+	bool "Support ARM940T processor" if ARCH_INTEGRATOR_V4_V5
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_NOMMU
@@ -181,7 +181,7 @@ config CPU_ARM940T
 
 # ARM946E-S
 config CPU_ARM946E
-	bool "Support ARM946E-S processor" if ARCH_INTEGRATOR
+	bool "Support ARM946E-S processor" if ARCH_INTEGRATOR_V4_V5
 	depends on !MMU
 	select CPU_32v5
 	select CPU_ABRT_NOMMU
@@ -198,7 +198,7 @@ config CPU_ARM946E
 
 # ARM1020 - needs validating
 config CPU_ARM1020
-	bool "Support ARM1020T (rev 0) processor" if ARCH_INTEGRATOR
+	bool "Support ARM1020T (rev 0) processor" if ARCH_INTEGRATOR_V4_V5
 	select CPU_32v5
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -216,7 +216,7 @@ config CPU_ARM1020
 
 # ARM1020E - needs validating
 config CPU_ARM1020E
-	bool "Support ARM1020E processor" if ARCH_INTEGRATOR
+	bool "Support ARM1020E processor" if ARCH_INTEGRATOR_V4_V5
 	depends on n
 	select CPU_32v5
 	select CPU_ABRT_EV4T
@@ -229,7 +229,7 @@ config CPU_ARM1020E
 
 # ARM1022E
 config CPU_ARM1022
-	bool "Support ARM1022E processor" if ARCH_INTEGRATOR
+	bool "Support ARM1022E processor" if ARCH_INTEGRATOR_V4_V5
 	select CPU_32v5
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_VIVT
@@ -247,7 +247,7 @@ config CPU_ARM1022
 
 # ARM1026EJ-S
 config CPU_ARM1026
-	bool "Support ARM1026EJ-S processor" if ARCH_INTEGRATOR
+	bool "Support ARM1026EJ-S processor" if ARCH_INTEGRATOR_V4_V5
 	select CPU_32v5
 	select CPU_ABRT_EV5T # But need Jazelle, but EV5TJ ignores bit 10
 	select CPU_CACHE_VIVT
@@ -358,7 +358,7 @@ config CPU_PJ4B
 
 # ARMv6
 config CPU_V6
-	bool "Support ARM V6 processor" if ARCH_INTEGRATOR
+	bool "Support ARM V6 processor" if ARCH_INTEGRATOR_V6_V7
 	select CPU_32v6
 	select CPU_ABRT_EV6
 	select CPU_CACHE_V6
@@ -371,7 +371,7 @@ config CPU_V6
 
 # ARMv6k
 config CPU_V6K
-	bool "Support ARM V6K processor" if ARCH_INTEGRATOR
+	bool "Support ARM V6K processor" if ARCH_INTEGRATOR_V6_V7
 	select CPU_32v6
 	select CPU_32v6K
 	select CPU_ABRT_EV6
@@ -385,7 +385,7 @@ config CPU_V6K
 
 # ARMv7
 config CPU_V7
-	bool "Support ARM V7 processor" if ARCH_INTEGRATOR
+	bool "Support ARM V7 processor" if ARCH_INTEGRATOR_V6_V7
 	select CPU_32v6K
 	select CPU_32v7
 	select CPU_ABRT_EV7
-- 
1.8.3.2
