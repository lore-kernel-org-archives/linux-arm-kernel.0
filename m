From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed,  7 Jun 2017 08:43:16 +0200
Subject: [PATCH 1/1] ARM: imx: Enable REGMAP_MMIO per default
Message-ID: <20170607064316.2766-1-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If unset, the gpc drivers fails to link with this error:
drivers/built-in.o: In function `imx_gpc_probe':
core.c:(.text+0x1e16c): undefined reference to
 `__devm_regmap_init_mmio_clk'

As the gpc driver is built when ARCH_MXC is set, enable REGMAP_MMIO in
this case too.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 936c59d0e18b..1b8eead0d113 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -7,6 +7,7 @@ menuconfig ARCH_MXC
 	select GPIOLIB
 	select PINCTRL
 	select PM_OPP if PM
+	select REGMAP_MMIO
 	select SOC_BUS
 	select SRAM
 	help
-- 
2.13.0
