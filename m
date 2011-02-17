From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Feb 2011 14:28:52 +0800
Subject: [PATCH 4/4] ARM: mxs/mx28evk: add auart devices
In-Reply-To: <1297924132-17402-1-git-send-email-shawn.guo@freescale.com>
References: <1297924132-17402-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1297924132-17402-5-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx28evk.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 3c5ce09..55bf075 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -29,6 +29,7 @@ config MACH_MX28EVK
 	bool "Support MX28EVK Platform"
 	select SOC_IMX28
 	select MXS_HAVE_AMBA_DUART
+	select MXS_HAVE_PLATFORM_AUART
 	select MXS_HAVE_PLATFORM_FEC
 	select MXS_OCOTP
 	default y
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index e8db99f..1f0b708 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -38,6 +38,25 @@ static const iomux_cfg_t mx28evk_pads[] __initconst = {
 	MX28_PAD_PWM1__DUART_TX |
 		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
 
+	/* auart0 */
+	MX28_PAD_AUART0_RX__AUART0_RX |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_AUART0_TX__AUART0_TX |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_AUART0_CTS__AUART0_CTS |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_AUART0_RTS__AUART0_RTS |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	/* auart3 */
+	MX28_PAD_AUART3_RX__AUART3_RX |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_AUART3_TX__AUART3_TX |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_AUART3_CTS__AUART3_CTS |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_AUART3_RTS__AUART3_RTS |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+
 	/* fec0 */
 	MX28_PAD_ENET0_MDC__ENET0_MDC |
 		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
@@ -164,6 +183,8 @@ static void __init mx28evk_init(void)
 	mxs_iomux_setup_multiple_pads(mx28evk_pads, ARRAY_SIZE(mx28evk_pads));
 
 	mx28_add_duart();
+	mx28_add_auart0();
+	mx28_add_auart3();
 
 	if (mx28evk_fec_get_mac())
 		pr_warn("%s: failed on fec mac setup\n", __func__);
-- 
1.7.1
