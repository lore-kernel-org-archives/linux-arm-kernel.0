From: a.j.buxton@gmail.com (Alistair Buxton)
Date: Wed, 14 Oct 2009 20:50:38 +0100
Subject: [PATCH 05/17] OMAP7XX: USB: Remove duplicate omap850 code
Message-ID: <3d374d00910141250m6aa6634fj7b9164d52ae6558c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is part of a series which unifies all duplicated code between
omap730 and omap850. All cpu checks are converted to cpu_is_omap7xx() and
CONFIG_ARCH_OMAP850 is added to all CONFIG_ARCH_OMAP730 checks.

Signed-off-by: Alistair Buxton <a.j.buxton@gmail.com>
Reviewed-by: Zebediah C. McClure <zmc@lurian.net>
---
 arch/arm/plat-omap/usb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/usb.c b/arch/arm/plat-omap/usb.c
index 509f2ed..980d2eb 100644
--- a/arch/arm/plat-omap/usb.c
+++ b/arch/arm/plat-omap/usb.c
@@ -614,7 +614,7 @@ omap_otg_init(struct omap_usb_config *config)
 	if (config->otg || config->register_host) {
 		syscon &= ~HST_IDLE_EN;
 		ohci_device.dev.platform_data = config;
-		if (cpu_is_omap730())
+		if (cpu_is_omap7xx())
 			ohci_resources[1].start = INT_730_USB_HHC_1;
 		status = platform_device_register(&ohci_device);
 		if (status)
@@ -626,7 +626,7 @@ omap_otg_init(struct omap_usb_config *config)
 	if (config->otg) {
 		syscon &= ~OTG_IDLE_EN;
 		otg_device.dev.platform_data = config;
-		if (cpu_is_omap730())
+		if (cpu_is_omap7xx())
 			otg_resources[1].start = INT_730_USB_OTG;
 		status = platform_device_register(&otg_device);
 		if (status)
@@ -731,7 +731,7 @@ static inline void omap_1510_usb_init(struct
omap_usb_config *config) {}

 void __init omap_usb_init(struct omap_usb_config *pdata)
 {
-	if (cpu_is_omap730() || cpu_is_omap16xx() || cpu_is_omap24xx())
+	if (cpu_is_omap7xx() || cpu_is_omap16xx() || cpu_is_omap24xx())
 		omap_otg_init(pdata);
 	else if (cpu_is_omap15xx())
 		omap_1510_usb_init(pdata);
-- 
1.6.5
