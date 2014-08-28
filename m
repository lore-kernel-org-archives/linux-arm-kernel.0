From: sr@denx.de (Stefan Roese)
Date: Thu, 28 Aug 2014 19:10:26 +0200
Subject: [PATCH 1/4] arm: omap: tao3530: Add pdata-quirk for the mmc2 internal
 clock
Message-ID: <1409245829-3938-1-git-send-email-sr@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
Cc: Tapani Utriainen <tapani@technexion.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 90c88d4..b9d091b 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -253,6 +253,11 @@ static void __init nokia_n900_legacy_init(void)
 
 	}
 }
+
+static void __init omap3_tao3530_legacy_init(void)
+{
+	hsmmc2_internal_input_clk();
+}
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_ARCH_OMAP4
@@ -377,6 +382,7 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
 	{ "ti,omap3-zoom3", omap3_zoom_legacy_init, },
 	{ "ti,am3517-evm", am3517_evm_legacy_init, },
+	{ "technexion,omap3-tao3530", omap3_tao3530_legacy_init, },
 #endif
 #ifdef CONFIG_ARCH_OMAP4
 	{ "ti,omap4-sdp", omap4_sdp_legacy_init, },
-- 
2.1.0
