From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 1 Jun 2012 17:37:57 +0530
Subject: [RFC 16/24] ARM: omap: clk: Switch to COMMON clk
In-Reply-To: <1338552485-31325-1-git-send-email-rnayak@ti.com>
References: <1338552485-31325-1-git-send-email-rnayak@ti.com>
Message-ID: <1338552485-31325-17-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select COMMON_CLK for ARCH_OMAP2 and switch
over to using new data files for OMAP2/3/4.

The older data files which get removed in subsequent
patches.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Kconfig  |    1 +
 arch/arm/mach-omap2/Makefile |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 8141b76..b5b7b76 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -17,6 +17,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select MENELAUS if ARCH_OMAP2
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
+	select COMMON_CLK
 	help
 	  Compile a kernel suitable for booting most boards
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 49f92bc..785b861 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -138,14 +138,14 @@ obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o \
 					   clkt2xxx_virt_prcm_set.o \
 					   clkt2xxx_apll.o clkt2xxx_osc.o \
 					   clkt2xxx_dpll.o clkt_iclk.o
-obj-$(CONFIG_SOC_OMAP2420)		+= clock2420_data.o
-obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o clock2430_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= cclock2420_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o cclock2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o \
 					   clock34xx.o clkt34xx_dpll3m2.o \
 					   clock3517.o clock36xx.o \
-					   dpll3xxx.o clock3xxx_data.o \
+					   dpll3xxx.o cclock3xxx_data.o \
 					   clkt_iclk.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o \
+obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) cclock44xx_data.o \
 					   dpll3xxx.o dpll44xx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
-- 
1.7.1
