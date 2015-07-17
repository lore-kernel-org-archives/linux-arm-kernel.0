From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 17 Jul 2015 11:32:45 +0200
Subject: [PATCH 4/9] gpio: Add 'name' to the gpio descriptor struct
In-Reply-To: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1437125570-28623-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The latest gpio hogging mechanism assigns each gpio a 'line-name' in the
devicetree. The 'name' field is different from the 'label' field.
'label' is only used for requested GPIOs to describe its current use by
driver or userspace.

The 'name' field describes the GPIO itself, not the use. This is most
likely identical to the label in the schematic on the GPIO line and
should help to find this particular GPIO.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/gpio/gpiolib.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index bf343004b008..78e634d1c719 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -89,7 +89,10 @@ struct gpio_desc {
 #define FLAG_USED_AS_IRQ 9	/* GPIO is connected to an IRQ */
 #define FLAG_IS_HOGGED	11	/* GPIO is hogged */
 
+	/* Connection label */
 	const char		*label;
+	/* Name of the GPIO */
+	const char		*name;
 };
 
 int gpiod_request(struct gpio_desc *desc, const char *label);
-- 
2.1.4
