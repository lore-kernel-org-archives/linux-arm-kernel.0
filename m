From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 12 May 2014 20:32:03 +0200
Subject: [PATCH v3 4/4] ARM: OMAP2+: Use pdata quirks for wl12xx on
 VAR-STK/DVK-OM44
In-Reply-To: <1399919523-20330-1-git-send-email-manabian@gmail.com>
References: <1399919523-20330-1-git-send-email-manabian@gmail.com>
Message-ID: <1399919523-20330-5-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index c3b73351cb7a..ab94f3a87c32 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -254,6 +254,11 @@ static void __init omap4_panda_legacy_init(void)
 {
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 53);
 }
+
+static void __init var_som_om44_legacy_init(void)
+{
+	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 41);
+}
 #endif
 
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
@@ -364,6 +369,8 @@ static struct pdata_init pdata_quirks[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP4
 	{ "ti,omap4-sdp", omap4_sdp_legacy_init, },
 	{ "ti,omap4-panda", omap4_panda_legacy_init, },
+	{ "variscite,var-dvk-om44", var_som_om44_legacy_init, },
+	{ "variscite,var-stk-om44", var_som_om44_legacy_init, },
 #endif
 #ifdef CONFIG_SOC_AM33XX
 	{ "ti,am335x-evmsk", am335x_evmsk_legacy_init, },
-- 
1.8.0
