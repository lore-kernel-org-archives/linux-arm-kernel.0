From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  9 Mar 2012 10:51:17 +0200
Subject: [PATCH 1/2] ARM: OMAP: Remove CONFIG_OMAP_MCBSP references
In-Reply-To: <1331283078-14846-1-git-send-email-peter.ujfalusi@ti.com>
References: <1331283078-14846-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1331283078-14846-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The McBSP driver stack has been moved to ASoC. The CONFIG_OMAP_MCBSP will
be removed since the CONFIG_SND_OMAP_SOC_MCBSP will trigger to build the
McBSP (audio) drivers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap1/Kconfig  |    3 ---
 arch/arm/mach-omap1/Makefile |    4 +++-
 arch/arm/mach-omap2/Makefile |    4 +++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 4f8d66f..922ab0d 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -37,7 +37,6 @@ comment "OMAP Board Type"
 config MACH_OMAP_INNOVATOR
 	bool "TI Innovator"
 	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX)
-	select OMAP_MCBSP
 	help
           TI OMAP 1510 or 1610 Innovator board support. Say Y here if you
           have such a board.
@@ -45,7 +44,6 @@ config MACH_OMAP_INNOVATOR
 config MACH_OMAP_H2
 	bool "TI H2 Support"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
-	select OMAP_MCBSP
     	help
 	  TI OMAP 1610/1611B H2 board support. Say Y here if you have such
 	  a board.
@@ -72,7 +70,6 @@ config MACH_HERALD
 config MACH_OMAP_OSK
 	bool "TI OSK Support"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
-	select OMAP_MCBSP
     	help
 	  TI OMAP 5912 OSK (OMAP Starter Kit) board support. Say Y here
           if you have such a board.
diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 11c85cd..9923f92 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -6,7 +6,9 @@
 obj-y := io.o id.o sram.o time.o irq.o mux.o flash.o serial.o devices.o dma.o
 obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o timer.o
 
-obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
+ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
+obj-y += mcbsp.o
+endif
 
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bd76394..06326a6 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -17,7 +17,9 @@ obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common) $(secure-common)
 obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common) $(secure-common)
 
-obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
+ifneq ($(CONFIG_SND_OMAP_SOC_MCBSP),)
+obj-y += mcbsp.o
+endif
 
 obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 
-- 
1.7.8.5
