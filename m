From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Feb 2011 14:28:51 +0800
Subject: [PATCH 3/4] ARM: mxs/mx23evk: add auart device
In-Reply-To: <1297924132-17402-1-git-send-email-shawn.guo@freescale.com>
References: <1297924132-17402-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1297924132-17402-4-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/Kconfig        |    1 +
 arch/arm/mach-mxs/mach-mx23evk.c |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index cd2fbdf..3c5ce09 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -19,6 +19,7 @@ config MACH_MX23EVK
 	bool "Support MX23EVK Platform"
 	select SOC_IMX23
 	select MXS_HAVE_AMBA_DUART
+	select MXS_HAVE_PLATFORM_AUART
 	default y
 	help
 	  Include support for MX23EVK platform. This includes specific
diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index aa06400..0737ce2 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -30,6 +30,16 @@ static const iomux_cfg_t mx23evk_pads[] __initconst = {
 	/* duart */
 	MX23_PAD_PWM0__DUART_RX | MXS_PAD_4MA,
 	MX23_PAD_PWM1__DUART_TX | MXS_PAD_4MA,
+
+	/* auart */
+	MX23_PAD_AUART1_RX__AUART1_RX |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_AUART1_TX__AUART1_TX |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_AUART1_CTS__AUART1_CTS |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_AUART1_RTS__AUART1_RTS |
+		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
 };
 
 static void __init mx23evk_init(void)
@@ -37,6 +47,7 @@ static void __init mx23evk_init(void)
 	mxs_iomux_setup_multiple_pads(mx23evk_pads, ARRAY_SIZE(mx23evk_pads));
 
 	mx23_add_duart();
+	mx23_add_auart0();
 }
 
 static void __init mx23evk_timer_init(void)
-- 
1.7.1
