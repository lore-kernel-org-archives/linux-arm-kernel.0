From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Mar 2015 10:39:37 -0800
Subject: ARM: OMAP2+: Fix wl12xx on dm3730-evm with mainline u-boot
Message-ID: <20150306183937.GB13520@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I upgraded my u-boot and noticed that wl12xx stopped working.
Turns out the kernel is not setting the quirk for the MMC2
copy clock while the eariler bootloader I had was setting it.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -173,6 +173,7 @@ static void __init omap3_igep0030_rev_g_legacy_init(void)
 
 static void __init omap3_evm_legacy_init(void)
 {
+	hsmmc2_internal_input_clk();
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 149);
 }
 
