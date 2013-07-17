From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 18 Jul 2013 05:31:27 +0900
Subject: [PATCH 04/04] ARM: shmobile: Allow ARCH_SHMOBILE_MULTI timer
 configuration
In-Reply-To: <20130717203049.27542.78385.sendpatchset@w520>
References: <20130717203049.27542.78385.sendpatchset@w520>
Message-ID: <20130717203127.27542.41663.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Move the timer configuration bits to allow use in
case of ARCH_SHMOBILE or ARCH_SHMOBILE_MULTI.

The timers all make use of the regular driver model
so they are safe to enable for ARCH_MULTIPLATFORM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Kconfig |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- 0005/arch/arm/mach-shmobile/Kconfig
+++ work/arch/arm/mach-shmobile/Kconfig	2013-07-09 12:07:23.000000000 +0900
@@ -30,6 +30,8 @@ config MACH_KZM9D_REFERENCE
 	   of not supporting a number of devices.
 
 	   This is intended to aid developers
+
+comment "SH-Mobile System Configuration"
 endif
 
 if ARCH_SHMOBILE
@@ -243,6 +245,15 @@ config CPU_HAS_INTEVT
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
@@ -277,9 +288,4 @@ config EM_TIMER_STI
 
 endmenu
 
-config SH_CLK_CPG
-	bool
-
-source "drivers/sh/Kconfig"
-
 endif
