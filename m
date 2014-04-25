From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:55:20 +0100
Subject: [PATCH 183/222] ARM: l2c: AM43x: add L2 cache support
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wdeiu-0007Pu-Om@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>
To: linux-arm-kernel at lists.infradead.org

Add support for L2 cache controller (PL310) on AM437x SoC.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/Kconfig | 1 +
 arch/arm/mach-omap2/io.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index cb31d4390d52..0ba482638ebf 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -65,6 +65,7 @@ config SOC_AM43XX
 	select ARCH_HAS_OPP
 	select ARM_GIC
 	select MACH_OMAP_GENERIC
+	select MIGHT_HAVE_CACHE_L2X0
 
 config SOC_DRA7XX
 	bool "TI DRA7XX"
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b28299b5afd5..4e2df49991ad 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -609,6 +609,7 @@ void __init am43xx_init_early(void)
 	am43xx_clockdomains_init();
 	am43xx_hwmod_init();
 	omap_hwmod_init_postsetup();
+	omap_l2_cache_init();
 	omap_clk_soc_init = am43xx_dt_clk_init;
 }
 
-- 
1.8.3.1
