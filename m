From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 29 Sep 2013 22:27:58 +0800
Subject: [PATCH 2/3] pinctrl: sirf: add lost USP-based UART pin groups for
 prima2
In-Reply-To: <1380464879-19897-1-git-send-email-Baohua.Song@csr.com>
References: <1380464879-19897-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1380464879-19897-2-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Qipan Li <Qipan.Li@csr.com>

USP(Universal Serial Ports) can be UART as commit 5df831117b85a08e7aa,
this patch defines the USP-based UART function pin groups for prima2.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/prima2.dtsi         | 24 ++++++++++++++
 drivers/pinctrl/sirf/pinctrl-prima2.c | 60 +++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm/boot/dts/prima2.dtsi b/arch/arm/boot/dts/prima2.dtsi
index 528ced8..2769bf3 100644
--- a/arch/arm/boot/dts/prima2.dtsi
+++ b/arch/arm/boot/dts/prima2.dtsi
@@ -532,18 +532,42 @@
                                                 sirf,function = "usp0";
                                         };
                                 };
+				usp0_uart_nostreamctrl_pins_a: usp0 at 1 {
+                                        usp0 {
+                                                sirf,pins =
+							"usp0_uart_nostreamctrl_grp";
+                                                sirf,function =
+							"usp0_uart_nostreamctrl";
+                                        };
+                                };
                                 usp1_pins_a: usp1 at 0 {
                                         usp1 {
                                                 sirf,pins = "usp1grp";
                                                 sirf,function = "usp1";
                                         };
                                 };
+				usp1_uart_nostreamctrl_pins_a: usp1 at 1 {
+                                        usp1 {
+                                                sirf,pins =
+							"usp1_uart_nostreamctrl_grp";
+                                                sirf,function =
+							"usp1_uart_nostreamctrl";
+                                        };
+                                };
                                 usp2_pins_a: usp2 at 0 {
                                         usp2 {
                                                 sirf,pins = "usp2grp";
                                                 sirf,function = "usp2";
                                         };
                                 };
+				usp2_uart_nostreamctrl_pins_a: usp2 at 1 {
+                                        usp2 {
+                                                sirf,pins =
+							"usp2_uart_nostreamctrl_grp";
+                                                sirf,function =
+							"usp2_uart_nostreamctrl";
+                                        };
+                                };
                                 usb0_utmi_drvbus_pins_a: usb0_utmi_drvbus at 0 {
                                         usb0_utmi_drvbus {
                                                 sirf,pins = "usb0_utmi_drvbusgrp";
diff --git a/drivers/pinctrl/sirf/pinctrl-prima2.c b/drivers/pinctrl/sirf/pinctrl-prima2.c
index 29fc842..241d839 100644
--- a/drivers/pinctrl/sirf/pinctrl-prima2.c
+++ b/drivers/pinctrl/sirf/pinctrl-prima2.c
@@ -485,6 +485,20 @@ static const struct sirfsoc_padmux usp0_padmux = {
 
 static const unsigned usp0_pins[] = { 51, 52, 53, 54, 55 };
 
+static const struct sirfsoc_muxmask usp0_uart_nostreamctrl_muxmask[] = {
+	{
+		.group = 1,
+		.mask = BIT(20) | BIT(21),
+	},
+};
+
+static const struct sirfsoc_padmux usp0_uart_nostreamctrl_padmux = {
+	.muxmask_counts = ARRAY_SIZE(usp0_uart_nostreamctrl_muxmask),
+	.muxmask = usp0_uart_nostreamctrl_muxmask,
+};
+
+static const unsigned usp0_uart_nostreamctrl_pins[] = { 52, 53 };
+
 static const struct sirfsoc_muxmask usp1_muxmask[] = {
 	{
 		.group = 1,
@@ -501,6 +515,20 @@ static const struct sirfsoc_padmux usp1_padmux = {
 
 static const unsigned usp1_pins[] = { 56, 57, 58, 59, 60 };
 
+static const struct sirfsoc_muxmask usp1_uart_nostreamctrl_muxmask[] = {
+	{
+		.group = 1,
+		.mask = BIT(25) | BIT(26),
+	},
+};
+
+static const struct sirfsoc_padmux usp1_uart_nostreamctrl_padmux = {
+	.muxmask_counts = ARRAY_SIZE(usp1_uart_nostreamctrl_muxmask),
+	.muxmask = usp1_uart_nostreamctrl_muxmask,
+};
+
+static const unsigned usp1_uart_nostreamctrl_pins[] = { 57, 58 };
+
 static const struct sirfsoc_muxmask usp2_muxmask[] = {
 	{
 		.group = 1,
@@ -520,6 +548,20 @@ static const struct sirfsoc_padmux usp2_padmux = {
 
 static const unsigned usp2_pins[] = { 61, 62, 63, 64, 65 };
 
+static const struct sirfsoc_muxmask usp2_uart_nostreamctrl_muxmask[] = {
+	{
+		.group = 1,
+		.mask = BIT(30) | BIT(31),
+	},
+};
+
+static const struct sirfsoc_padmux usp2_uart_nostreamctrl_padmux = {
+	.muxmask_counts = ARRAY_SIZE(usp2_uart_nostreamctrl_muxmask),
+	.muxmask = usp2_uart_nostreamctrl_muxmask,
+};
+
+static const unsigned usp2_uart_nostreamctrl_pins[] = { 62, 63 };
+
 static const struct sirfsoc_muxmask nand_muxmask[] = {
 	{
 		.group = 2,
@@ -769,8 +811,14 @@ static const struct sirfsoc_pin_group sirfsoc_pin_groups[] = {
 	SIRFSOC_PIN_GROUP("uart2grp", uart2_pins),
 	SIRFSOC_PIN_GROUP("uart2_nostreamctrlgrp", uart2_nostreamctrl_pins),
 	SIRFSOC_PIN_GROUP("usp0grp", usp0_pins),
+	SIRFSOC_PIN_GROUP("usp0_uart_nostreamctrl_grp",
+					usp0_uart_nostreamctrl_pins),
 	SIRFSOC_PIN_GROUP("usp1grp", usp1_pins),
+	SIRFSOC_PIN_GROUP("usp1_uart_nostreamctrl_grp",
+					usp1_uart_nostreamctrl_pins),
 	SIRFSOC_PIN_GROUP("usp2grp", usp2_pins),
+	SIRFSOC_PIN_GROUP("usp2_uart_nostreamctrl_grp",
+					usp2_uart_nostreamctrl_pins),
 	SIRFSOC_PIN_GROUP("i2c0grp", i2c0_pins),
 	SIRFSOC_PIN_GROUP("i2c1grp", i2c1_pins),
 	SIRFSOC_PIN_GROUP("pwm0grp", pwm0_pins),
@@ -809,8 +857,14 @@ static const char * const uart1grp[] = { "uart1grp" };
 static const char * const uart2grp[] = { "uart2grp" };
 static const char * const uart2_nostreamctrlgrp[] = { "uart2_nostreamctrlgrp" };
 static const char * const usp0grp[] = { "usp0grp" };
+static const char * const usp0_uart_nostreamctrl_grp[] =
+					{ "usp0_uart_nostreamctrl_grp" };
 static const char * const usp1grp[] = { "usp1grp" };
+static const char * const usp1_uart_nostreamctrl_grp[] =
+					{ "usp1_uart_nostreamctrl_grp" };
 static const char * const usp2grp[] = { "usp2grp" };
+static const char * const usp2_uart_nostreamctrl_grp[] =
+					{ "usp2_uart_nostreamctrl_grp" };
 static const char * const i2c0grp[] = { "i2c0grp" };
 static const char * const i2c1grp[] = { "i2c1grp" };
 static const char * const pwm0grp[] = { "pwm0grp" };
@@ -849,8 +903,14 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 	SIRFSOC_PMX_FUNCTION("uart2", uart2grp, uart2_padmux),
 	SIRFSOC_PMX_FUNCTION("uart2_nostreamctrl", uart2_nostreamctrlgrp, uart2_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("usp0", usp0grp, usp0_padmux),
+	SIRFSOC_PMX_FUNCTION("usp0_uart_nostreamctrl",
+		usp0_uart_nostreamctrl_grp, usp0_uart_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("usp1", usp1grp, usp1_padmux),
+	SIRFSOC_PMX_FUNCTION("usp1_uart_nostreamctrl",
+		usp1_uart_nostreamctrl_grp, usp1_uart_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("usp2", usp2grp, usp2_padmux),
+	SIRFSOC_PMX_FUNCTION("usp2_uart_nostreamctrl",
+		usp2_uart_nostreamctrl_grp, usp2_uart_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("i2c0", i2c0grp, i2c0_padmux),
 	SIRFSOC_PMX_FUNCTION("i2c1", i2c1grp, i2c1_padmux),
 	SIRFSOC_PMX_FUNCTION("pwm0", pwm0grp, pwm0_padmux),
-- 
1.8.2.3
