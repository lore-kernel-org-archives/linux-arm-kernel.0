From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 3 Nov 2017 16:26:40 +0200
Subject: [PATCH 6/7] ARM: OMAP2+: hwmod: calculate physical register address
 on am33xx
In-Reply-To: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
References: <1509719201-32700-1-git-send-email-t-kristo@ti.com>
Message-ID: <1509719201-32700-7-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the address translation logic for am33xx. Needed for
mapping hwmods towards their corresponding clkctrl providers and clocks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index bb7c745..ca5ca76 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3840,6 +3840,7 @@ void __init omap_hwmod_init(void)
 		soc_ops.is_hardreset_asserted = _omap4_is_hardreset_asserted;
 		soc_ops.init_clkdm = _init_clkdm;
 		soc_ops.disable_direct_prcm = _omap4_disable_direct_prcm;
+		soc_ops.xlate_clkctrl = _omap4_xlate_clkctrl;
 	} else {
 		WARN(1, "omap_hwmod: unknown SoC type\n");
 	}
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
