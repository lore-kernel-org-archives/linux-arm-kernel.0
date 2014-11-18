From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Tue, 18 Nov 2014 11:13:18 +0200
Subject: [PATCH 3/9] ARM: OMAP2+: remove cm-t3x touchscreen pdata quirk
In-Reply-To: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
References: <1416302004-22199-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1416302004-22199-4-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove ADS7846 touchscreen pdata quirk for CM-T3x CoMs

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/mach-omap2/pdata-quirks.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index e72f0fc..02080c0 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -131,13 +131,11 @@ static void __init omap3_sbc_t3730_legacy_init(void)
 {
 	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 136);
-	omap_ads7846_init(1, 57, 0, NULL);
 }
 
 static void __init omap3_sbc_t3530_legacy_init(void)
 {
 	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
-	omap_ads7846_init(1, 57, 0, NULL);
 }
 
 struct ti_st_plat_data wilink_pdata = {
@@ -249,7 +247,6 @@ static void __init omap3_sbc_t3517_legacy_init(void)
 	hsmmc2_internal_input_clk();
 	omap3_sbc_t3517_wifi_init();
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 145);
-	omap_ads7846_init(1, 57, 0, NULL);
 }
 
 static void __init am3517_evm_legacy_init(void)
-- 
1.7.5.4
