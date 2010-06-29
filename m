From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Jun 2010 14:47:38 +0300
Subject: [PATCH 6/6] omap2/3/4: Add Kconfig option to compile in typical omap
	features
In-Reply-To: <20100629113229.16008.2931.stgit@baageli.muru.com>
References: <20100629113229.16008.2931.stgit@baageli.muru.com>
Message-ID: <20100629114738.16008.62006.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This produces a sane config that's suitable for using as the
base for most omap2/3/4 boards.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4802988..84fecd0 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -2,6 +2,27 @@ if ARCH_OMAP2PLUS
 
 menu "TI OMAP2/3/4 Specific Features"
 
+config ARCH_OMAP2PLUS_TYPICAL
+	bool "Typical OMAP configuration"
+	default y
+	select AEABI
+	select REGULATOR
+	select PM
+	select PM_RUNTIME
+	select VFP
+	select NEON if ARCH_OMAP3 || ARCH_OMAP4
+	select SERIAL_8250
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_8250_CONSOLE
+	select I2C
+	select I2C_OMAP
+	select MFD
+	select MENELAUS if ARCH_OMAP2
+	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
+	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
+	help
+	  Compile a kernel suitable for booting most boards
+
 config ARCH_OMAP2
 	bool "TI OMAP2"
 	depends on ARCH_OMAP2PLUS
