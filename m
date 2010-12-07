From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 7 Dec 2010 17:14:45 -0200
Subject: [PATCH 2/2] ARM: imx/mx27_3ds: Add watchdog support
In-Reply-To: <1291749285-11406-1-git-send-email-fabio.estevam@freescale.com>
References: <1291749285-11406-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1291749285-11406-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig         |    1 +
 arch/arm/mach-imx/mach-mx27_3ds.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8a9de17..fed3ee5 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -235,6 +235,7 @@ endchoice
 config MACH_MX27_3DS
 	bool "MX27PDK platform"
 	select SOC_IMX27
+	select IMX_HAVE_PLATFORM_IMX2_WDT
 	select IMX_HAVE_PLATFORM_IMX_KEYPAD
 	select IMX_HAVE_PLATFORM_IMX_UART
 	select IMX_HAVE_PLATFORM_MXC_MMC
diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach-mx27_3ds.c
index 3614e33..1a7e879 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -127,6 +127,7 @@ static void __init mx27pdk_init(void)
 	imx27_add_fec(NULL);
 	imx27_add_imx_keypad(&mx27_3ds_keymap_data);
 	imx27_add_mxc_mmc(0, &sdhc1_pdata);
+	imx27_add_imx2_wdt(NULL);
 }
 
 static void __init mx27pdk_timer_init(void)
-- 
1.6.0.4
