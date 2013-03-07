From: ian@slimlogic.co.uk (Ian Lartey)
Date: Thu,  7 Mar 2013 13:17:55 +0000
Subject: [PATCH v8 11/12] leds: Kconfig for Palmas LEDs
In-Reply-To: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
References: <1362662276-20792-1-git-send-email-ian@slimlogic.co.uk>
Message-ID: <1362662276-20792-11-git-send-email-ian@slimlogic.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Kconfig and Makefile for the Palmas LED driver.

Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
Signed-off-by: Ian Lartey <ian@slimlogic.co.uk>
---
 drivers/leds/Kconfig  |    9 +++++++++
 drivers/leds/Makefile |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index ec50824..a070e29 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -469,6 +469,15 @@ config LEDS_BLINKM
 	  This option enables support for the BlinkM RGB LED connected
 	  through I2C. Say Y to enable support for the BlinkM LED.
 
+config LEDS_PALMAS
+	bool "LED support for the Palmas family of PMICs"
+	depends on LEDS_CLASS
+	depends on MFD_PALMAS
+	help
+	  This option enables the driver for LED1 & LED2 pins on Palmas PMIC
+	  if these pins are enabled in the mux configuration. The driver support
+	  ON/OFF and blinking with hardware control.
+
 config LEDS_TRIGGERS
 	bool "LED Trigger support"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 215e7e3..233023e 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_LEDS_RENESAS_TPU)		+= leds-renesas-tpu.o
 obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
 obj-$(CONFIG_LEDS_LM355x)		+= leds-lm355x.o
 obj-$(CONFIG_LEDS_BLINKM)		+= leds-blinkm.o
+obj-$(CONFIG_LEDS_PALMAS)		+= leds-palmas.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
-- 
1.7.0.4
