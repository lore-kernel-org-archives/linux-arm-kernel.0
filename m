From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 20 Sep 2017 15:39:26 +0200
Subject: [PATCH 7/8] pinctrl: meson-gx: TEST_N belongs to the AO controller
In-Reply-To: <20170920133927.17390-1-jbrunet@baylibre.com>
References: <20170920133927.17390-1-jbrunet@baylibre.com>
Message-ID: <20170920133927.17390-8-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On meson-gx platforms, TEST_N has been incorrectly declared in the EE
controller while it belongs to AO controller.

Move the pin to the appropriate controller

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 8 ++++----
 drivers/pinctrl/meson/pinctrl-meson-gxl.c  | 8 ++++----
 include/dt-bindings/gpio/meson-gxbb-gpio.h | 2 +-
 include/dt-bindings/gpio/meson-gxl-gpio.h  | 2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 8e0d6e4a31b4..1305d68b0954 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -141,8 +141,6 @@ static const struct pinctrl_pin_desc meson_gxbb_periphs_pins[] = {
 	MESON_PIN(GPIOCLK_1),
 	MESON_PIN(GPIOCLK_2),
 	MESON_PIN(GPIOCLK_3),
-
-	MESON_PIN(GPIO_TEST_N),
 };
 
 static const unsigned int emmc_nand_d07_pins[] = {
@@ -258,6 +256,8 @@ static const struct pinctrl_pin_desc meson_gxbb_aobus_pins[] = {
 	MESON_PIN(GPIOAO_11),
 	MESON_PIN(GPIOAO_12),
 	MESON_PIN(GPIOAO_13),
+
+	MESON_PIN(GPIO_TEST_N),
 };
 
 static const unsigned int uart_tx_ao_a_pins[]	= { GPIOAO_0 };
@@ -596,8 +596,6 @@ static const char * const gpio_periphs_groups[] = {
 	"GPIOX_10", "GPIOX_11", "GPIOX_12", "GPIOX_13", "GPIOX_14",
 	"GPIOX_15", "GPIOX_16", "GPIOX_17", "GPIOX_18", "GPIOX_19",
 	"GPIOX_20", "GPIOX_21", "GPIOX_22",
-
-	"GPIO_TEST_N",
 };
 
 static const char * const emmc_groups[] = {
@@ -706,6 +704,8 @@ static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
 	"GPIOAO_10", "GPIOAO_11", "GPIOAO_12", "GPIOAO_13",
+
+	"GPIO_TEST_N",
 };
 
 static const char * const uart_ao_groups[] = {
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 0d90ddab6ddd..04334e807170 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -122,8 +122,6 @@ static const struct pinctrl_pin_desc meson_gxl_periphs_pins[] = {
 
 	MESON_PIN(GPIOCLK_0),
 	MESON_PIN(GPIOCLK_1),
-
-	MESON_PIN(GPIO_TEST_N),
 };
 
 static const unsigned int emmc_nand_d07_pins[] = {
@@ -263,6 +261,8 @@ static const struct pinctrl_pin_desc meson_gxl_aobus_pins[] = {
 	MESON_PIN(GPIOAO_7),
 	MESON_PIN(GPIOAO_8),
 	MESON_PIN(GPIOAO_9),
+
+	MESON_PIN(GPIO_TEST_N),
 };
 
 static const unsigned int uart_tx_ao_a_pins[]	= { GPIOAO_0 };
@@ -587,8 +587,6 @@ static const char * const gpio_periphs_groups[] = {
 	"GPIOX_5", "GPIOX_6", "GPIOX_7", "GPIOX_8", "GPIOX_9",
 	"GPIOX_10", "GPIOX_11", "GPIOX_12", "GPIOX_13", "GPIOX_14",
 	"GPIOX_15", "GPIOX_16", "GPIOX_17", "GPIOX_18",
-
-	"GPIO_TEST_N",
 };
 
 static const char * const emmc_groups[] = {
@@ -703,6 +701,8 @@ static const char * const tsin_a_groups[] = {
 static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
 	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
+
+	"GPIO_TEST_N",
 };
 
 static const char * const uart_ao_groups[] = {
diff --git a/include/dt-bindings/gpio/meson-gxbb-gpio.h b/include/dt-bindings/gpio/meson-gxbb-gpio.h
index 58654fd7aa1e..43a68a1110f0 100644
--- a/include/dt-bindings/gpio/meson-gxbb-gpio.h
+++ b/include/dt-bindings/gpio/meson-gxbb-gpio.h
@@ -29,6 +29,7 @@
 #define	GPIOAO_11	11
 #define	GPIOAO_12	12
 #define	GPIOAO_13	13
+#define	GPIO_TEST_N	14
 
 #define	GPIOZ_0		0
 #define	GPIOZ_1		1
@@ -149,6 +150,5 @@
 #define	GPIOCLK_1	116
 #define	GPIOCLK_2	117
 #define	GPIOCLK_3	118
-#define	GPIO_TEST_N	119
 
 #endif
diff --git a/include/dt-bindings/gpio/meson-gxl-gpio.h b/include/dt-bindings/gpio/meson-gxl-gpio.h
index 684d0d7add1c..01f2a2abd35e 100644
--- a/include/dt-bindings/gpio/meson-gxl-gpio.h
+++ b/include/dt-bindings/gpio/meson-gxl-gpio.h
@@ -25,6 +25,7 @@
 #define	GPIOAO_7	7
 #define	GPIOAO_8	8
 #define	GPIOAO_9	9
+#define	GPIO_TEST_N	10
 
 #define	GPIOZ_0		0
 #define	GPIOZ_1		1
@@ -126,6 +127,5 @@
 #define	GPIOX_18	97
 #define	GPIOCLK_0	98
 #define	GPIOCLK_1	99
-#define	GPIO_TEST_N	100
 
 #endif
-- 
2.13.5
