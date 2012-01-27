From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 27 Jan 2012 11:28:07 +0100
Subject: [PATCH] ARM: at91: USB AT91 gadget registration for module
Message-ID: <1327660087-20864-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Registration of at91_udc as a module will enable SoC
related code.

Fix following an idea from Karel Znamenacek.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable <stable@vger.kernel.org>
---
Karel,

Do you want to add your "Acked-by" line?

 arch/arm/mach-at91/at91rm9200_devices.c  |    2 +-
 arch/arm/mach-at91/at91sam9260_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9261_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 18bacec..97676bd 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -83,7 +83,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_AT91
+#if defined(CONFIG_USB_AT91) || defined(CONFIG_USB_AT91_MODULE)
 static struct at91_udc_data udc_data;
 
 static struct resource udc_resources[] = {
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 642ccb6..f1a1bb45 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -84,7 +84,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_AT91
+#if defined(CONFIG_USB_AT91) || defined(CONFIG_USB_AT91_MODULE)
 static struct at91_udc_data udc_data;
 
 static struct resource udc_resources[] = {
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index fc59cbd..1e28bed 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -87,7 +87,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_AT91
+#if defined(CONFIG_USB_AT91) || defined(CONFIG_USB_AT91_MODULE)
 static struct at91_udc_data udc_data;
 
 static struct resource udc_resources[] = {
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 7b46b27..618013d 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -92,7 +92,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
  *  USB Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#ifdef CONFIG_USB_AT91
+#if defined(CONFIG_USB_AT91) || defined(CONFIG_USB_AT91_MODULE)
 static struct at91_udc_data udc_data;
 
 static struct resource udc_resources[] = {
-- 
1.7.5.4
