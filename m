From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 11:07:19 +0900
Subject: [PATCH 23/26] ARM: Kconfig: Mention Renesas ARM SoCs instead of
 SH-Mobile
In-Reply-To: <cover.1387763524.git.horms+renesas@verge.net.au>
References: <cover.1387763524.git.horms+renesas@verge.net.au>
Message-ID: <0d9fd6165a01093ac82c1088d0544a304f72b4d6.1387763524.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Only the SH-Mobile product name is mentioned in the Kconfig descriptions
and help texts. This makes it difficult for external engineers working
on other Renesas platforms to find upstream platform support as the
combination of the SH-Mobile name and using the product number proved an
effective method of concealment.

Replace the "SH-Mobile" name with "Renesas ARM SoCs" in all the related
descriptions, help texts and comments.

Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig               |  7 ++++---
 arch/arm/mach-shmobile/Kconfig | 18 +++++++++---------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 483d316..341b67d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -645,7 +645,7 @@ config ARCH_MSM
 	  (clock and power control, etc).
 
 config ARCH_SHMOBILE_LEGACY
-	bool "Renesas SH-Mobile / R-Mobile (non-multiplatform)"
+	bool "Renesas ARM SoCs (non-multiplatform)"
 	select ARCH_SHMOBILE
 	select ARM_PATCH_PHYS_VIRT
 	select CLKDEV_LOOKUP
@@ -661,8 +661,9 @@ config ARCH_SHMOBILE_LEGACY
 	select PM_GENERIC_DOMAINS if PM
 	select SPARSE_IRQ
 	help
-	  Support for Renesas's SH-Mobile and R-Mobile ARM platforms using
-	  a non-multiplatform kernel.
+	  Support for Renesas ARM SoC platforms using a non-multiplatform
+	  kernel. This includes the SH-Mobile, R-Mobile, EMMA-Mobile, R-Car
+	  and RZ families.
 
 config ARCH_RPC
 	bool "RiscPC"
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index bb0837b..3e57d45 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -2,7 +2,7 @@ config ARCH_SHMOBILE
 	bool
 
 config ARCH_SHMOBILE_MULTI
-	bool "SH-Mobile Series" if ARCH_MULTI_V7
+	bool "Renesas ARM SoCs" if ARCH_MULTI_V7
 	depends on MMU
 	select ARCH_SHMOBILE
 	select CPU_V7
@@ -19,7 +19,7 @@ config ARCH_SHMOBILE_MULTI
 
 if ARCH_SHMOBILE_MULTI
 
-comment "SH-Mobile System Type"
+comment "Renesas ARM SoCs System Type"
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
@@ -31,7 +31,7 @@ config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
 	select RENESAS_IRQC
 
-comment "SH-Mobile Board Type"
+comment "Renesas ARM SoCs Board Type"
 
 config MACH_GENMAI
 	bool "Genmai board"
@@ -46,12 +46,12 @@ config MACH_KZM9D
 	depends on ARCH_EMEV2
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
-comment "SH-Mobile System Configuration"
+comment "Renesas ARM SoCs System Configuration"
 endif
 
 if ARCH_SHMOBILE_LEGACY
 
-comment "SH-Mobile System Type"
+comment "Renesas ARM SoCs System Type"
 
 config ARCH_SH7372
 	bool "SH-Mobile AP4 (SH7372)"
@@ -137,7 +137,7 @@ config ARCH_R7S72100
 	select CPU_V7
 	select SH_CLK_CPG
 
-comment "SH-Mobile Board Type"
+comment "Renesas ARM SoCs Board Type"
 
 config MACH_APE6EVM
 	bool "APE6EVM board"
@@ -301,7 +301,7 @@ config MACH_KZM9G_REFERENCE
 
 	   This is intended to aid developers
 
-comment "SH-Mobile System Configuration"
+comment "Renesas ARM SoCs System Configuration"
 
 config CPU_HAS_INTEVT
         bool
@@ -326,8 +326,8 @@ config SHMOBILE_TIMER_HZ
 	  Allows the configuration of the timer frequency. It is customary
 	  to have the timer interrupt run at 1000 Hz or 100 Hz, but in the
 	  case of low timer frequencies other values may be more suitable.
-	  SH-Mobile systems using a 32768 Hz RCLK for clock events may want
-	  to select a HZ value such as 128 that can evenly divide RCLK.
+	  Renesas ARM SoC systems using a 32768 Hz RCLK for clock events may
+	  want to select a HZ value such as 128 that can evenly divide RCLK.
 	  A HZ value that does not divide evenly may cause timer drift.
 
 config SH_TIMER_CMT
-- 
1.8.4
