From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 13 Aug 2010 12:21:31 +0200
Subject: [PATCH] ARM: imx: fix build failure concerning otg/ulpi
In-Reply-To: <1275464450-23003-2-git-send-email-grinberg@compulab.co.il>
References: <1275464450-23003-2-git-send-email-grinberg@compulab.co.il>
Message-ID: <1281694891-7527-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The build failure was introduced by

	13dd0c9 (USB: otg/ulpi: extend the generic ulpi driver.)

Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/arm/mach-imx/mach-cpuimx27.c  |    4 ++--
 arch/arm/mach-imx/mach-pca100.c    |    4 ++--
 arch/arm/mach-mx25/mach-cpuimx25.c |    2 +-
 arch/arm/mach-mx3/mach-cpuimx35.c  |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/mach-cpuimx27.c b/arch/arm/mach-imx/mach-cpuimx27.c
index 575ff1a..339150a 100644
--- a/arch/arm/mach-imx/mach-cpuimx27.c
+++ b/arch/arm/mach-imx/mach-cpuimx27.c
@@ -279,13 +279,13 @@ static void __init eukrea_cpuimx27_init(void)
 #if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 		mxc_register_device(&mxc_otg_host, &otg_pdata);
 	}
 
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 #endif
diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index a389d11..23c9e1f 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -419,13 +419,13 @@ static void __init pca100_init(void)
 #if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 		mxc_register_device(&mxc_otg_host, &otg_pdata);
 	}
 
 	usbh2_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				ULPI_OTG_DRVVBUS | ULPI_OTG_DRVVBUS_EXT);
 
 	mxc_register_device(&mxc_usbh2, &usbh2_pdata);
 #endif
diff --git a/arch/arm/mach-mx25/mach-cpuimx25.c b/arch/arm/mach-mx25/mach-cpuimx25.c
index 56b2e26..0134fb8 100644
--- a/arch/arm/mach-mx25/mach-cpuimx25.c
+++ b/arch/arm/mach-mx25/mach-cpuimx25.c
@@ -138,7 +138,7 @@ static void __init eukrea_cpuimx25_init(void)
 #if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				USB_OTG_DRV_VBUS | ULPI_OTG_DRVVBUS_EXT);
 
 		mxc_register_device(&mxc_otg, &otg_pdata);
 	}
diff --git a/arch/arm/mach-mx3/mach-cpuimx35.c b/arch/arm/mach-mx3/mach-cpuimx35.c
index 63f970f..117f90e 100644
--- a/arch/arm/mach-mx3/mach-cpuimx35.c
+++ b/arch/arm/mach-mx3/mach-cpuimx35.c
@@ -192,7 +192,7 @@ static void __init mxc_board_init(void)
 #if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
-				USB_OTG_DRV_VBUS | USB_OTG_DRV_VBUS_EXT);
+				USB_OTG_DRV_VBUS | ULPI_OTG_DRVVBUS_EXT);
 
 		mxc_register_device(&mxc_otg_host, &otg_pdata);
 	}
-- 
1.7.1
