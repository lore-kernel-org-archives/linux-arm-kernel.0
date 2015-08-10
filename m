From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Aug 2015 16:46:19 +0200
Subject: [PATCH] usb: gadget: at91_udc: move at91_udc_data in at91_udc.h
Message-ID: <1439217979-15642-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct at91_udc_data is now only used inside the driver, move it to its
include.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/usb/gadget/udc/at91_udc.h   | 8 ++++++++
 include/linux/platform_data/atmel.h | 9 ---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.h b/drivers/usb/gadget/udc/at91_udc.h
index 2679c8b217cc..0a433e6b346b 100644
--- a/drivers/usb/gadget/udc/at91_udc.h
+++ b/drivers/usb/gadget/udc/at91_udc.h
@@ -112,6 +112,14 @@ struct at91_udc_caps {
 	void (*pullup)(struct at91_udc *udc, int is_on);
 };
 
+struct at91_udc_data {
+	int	vbus_pin;		/* high == host powering us */
+	u8	vbus_active_low;	/* vbus polarity */
+	u8	vbus_polled;		/* Use polling, not interrupt */
+	int	pullup_pin;		/* active == D+ pulled up */
+	u8	pullup_active_low;	/* true == pullup_pin is active low */
+};
+
 /*
  * driver is non-SMP, and just blocks IRQs whenever it needs
  * access protection for chip registers or driver state
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 4b452c6a2f7b..2d67e466c51b 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -25,15 +25,6 @@
  */
 #define ATMEL_MAX_UART	7
 
- /* USB Device */
-struct at91_udc_data {
-	int	vbus_pin;		/* high == host powering us */
-	u8	vbus_active_low;	/* vbus polarity */
-	u8	vbus_polled;		/* Use polling, not interrupt */
-	int	pullup_pin;		/* active == D+ pulled up */
-	u8	pullup_active_low;	/* true == pullup_pin is active low */
-};
-
  /* Compact Flash */
 struct at91_cf_data {
 	int	irq_pin;		/* I/O IRQ */
-- 
2.1.4
