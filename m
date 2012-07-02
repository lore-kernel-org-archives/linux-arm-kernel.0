From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon,  2 Jul 2012 13:33:27 +0200
Subject: [PATCH 7/9] arm: mach-mvebu: add compilation/configuration change
In-Reply-To: <1341228809-17824-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1341228809-17824-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1341228809-17824-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Lior Amsalem <alior@marvell.com>
---
 arch/arm/Kconfig  |   14 ++++++++++++++
 arch/arm/Makefile |    1 +
 2 files changed, 15 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8e02882..519b5e0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -533,6 +533,18 @@ config ARCH_IXP4XX
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
 
+config ARCH_MVEBU
+	bool "Marvell SOCs with Device Tree support"
+	select GENERIC_CLOCKEVENTS
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
+	select CLKSRC_MMIO
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	select COMMON_CLK
+	help
+	  Support for the Marvell SoC Family with device tree support
+
 config ARCH_DOVE
 	bool "Marvell Dove"
 	select CPU_V7
@@ -987,6 +999,8 @@ endchoice
 # Kconfigs may be included either alphabetically (according to the
 # plat- suffix) or along side the corresponding mach-* source.
 #
+source "arch/arm/mach-mvebu/Kconfig"
+
 source "arch/arm/mach-at91/Kconfig"
 
 source "arch/arm/mach-bcmring/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 0298b00..f1a1a71 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -157,6 +157,7 @@ machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
 machine-$(CONFIG_ARCH_IMX_V4_V5)	:= imx
 machine-$(CONFIG_ARCH_IMX_V6_V7)	:= imx
 machine-$(CONFIG_ARCH_MXS)		:= mxs
+machine-$(CONFIG_ARCH_MVEBU)		:= mvebu
 machine-$(CONFIG_ARCH_NETX)		:= netx
 machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
 machine-$(CONFIG_ARCH_OMAP1)		:= omap1
-- 
1.7.9.5
