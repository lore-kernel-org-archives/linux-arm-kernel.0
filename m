From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 14 Jun 2012 18:17:10 +0530
Subject: [PATCH 21/29] ARM: omap: clk: Switch to COMMON clk
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Message-ID: <1339678038-23082-22-git-send-email-rnayak@ti.com>
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
index 4cf5142..6f716cd 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -18,6 +18,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
 	select TWL4030_POWER if ARCH_OMAP3 || ARCH_OMAP4
 	select HIGHMEM
+	select COMMON_CLK
 	help
 	  Compile a kernel suitable for booting most boards
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fa742f3..d70f2ef 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -137,14 +137,14 @@ obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpllcore.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_virt_prcm_set.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_apll.o clkt2xxx_osc.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clkt2xxx_dpll.o clkt_iclk.o
-obj-$(CONFIG_SOC_OMAP2420)		+= clock2420_data.o
-obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o clock2430_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= cclock2420_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o cclock2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o clkt34xx_dpll3m2.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clock3517.o clock36xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o clock3xxx_data.o
+obj-$(CONFIG_ARCH_OMAP3)		+= dpll3xxx.o cclock3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clkt_iclk.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) cclock44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
-- 
1.7.1
