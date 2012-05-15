From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 10:54:40 +0200
Subject: [PATCH 4/8] arm: mach-armada: add compilation/configuration changes
In-Reply-To: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1337072084-21967-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/Kconfig  |   12 ++++++++++++
 arch/arm/Makefile |    1 +
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d595bd3..8c8987b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -545,6 +545,16 @@ config ARCH_IXP4XX
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
 
+config ARCH_ARMADA
+	bool "Marvell Armada"
+	select CPU_V7
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_CLOCKEVENTS
+	select PLAT_ORION
+	select MULTI_IRQ_HANDLER
+	help
+	  Support for the Marvell Armada SoC Family
+
 config ARCH_DOVE
 	bool "Marvell Dove"
 	select CPU_V7
@@ -999,6 +1009,8 @@ endchoice
 # Kconfigs may be included either alphabetically (according to the
 # plat- suffix) or along side the corresponding mach-* source.
 #
+source "arch/arm/mach-armada/Kconfig"
+
 source "arch/arm/mach-at91/Kconfig"
 
 source "arch/arm/mach-bcmring/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 8c4dac4..eaf84fa 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -195,6 +195,7 @@ machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
 machine-$(CONFIG_MACH_SPEAR600)		:= spear6xx
 machine-$(CONFIG_ARCH_ZYNQ)		:= zynq
+machine-$(CONFIG_ARCH_ARMADA)		:= armada
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
-- 
1.7.9.5
