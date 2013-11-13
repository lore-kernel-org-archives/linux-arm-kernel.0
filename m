From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Wed, 13 Nov 2013 14:59:39 +0100
Subject: [PATCH] ARM: Kconfig: Mention R-Mobile and R-Car in addition to
 SH-Mobile
Message-ID: <1384351179-4593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

External engineers working on R-Car platforms sometimes can't find
upstream platform support as the combination of the SH-Mobile name and
using the product number proved an effective method of concealment. Make
sure to mention R-Mobile and R-Car in the Kconfig comments and help
texts.

Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/Kconfig               |  4 ++--
 arch/arm/mach-shmobile/Kconfig | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6..970e65e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -643,7 +643,7 @@ config ARCH_MSM
 	  (clock and power control, etc).
 
 config ARCH_SHMOBILE
-	bool "Renesas SH-Mobile / R-Mobile"
+	bool "Renesas SH-/R-Mobile and R-Car"
 	select ARM_PATCH_PHYS_VIRT
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
@@ -659,7 +659,7 @@ config ARCH_SHMOBILE
 	select PM_GENERIC_DOMAINS if PM
 	select SPARSE_IRQ
 	help
-	  Support for Renesas's SH-Mobile and R-Mobile ARM platforms.
+	  Support for Renesas's SH-/R-Mobile and R-Car ARM platforms.
 
 config ARCH_RPC
 	bool "RiscPC"
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4bb548f..4cb15b4 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_SHMOBILE_MULTI
-	bool "SH-Mobile Series" if ARCH_MULTI_V7
+	bool "SH-/R-Mobile and R-Car Series" if ARCH_MULTI_V7
 	depends on MMU
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
@@ -15,24 +15,24 @@ config ARCH_SHMOBILE_MULTI
 
 if ARCH_SHMOBILE_MULTI
 
-comment "SH-Mobile System Type"
+comment "SH-/R-Mobile and R-Car System Type"
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
 
-comment "SH-Mobile Board Type"
+comment "SH-/R-Mobile and R-Car Board Type"
 
 config MACH_KZM9D
 	bool "KZM9D board"
 	depends on ARCH_EMEV2
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
-comment "SH-Mobile System Configuration"
+comment "SH-/R-Mobile and R-Car System Configuration"
 endif
 
 if ARCH_SHMOBILE
 
-comment "SH-Mobile System Type"
+comment "SH-/R-Mobile and R-Car System Type"
 
 config ARCH_SH7372
 	bool "SH-Mobile AP4 (SH7372)"
@@ -116,7 +116,7 @@ config ARCH_R7S72100
 	select CPU_V7
 	select SH_CLK_CPG
 
-comment "SH-Mobile Board Type"
+comment "SH-/R-Mobile and R-Car Board Type"
 
 config MACH_APE6EVM
 	bool "APE6EVM board"
@@ -275,7 +275,7 @@ config MACH_KZM9G_REFERENCE
 
 	   This is intended to aid developers
 
-comment "SH-Mobile System Configuration"
+comment "SH-/R-Mobile and R-Car System Configuration"
 
 config CPU_HAS_INTEVT
         bool
@@ -300,9 +300,10 @@ config SHMOBILE_TIMER_HZ
 	  Allows the configuration of the timer frequency. It is customary
 	  to have the timer interrupt run at 1000 Hz or 100 Hz, but in the
 	  case of low timer frequencies other values may be more suitable.
-	  SH-Mobile systems using a 32768 Hz RCLK for clock events may want
-	  to select a HZ value such as 128 that can evenly divide RCLK.
-	  A HZ value that does not divide evenly may cause timer drift.
+	  SH-/R-Mobile and R-Car systems using a 32768 Hz RCLK for clock
+	  events may want to select a HZ value such as 128 that can evenly
+	  divide RCLK. A HZ value that does not divide evenly may cause timer
+	  drift.
 
 config SH_TIMER_CMT
 	bool "CMT timer driver"
-- 
1.8.3.2
