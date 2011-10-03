From: jochen@scram.de (Jochen Friedrich)
Date: Mon,  3 Oct 2011 20:56:21 +0200
Subject: [PATCH] ARM: at91: Fix USBA gadget registration
Message-ID: <1317668182-15673-1-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 193ab2a6070039e7ee2b9b9bebea754a7c52fd1b, various AT91 boards don't
register USBA adapters anymore due to depending on a now non-existing
symbol. Fix the symbol name.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 arch/arm/mach-at91/at91cap9_devices.c    |    2 +-
 arch/arm/mach-at91/at91sam9g45_devices.c |    2 +-
 arch/arm/mach-at91/at91sam9rl_devices.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
index dba0d8d..0512baf 100644
--- a/arch/arm/mach-at91/at91cap9_devices.c
+++ b/arch/arm/mach-at91/at91cap9_devices.c
@@ -92,7 +92,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data) {}
  *  USB HS Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_GADGET_ATMEL_USBA) || defined(CONFIG_USB_GADGET_ATMEL_USBA_MODULE)
+#if defined(CONFIG_USB_ATMEL_USBA) || defined(CONFIG_USB_ATMEL_USBA_MODULE)
 
 static struct resource usba_udc_resources[] = {
 	[0] = {
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 600bffb..371bb0e 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -191,7 +191,7 @@ void __init at91_add_device_usbh_ehci(struct at91_usbh_data *data) {}
  *  USB HS Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_GADGET_ATMEL_USBA) || defined(CONFIG_USB_GADGET_ATMEL_USBA_MODULE)
+#if defined(CONFIG_USB_ATMEL_USBA) || defined(CONFIG_USB_ATMEL_USBA_MODULE)
 static struct resource usba_udc_resources[] = {
 	[0] = {
 		.start	= AT91SAM9G45_UDPHS_FIFO,
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index aacb19d..c884d59 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -75,7 +75,7 @@ void __init at91_add_device_hdmac(void) {}
  *  USB HS Device (Gadget)
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_USB_GADGET_ATMEL_USBA) || defined(CONFIG_USB_GADGET_ATMEL_USBA_MODULE)
+#if defined(CONFIG_USB_ATMEL_USBA) || defined(CONFIG_USB_ATMEL_USBA_MODULE)
 
 static struct resource usba_udc_resources[] = {
 	[0] = {
-- 
1.7.7.rc1
