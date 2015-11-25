From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:32:21 +0100
Subject: [PATCH 08/10] ARM: no longer make CPU targets visible separately
In-Reply-To: <1448469143-447355-1-git-send-email-arnd@arndb.de>
References: <1448469143-447355-1-git-send-email-arnd@arndb.de>
Message-ID: <1448469143-447355-9-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that realview and integrator always select the correct CPU
type themselves based on the core tiles, there is no need to
still have them user-visible in arch/arm/mm/Kconfig. The
ARM925T symbol has been selected by the only user for many
years, so that can be removed along with the realview and
integrator specific ones.

This also solves randconfig build problems on realview.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mm/Kconfig | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 76f65f2d59b1..549f6d3aec5b 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -21,7 +21,7 @@ config CPU_ARM7TDMI
 
 # ARM720T
 config CPU_ARM720T
-	bool "Support ARM720T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
+	bool
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
 	select CPU_CACHE_V4
@@ -39,7 +39,7 @@ config CPU_ARM720T
 
 # ARM740T
 config CPU_ARM740T
-	bool "Support ARM740T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
+	bool
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
@@ -71,7 +71,7 @@ config CPU_ARM9TDMI
 
 # ARM920T
 config CPU_ARM920T
-	bool "Support ARM920T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
+	bool
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -89,7 +89,7 @@ config CPU_ARM920T
 
 # ARM922T
 config CPU_ARM922T
-	bool "Support ARM922T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
+	bool
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -108,7 +108,7 @@ config CPU_ARM922T
 
 # ARM925T
 config CPU_ARM925T
- 	bool "Support ARM925T processor" if ARCH_OMAP1
+	bool
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -127,7 +127,7 @@ config CPU_ARM925T
 
 # ARM926T
 config CPU_ARM926T
-	bool "Support ARM926T processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V5) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB)
+	bool
 	select CPU_32v5
 	select CPU_ABRT_EV5TJ
 	select CPU_CACHE_VIVT
@@ -163,7 +163,7 @@ config CPU_FA526
 
 # ARM940T
 config CPU_ARM940T
-	bool "Support ARM940T processor" if (ARCH_MULTI_V4T && ARCH_INTEGRATOR)
+	bool
 	depends on !MMU
 	select CPU_32v4T
 	select CPU_ABRT_NOMMU
@@ -181,7 +181,7 @@ config CPU_ARM940T
 
 # ARM946E-S
 config CPU_ARM946E
-	bool "Support ARM946E-S processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
+	bool
 	depends on !MMU
 	select CPU_32v5
 	select CPU_ABRT_NOMMU
@@ -198,7 +198,7 @@ config CPU_ARM946E
 
 # ARM1020 - needs validating
 config CPU_ARM1020
-	bool "Support ARM1020T (rev 0) processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
+	bool
 	select CPU_32v5
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -216,7 +216,7 @@ config CPU_ARM1020
 
 # ARM1020E - needs validating
 config CPU_ARM1020E
-	bool "Support ARM1020E processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
+	bool
 	depends on n
 	select CPU_32v5
 	select CPU_ABRT_EV4T
@@ -229,7 +229,7 @@ config CPU_ARM1020E
 
 # ARM1022E
 config CPU_ARM1022
-	bool "Support ARM1022E processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
+	bool
 	select CPU_32v5
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_VIVT
@@ -247,7 +247,7 @@ config CPU_ARM1022
 
 # ARM1026EJ-S
 config CPU_ARM1026
-	bool "Support ARM1026EJ-S processor" if (ARCH_MULTI_V5 && ARCH_INTEGRATOR)
+	bool
 	select CPU_32v5
 	select CPU_ABRT_EV5T # But need Jazelle, but EV5TJ ignores bit 10
 	select CPU_CACHE_VIVT
@@ -358,7 +358,7 @@ config CPU_PJ4B
 
 # ARMv6
 config CPU_V6
-	bool "Support ARM V6 processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V6) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
+	bool
 	select CPU_32v6
 	select CPU_ABRT_EV6
 	select CPU_CACHE_V6
@@ -371,7 +371,7 @@ config CPU_V6
 
 # ARMv6k
 config CPU_V6K
-	bool "Support ARM V6K processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V6) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
+	bool
 	select CPU_32v6
 	select CPU_32v6K
 	select CPU_ABRT_EV6
@@ -385,7 +385,7 @@ config CPU_V6K
 
 # ARMv7
 config CPU_V7
-	bool "Support ARM V7 processor" if (!ARCH_MULTIPLATFORM || ARCH_MULTI_V7) && (ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX)
+	bool
 	select CPU_32v6K
 	select CPU_32v7
 	select CPU_ABRT_EV7
-- 
2.1.0.rc2
