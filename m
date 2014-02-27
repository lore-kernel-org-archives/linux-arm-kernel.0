From: tony@atomide.com (Tony Lindgren)
Date: Thu, 27 Feb 2014 13:49:21 -0800
Subject: [PATCH] ARM: OMAP3: Fix pinctrl interrupts for core2
Message-ID: <20140227214921.GO11654@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After splitting padconf core into two parts to avoid exposing
unaccessable registers, the new padconf core2 domain was left
without a wake-up interrupt.

Fix the issue by passing the shared wake-up interrupt in
platform data like we do for padconf core and wkup domains
already.

Fixes: 3d49538364 (ARM: dts: Split omap3 pinmux core device)

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -239,6 +239,7 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 #endif
 #ifdef CONFIG_ARCH_OMAP3
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002030, "48002030.pinmux", &pcs_pdata),
+	OF_DEV_AUXDATA("ti,omap3-padconf", 0x480025a0, "480025a0.pinmux", &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap3-padconf", 0x48002a00, "48002a00.pinmux", &pcs_pdata),
 	/* Only on am3517 */
 	OF_DEV_AUXDATA("ti,davinci_mdio", 0x5c030000, "davinci_mdio.0", NULL),
