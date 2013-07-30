From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 14:24:14 +0900
Subject: [PATCH 4/4] ARM: shmobile: Allow ARCH_SHMOBILE_MULTI timer
 configuration
In-Reply-To: <cover.1375161473.git.horms+renesas@verge.net.au>
References: <cover.1375161473.git.horms+renesas@verge.net.au>
Message-ID: <fd071b669ee2405e986636e389a3d1b6776e50a0.1375161473.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move the timer configuration bits to allow use in
case of ARCH_SHMOBILE or ARCH_SHMOBILE_MULTI.

The timers all make use of the regular driver model
so they are safe to enable for ARCH_MULTIPLATFORM.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 8914c9b..cdefd7d 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -32,6 +32,8 @@ config MACH_KZM9D_REFERENCE
 	   of not supporting a number of devices.
 
 	   This is intended to aid developers
+
+comment "SH-Mobile System Configuration"
 endif
 
 if ARCH_SHMOBILE
@@ -234,6 +236,15 @@ config CPU_HAS_INTEVT
         bool
 	default y
 
+config SH_CLK_CPG
+	bool
+
+source "drivers/sh/Kconfig"
+
+endif
+
+if ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI
+
 menu "Timer and clock configuration"
 
 config SHMOBILE_TIMER_HZ
@@ -268,9 +279,4 @@ config EM_TIMER_STI
 
 endmenu
 
-config SH_CLK_CPG
-	bool
-
-source "drivers/sh/Kconfig"
-
 endif
-- 
1.8.3.2
