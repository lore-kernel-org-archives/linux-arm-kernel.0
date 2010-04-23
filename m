From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Apr 2010 16:11:58 -0700
Subject: [PATCH 23/28] omap: Devkit8000: Add missing package selection
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Message-ID: <20100423231158.31953.58334.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Weber <weber@corscience.de>

Devkit8000 uses the CUS package for OMAP3530.

This patch adds missing package selection for CUS and enables
CONFIG_MUX.

Replace whitespace with tab in Kconfig.

Signed-off-by: Thomas Weber <weber@corscience.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index a8a3d1e..2455dcc 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -59,8 +59,10 @@ config MACH_OMAP3_BEAGLE
 	select OMAP_PACKAGE_CBB
 
 config MACH_DEVKIT8000
-        bool "DEVKIT8000 board"
-        depends on ARCH_OMAP3
+	bool "DEVKIT8000 board"
+	depends on ARCH_OMAP3
+	select OMAP_PACKAGE_CUS
+	select OMAP_MUX
 
 config MACH_OMAP_LDP
 	bool "OMAP3 LDP board"
