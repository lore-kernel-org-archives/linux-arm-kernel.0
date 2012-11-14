From: jhovold@gmail.com (Johan Hovold)
Date: Wed, 14 Nov 2012 12:18:17 +0100
Subject: [PATCH] ARM: at91/usbh: fix overcurrent gpio setup
Message-ID: <1352891897-18708-1-git-send-email-jhovold@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use gpio_is_valid also for overcurrent pins (which are currently
negative in many board files).

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 arch/arm/mach-at91/at91rm9200_devices.c  | 2 +-
 arch/arm/mach-at91/at91sam9260_devices.c | 2 +-
 arch/arm/mach-at91/at91sam9261_devices.c | 2 +-
 arch/arm/mach-at91/at91sam9263_devices.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/at91rm9200_devices.c b/arch/arm/mach-at91/at91rm9200_devices.c
index 1e122bc..3cee0e6 100644
--- a/arch/arm/mach-at91/at91rm9200_devices.c
+++ b/arch/arm/mach-at91/at91rm9200_devices.c
@@ -68,7 +68,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
 
 	/* Enable overcurrent notification */
 	for (i = 0; i < data->ports; i++) {
-		if (data->overcurrent_pin[i])
+		if (gpio_is_valid(data->overcurrent_pin[i]))
 			at91_set_gpio_input(data->overcurrent_pin[i], 1);
 	}
 
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index aa1e587..414bd85 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -72,7 +72,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
 
 	/* Enable overcurrent notification */
 	for (i = 0; i < data->ports; i++) {
-		if (data->overcurrent_pin[i])
+		if (gpio_is_valid(data->overcurrent_pin[i]))
 			at91_set_gpio_input(data->overcurrent_pin[i], 1);
 	}
 
diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index b948769..cd604aa 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -72,7 +72,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
 
 	/* Enable overcurrent notification */
 	for (i = 0; i < data->ports; i++) {
-		if (data->overcurrent_pin[i])
+		if (gpio_is_valid(data->overcurrent_pin[i]))
 			at91_set_gpio_input(data->overcurrent_pin[i], 1);
 	}
 
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index cb85da2..9c61e59 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -78,7 +78,7 @@ void __init at91_add_device_usbh(struct at91_usbh_data *data)
 
 	/* Enable overcurrent notification */
 	for (i = 0; i < data->ports; i++) {
-		if (data->overcurrent_pin[i])
+		if (gpio_is_valid(data->overcurrent_pin[i]))
 			at91_set_gpio_input(data->overcurrent_pin[i], 1);
 	}
 
-- 
1.8.0
