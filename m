From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Jun 2017 17:24:28 +0530
Subject: [PATCH 01/12] ARM: OMAP2+: Select PINCTRL_TI_IODELAY for SOC_DRA7XX
In-Reply-To: <20170616115439.8508-1-kishon@ti.com>
References: <20170616115439.8508-1-kishon@ti.com>
Message-ID: <20170616115439.8508-2-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PINCTRL_TI_IODELAY should be enabled so that "pinctrl_dev" can be created
for pinctrl entries populated with iodelay values in device tree data.
Select PINCTRL_TI_IODELAY for SOC_DRA7XX here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/mach-omap2/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0465338183c7..e31a5a22e171 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -87,6 +87,7 @@ config SOC_DRA7XX
 	select OMAP_INTERCONNECT_BARRIER
 	select PM_OPP if PM
 	select ZONE_DMA if ARM_LPAE
+	select PINCTRL_TI_IODELAY if OF && PINCTRL
 
 config ARCH_OMAP2PLUS
 	bool
-- 
2.11.0
