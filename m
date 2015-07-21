From: notasas@gmail.com (Grazvydas Ignotas)
Date: Tue, 21 Jul 2015 04:12:00 +0300
Subject: [PATCH 3/4] ARM: OMAP2+: omap3-pandora: add backlight support
In-Reply-To: <1437441121-31658-1-git-send-email-notasas@gmail.com>
References: <1437441121-31658-1-git-send-email-notasas@gmail.com>
Message-ID: <1437441121-31658-3-git-send-email-notasas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add backlight support via pdata-quirks as it's driver lacks DT support.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 821171c..3c97aa49 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -268,6 +268,16 @@ static void __init omap3_tao3530_legacy_init(void)
 {
 	hsmmc2_internal_input_clk();
 }
+
+static struct platform_device pandora_backlight = {
+	.name	= "pandora-backlight",
+	.id	= -1,
+};
+
+static void __init omap3_pandora_legacy_init(void)
+{
+	platform_device_register(&pandora_backlight);
+}
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
@@ -381,6 +391,8 @@ static struct pdata_init pdata_quirks[] __initdata = {
 	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
 	{ "ti,am3517-evm", am3517_evm_legacy_init, },
 	{ "technexion,omap3-tao3530", omap3_tao3530_legacy_init, },
+	{ "openpandora,omap3-pandora-600mhz", omap3_pandora_legacy_init, },
+	{ "openpandora,omap3-pandora-1ghz", omap3_pandora_legacy_init, },
 #endif
 #ifdef CONFIG_SOC_OMAP5
 	{ "ti,omap5-uevm", omap5_uevm_legacy_init, },
-- 
1.9.1
