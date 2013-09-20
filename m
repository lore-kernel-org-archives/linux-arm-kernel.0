From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Sep 2013 10:38:13 -0700
Subject: [PATCH 1/4] ARM: OMAP2+: Always build in board-generic
In-Reply-To: <20130920173310.2584.24522.stgit@localhost>
References: <20130920173310.2584.24522.stgit@localhost>
Message-ID: <20130920173813.2584.73199.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are moving to device tree based booting, so board-generic
should always be built.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b5fb5f7..f6a1db1 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -94,6 +94,7 @@ config ARCH_OMAP2PLUS
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select HAVE_CLK
+	select MACH_OMAP_GENERIC
 	select OMAP_DM_TIMER
 	select PINCTRL
 	select PROC_DEVICETREE if PROC_FS
@@ -187,16 +188,11 @@ config OMAP_PACKAGE_CUS
 config OMAP_PACKAGE_CBP
        bool
 
-comment "OMAP Board Type"
+comment "OMAP Legacy Platform Data Board Type"
 	depends on ARCH_OMAP2PLUS
 
 config MACH_OMAP_GENERIC
-	bool "Generic OMAP2+ board"
-	depends on ARCH_OMAP2PLUS
-	default y
-	help
-	  Support for generic TI OMAP2+ boards using Flattened Device Tree.
-	  More information at Documentation/devicetree
+	bool
 
 config MACH_OMAP2_TUSB6010
 	bool
