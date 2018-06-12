From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 Jun 2018 15:24:11 -0500
Subject: [PATCH 4/4] ARM: mach-omap2: omap3/am335x: Enable ACR::IBE on
 Cortex-A8 SoCs for CVE-2017-5715
In-Reply-To: <20180612202411.29798-1-nm@ti.com>
References: <20180612202411.29798-1-nm@ti.com>
Message-ID: <20180612202411.29798-5-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CVE-2017-5715 option to set the IBE bit. This enables kernel
workarounds necessary for the said CVE.

With this enabled, Linux reports:
CPU0: Spectre v2: using BPIALL workaround

This workaround may need to be re-applied in OS environment around low
power transition resume states where context of ACR would be lost (off-mode
etc).

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 77820cc8d1e4..f4babc8d2600 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -10,6 +10,7 @@ config OMAP34XX
 	select ARM_ERRATA_454179
 	select ARM_ERRATA_621766
 	select ARM_ERRATA_725233
+	select ARM_CORTEX_A8_CVE_2017_5715
 	select USE_TINY_PRINTF
 	imply NAND_OMAP_GPMC
 	imply SPL_EXT_SUPPORT
@@ -116,6 +117,7 @@ config AM43XX
 config AM33XX
 	bool "AM33XX SoC"
 	select SPECIFY_CONSOLE_INDEX
+	select ARM_CORTEX_A8_CVE_2017_5715
 	imply NAND_OMAP_ELM
 	imply NAND_OMAP_GPMC
 	imply SPL_NAND_AM33XX_BCH
-- 
2.15.1
