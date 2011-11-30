From: anders@chargestorm.se (Anders Darander)
Date: Wed, 30 Nov 2011 08:47:44 +0100
Subject: [PATCH] ARM: at91: Fix USB gadget registration
Message-ID: <1322639264-24333-1-git-send-email-anders@chargestorm.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 193ab2a6070039e7ee2b9b9bebea754a7c52fd1b, various AT91 boards don't
register at91_udc anymore due to depending on a now non-existing symbol.
Fix the symbol name.

Signed-off-by: Anders Darander <anders@chargestorm.se>
---

Patched based on 3.2-rc3, but should apply to older and newer trees as well.

Verified on a custom, at91sam9g20 based board.

---
 arch/arm/mach-at91/at91rm9200_devices.c  |    2 +-
 arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9261_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 66591fa..ad93068 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -83,7 +83,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_GADGET_AT91
+#ifdef CONFIG_USB_AT91
 static struct at91_udc_data udc_data;
 
 static struct resource udc_resources[] = {
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 25e3464..629fa97 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -84,7 +84,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_GADGET_AT91
+#ifdef CONFIG_USB_AT91
 static struct at91_udc_data udc_data;
 
 static struct resource udc_resources[] = {
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index ae78f4d..a178b58 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -87,7 +87,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_GADGET_AT91
+#ifdef CONFIG_USB_AT91
 static struct at91_udc_data udc_data;
 
 static struct resource udc_resources[] = {
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index ad017eb..d5fbac9 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -92,7 +92,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_GADGET_AT91
+#ifdef CONFIG_USB_AT91
 static struct at91_udc_data udc_data;
 
 static struct resource udc_resources[] = {
-- 
1.7.7.3
