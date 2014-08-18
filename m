From: Baohua.Song@csr.com (Barry Song)
Date: Mon, 18 Aug 2014 16:49:21 +0800
Subject: [PATCH 2/6] pinctrl: sirf: fix lots of "line over 80 characters"
In-Reply-To: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
References: <1408351765-18253-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1408351765-18253-2-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bin Shi <Bin.Shi@csr.com>

According to key customer's requirement, fix "line over 80
characters".

Signed-off-by: Bin Shi <Bin.Shi@csr.com>
Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/pinctrl/sirf/pinctrl-atlas6.c | 67 ++++++++++++++++-----------
 drivers/pinctrl/sirf/pinctrl-prima2.c | 85 +++++++++++++++++++++--------------
 drivers/pinctrl/sirf/pinctrl-sirf.c   | 57 ++++++++++++++---------
 3 files changed, 128 insertions(+), 81 deletions(-)

diff --git a/drivers/pinctrl/sirf/pinctrl-atlas6.c b/drivers/pinctrl/sirf/pinctrl-atlas6.c
index c4dd3d5..b0bd2c4 100644
--- a/drivers/pinctrl/sirf/pinctrl-atlas6.c
+++ b/drivers/pinctrl/sirf/pinctrl-atlas6.c
@@ -134,8 +134,9 @@ static const struct sirfsoc_muxmask lcd_16bits_sirfsoc_muxmask[] = {
 		.mask = BIT(30) | BIT(31),
 	}, {
 		.group = 2,
-		.mask = BIT(1) | BIT(6) | BIT(7) | BIT(8) | BIT(9) | BIT(10) | BIT(11) |
-			BIT(12) | BIT(13) | BIT(15) | BIT(16) | BIT(17) | BIT(18) | BIT(19) |
+		.mask = BIT(1) | BIT(6) | BIT(7) | BIT(8) | BIT(9) |
+			BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(15) |
+			BIT(16) | BIT(17) | BIT(18) | BIT(19) |
 			BIT(20) | BIT(21) | BIT(22) | BIT(31),
 	},
 };
@@ -148,14 +149,15 @@ static const struct sirfsoc_padmux lcd_16bits_padmux = {
 	.funcval = 0,
 };
 
-static const unsigned lcd_16bits_pins[] = { 62, 63, 65, 70, 71, 72, 73, 74, 75, 76, 77, 79, 80, 81, 82, 83,
-	84, 85, 86, 95 };
+static const unsigned lcd_16bits_pins[] = { 62, 63, 65, 70, 71, 72, 73, 74, 75,
+	76, 77, 79, 80, 81, 82, 83, 84, 85, 86, 95 };
 
 static const struct sirfsoc_muxmask lcd_18bits_muxmask[] = {
 	{
 		.group = 2,
-		.mask = BIT(1) | BIT(6) | BIT(7) | BIT(8) | BIT(9) | BIT(10) | BIT(11) |
-			BIT(12) | BIT(13) | BIT(15) | BIT(16) | BIT(17) | BIT(18) | BIT(19) |
+		.mask = BIT(1) | BIT(6) | BIT(7) | BIT(8) | BIT(9) |
+			BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(15) |
+			BIT(16) | BIT(17) | BIT(18) | BIT(19) |
 			BIT(20) | BIT(21) | BIT(22) | BIT(31),
 	}, {
 		.group = 1,
@@ -174,21 +176,23 @@ static const struct sirfsoc_padmux lcd_18bits_padmux = {
 	.funcval = 0,
 };
 
-static const unsigned lcd_18bits_pins[] = { 16, 17, 62, 63, 65, 70, 71, 72, 73, 74, 75, 76, 77, 79, 80, 81, 82, 83,
-	84, 85, 86, 95 };
+static const unsigned lcd_18bits_pins[] = { 16, 17, 62, 63, 65, 70, 71, 72, 73,
+	74, 75, 76, 77, 79, 80, 81, 82, 83, 84, 85, 86, 95 };
 
 static const struct sirfsoc_muxmask lcd_24bits_muxmask[] = {
 	{
 		.group = 2,
-		.mask = BIT(1) | BIT(6) | BIT(7) | BIT(8) | BIT(9) | BIT(10) | BIT(11) |
-			BIT(12) | BIT(13) | BIT(15) | BIT(16) | BIT(17) | BIT(18) | BIT(19) |
+		.mask = BIT(1) | BIT(6) | BIT(7) | BIT(8) | BIT(9) |
+			BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(15) |
+			BIT(16) | BIT(17) | BIT(18) | BIT(19) |
 			BIT(20) | BIT(21) | BIT(22) | BIT(31),
 	}, {
 		.group = 1,
 		.mask = BIT(30) | BIT(31),
 	}, {
 		.group = 0,
-		.mask = BIT(16) | BIT(17) | BIT(18) | BIT(19) | BIT(20) | BIT(21) | BIT(22) | BIT(23),
+		.mask = BIT(16) | BIT(17) | BIT(18) | BIT(19) | BIT(20) |
+			BIT(21) | BIT(22) | BIT(23),
 	},
 };
 
@@ -200,14 +204,16 @@ static const struct sirfsoc_padmux lcd_24bits_padmux = {
 	.funcval = 0,
 };
 
-static const unsigned lcd_24bits_pins[] = { 16, 17, 18, 19, 20, 21, 22, 23, 62, 63, 65, 70, 71, 72, 73, 74, 75, 76, 77, 79,
-	80, 81, 82, 83, 84, 85, 86, 95};
+static const unsigned lcd_24bits_pins[] = { 16, 17, 18, 19, 20, 21, 22, 23, 62,
+	63, 65, 70, 71, 72, 73, 74, 75, 76, 77, 79, 80, 81, 82, 83, 84,
+	85, 86, 95};
 
 static const struct sirfsoc_muxmask lcdrom_muxmask[] = {
 	{
 		.group = 2,
-		.mask = BIT(1) | BIT(6) | BIT(7) | BIT(8) | BIT(9) | BIT(10) | BIT(11) |
-			BIT(12) | BIT(13) | BIT(15) | BIT(16) | BIT(17) | BIT(18) | BIT(19) |
+		.mask = BIT(1) | BIT(6) | BIT(7) | BIT(8) | BIT(9) | BIT(10) |
+			BIT(11) | BIT(12) | BIT(13) | BIT(15) | BIT(16) |
+			BIT(17) | BIT(18) | BIT(19) |
 			BIT(20) | BIT(21) | BIT(22) | BIT(31),
 	}, {
 		.group = 1,
@@ -226,8 +232,8 @@ static const struct sirfsoc_padmux lcdrom_padmux = {
 	.funcval = BIT(4),
 };
 
-static const unsigned lcdrom_pins[] = { 8, 62, 63, 65, 70, 71, 72, 73, 74, 75, 76, 77, 79, 80, 81, 82, 83,
-	84, 85, 86, 95};
+static const unsigned lcdrom_pins[] = { 8, 62, 63, 65, 70, 71, 72, 73, 74, 75,
+	76, 77, 79, 80, 81, 82, 83, 84, 85, 86, 95};
 
 static const struct sirfsoc_muxmask uart0_muxmask[] = {
 	{
@@ -716,7 +722,8 @@ static const struct sirfsoc_padmux vip_padmux = {
 	.funcval = BIT(18),
 };
 
-static const unsigned vip_pins[] = { 36, 37, 38, 40, 41, 56, 57, 58, 59, 60, 61 };
+static const unsigned vip_pins[] = { 36, 37, 38, 40, 41, 56, 57, 58, 59,
+	60, 61 };
 
 static const struct sirfsoc_muxmask vip_noupli_muxmask[] = {
 	{
@@ -737,7 +744,8 @@ static const struct sirfsoc_padmux vip_noupli_padmux = {
 	.funcval = BIT(15),
 };
 
-static const unsigned vip_noupli_pins[] = { 16, 17, 18, 19, 20, 21, 22, 23, 87, 88, 89 };
+static const unsigned vip_noupli_pins[] = { 16, 17, 18, 19, 20, 21, 22, 23,
+	87, 88, 89 };
 
 static const struct sirfsoc_muxmask i2c0_muxmask[] = {
 	{
@@ -876,7 +884,8 @@ static const struct sirfsoc_padmux usb0_upli_drvbus_padmux = {
 	.funcval = 0,
 };
 
-static const unsigned usb0_upli_drvbus_pins[] = { 36, 37, 38, 39, 40, 41, 56, 57, 58, 59, 60, 61 };
+static const unsigned usb0_upli_drvbus_pins[] = { 36, 37, 38, 39, 40,
+	41, 56, 57, 58, 59, 60, 61 };
 
 static const struct sirfsoc_muxmask usb1_utmi_drvbus_muxmask[] = {
 	{
@@ -1017,7 +1026,8 @@ static const char * const sdmmc2_nowpgrp[] = { "sdmmc2_nowpgrp" };
 static const char * const usb0_upli_drvbusgrp[] = { "usb0_upli_drvbusgrp" };
 static const char * const usb1_utmi_drvbusgrp[] = { "usb1_utmi_drvbusgrp" };
 static const char * const usb1_dp_dngrp[] = { "usb1_dp_dngrp" };
-static const char * const uart1_route_io_usb1grp[] = { "uart1_route_io_usb1grp" };
+static const char * const
+	uart1_route_io_usb1grp[] = { "uart1_route_io_usb1grp" };
 static const char * const pulse_countgrp[] = { "pulse_countgrp" };
 static const char * const i2sgrp[] = { "i2sgrp" };
 static const char * const i2s_no_dingrp[] = { "i2s_no_dingrp" };
@@ -1038,7 +1048,8 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 						uart0_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("uart1", uart1grp, uart1_padmux),
 	SIRFSOC_PMX_FUNCTION("uart2", uart2grp, uart2_padmux),
-	SIRFSOC_PMX_FUNCTION("uart2_nostreamctrl", uart2_nostreamctrlgrp, uart2_nostreamctrl_padmux),
+	SIRFSOC_PMX_FUNCTION("uart2_nostreamctrl",
+		uart2_nostreamctrlgrp, uart2_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("usp0", usp0grp, usp0_padmux),
 	SIRFSOC_PMX_FUNCTION("usp0_uart_nostreamctrl",
 						usp0_uart_nostreamctrl_grp,
@@ -1068,11 +1079,15 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 	SIRFSOC_PMX_FUNCTION("sdmmc2", sdmmc2grp, sdmmc2_padmux),
 	SIRFSOC_PMX_FUNCTION("sdmmc3", sdmmc3grp, sdmmc3_padmux),
 	SIRFSOC_PMX_FUNCTION("sdmmc5", sdmmc5grp, sdmmc5_padmux),
-	SIRFSOC_PMX_FUNCTION("sdmmc2_nowp", sdmmc2_nowpgrp, sdmmc2_nowp_padmux),
-	SIRFSOC_PMX_FUNCTION("usb0_upli_drvbus", usb0_upli_drvbusgrp, usb0_upli_drvbus_padmux),
-	SIRFSOC_PMX_FUNCTION("usb1_utmi_drvbus", usb1_utmi_drvbusgrp, usb1_utmi_drvbus_padmux),
+	SIRFSOC_PMX_FUNCTION("sdmmc2_nowp",
+		sdmmc2_nowpgrp, sdmmc2_nowp_padmux),
+	SIRFSOC_PMX_FUNCTION("usb0_upli_drvbus",
+		usb0_upli_drvbusgrp, usb0_upli_drvbus_padmux),
+	SIRFSOC_PMX_FUNCTION("usb1_utmi_drvbus",
+		usb1_utmi_drvbusgrp, usb1_utmi_drvbus_padmux),
 	SIRFSOC_PMX_FUNCTION("usb1_dp_dn", usb1_dp_dngrp, usb1_dp_dn_padmux),
-	SIRFSOC_PMX_FUNCTION("uart1_route_io_usb1", uart1_route_io_usb1grp, uart1_route_io_usb1_padmux),
+	SIRFSOC_PMX_FUNCTION("uart1_route_io_usb1",
+		uart1_route_io_usb1grp, uart1_route_io_usb1_padmux),
 	SIRFSOC_PMX_FUNCTION("pulse_count", pulse_countgrp, pulse_count_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s", i2sgrp, i2s_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s_no_din", i2s_no_dingrp, i2s_no_din_padmux),
diff --git a/drivers/pinctrl/sirf/pinctrl-prima2.c b/drivers/pinctrl/sirf/pinctrl-prima2.c
index 8aa76f0..fda2547f 100644
--- a/drivers/pinctrl/sirf/pinctrl-prima2.c
+++ b/drivers/pinctrl/sirf/pinctrl-prima2.c
@@ -135,8 +135,9 @@ static const struct pinctrl_pin_desc sirfsoc_pads[] = {
 static const struct sirfsoc_muxmask lcd_16bits_sirfsoc_muxmask[] = {
 	{
 		.group = 3,
-		.mask = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | BIT(7) | BIT(8) |
-			BIT(9) | BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14) | BIT(15) | BIT(16) |
+		.mask = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+			BIT(6) | BIT(7) | BIT(8) | BIT(9) | BIT(10) | BIT(11) |
+			BIT(12) | BIT(13) | BIT(14) | BIT(15) | BIT(16) |
 			BIT(17) | BIT(18),
 	}, {
 		.group = 2,
@@ -152,14 +153,15 @@ static const struct sirfsoc_padmux lcd_16bits_padmux = {
 	.funcval = 0,
 };
 
-static const unsigned lcd_16bits_pins[] = { 95, 96, 97, 98, 99, 100, 101, 102, 103, 104,
-	105, 106, 107, 108, 109, 110, 111, 112, 113, 114 };
+static const unsigned lcd_16bits_pins[] = { 95, 96, 97, 98, 99, 100, 101, 102,
+	103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114 };
 
 static const struct sirfsoc_muxmask lcd_18bits_muxmask[] = {
 	{
 		.group = 3,
-		.mask = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | BIT(7) | BIT(8) |
-			BIT(9) | BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14) | BIT(15) | BIT(16) |
+		.mask = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+			BIT(6) | BIT(7) | BIT(8) | BIT(9) | BIT(10) | BIT(11) |
+			BIT(12) | BIT(13) | BIT(14) | BIT(15) | BIT(16) |
 			BIT(17) | BIT(18),
 	}, {
 		.group = 2,
@@ -178,21 +180,23 @@ static const struct sirfsoc_padmux lcd_18bits_padmux = {
 	.funcval = 0,
 };
 
-static const unsigned lcd_18bits_pins[] = { 16, 17, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104,
-	105, 106, 107, 108, 109, 110, 111, 112, 113, 114};
+static const unsigned lcd_18bits_pins[] = { 16, 17, 95, 96, 97, 98, 99, 100,
+	101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114};
 
 static const struct sirfsoc_muxmask lcd_24bits_muxmask[] = {
 	{
 		.group = 3,
-		.mask = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | BIT(7) | BIT(8) |
-			BIT(9) | BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14) | BIT(15) | BIT(16) |
+		.mask = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+			BIT(6) | BIT(7) | BIT(8) | BIT(9) | BIT(10) | BIT(11) |
+			BIT(12) | BIT(13) | BIT(14) | BIT(15) | BIT(16) |
 			BIT(17) | BIT(18),
 	}, {
 		.group = 2,
 		.mask = BIT(31),
 	}, {
 		.group = 0,
-		.mask = BIT(16) | BIT(17) | BIT(18) | BIT(19) | BIT(20) | BIT(21) | BIT(22) | BIT(23),
+		.mask = BIT(16) | BIT(17) | BIT(18) | BIT(19) | BIT(20) |
+			BIT(21) | BIT(22) | BIT(23),
 	},
 };
 
@@ -204,14 +208,16 @@ static const struct sirfsoc_padmux lcd_24bits_padmux = {
 	.funcval = 0,
 };
 
-static const unsigned lcd_24bits_pins[] = { 16, 17, 18, 19, 20, 21, 22, 23, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104,
-	105, 106, 107, 108, 109, 110, 111, 112, 113, 114 };
+static const unsigned lcd_24bits_pins[] = { 16, 17, 18, 19, 20, 21, 22, 23,
+	95, 96,	97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109,
+	110, 111, 112, 113, 114 };
 
 static const struct sirfsoc_muxmask lcdrom_muxmask[] = {
 	{
 		.group = 3,
-		.mask = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | BIT(7) | BIT(8) |
-			BIT(9) | BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14) | BIT(15) | BIT(16) |
+		.mask = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
+			BIT(6) | BIT(7) | BIT(8) | BIT(9) | BIT(10) | BIT(11) |
+			BIT(12) | BIT(13) | BIT(14) | BIT(15) | BIT(16) |
 			BIT(17) | BIT(18),
 	}, {
 		.group = 2,
@@ -230,8 +236,8 @@ static const struct sirfsoc_padmux lcdrom_padmux = {
 	.funcval = BIT(4),
 };
 
-static const unsigned lcdrom_pins[] = { 23, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104,
-	105, 106, 107, 108, 109, 110, 111, 112, 113, 114 };
+static const unsigned lcdrom_pins[] = { 23, 95, 96, 97, 98, 99, 100, 101, 102,
+	103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114 };
 
 static const struct sirfsoc_muxmask uart0_muxmask[] = {
 	{
@@ -685,7 +691,8 @@ static const struct sirfsoc_padmux vip_padmux = {
 	.funcval = 0,
 };
 
-static const unsigned vip_pins[] = { 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89 };
+static const unsigned vip_pins[] = { 79, 80, 81, 82, 83, 84, 85, 86, 87,
+	88, 89 };
 
 static const struct sirfsoc_muxmask i2c0_muxmask[] = {
 	{
@@ -735,7 +742,8 @@ static const struct sirfsoc_padmux viprom_padmux = {
 	.funcval = BIT(0),
 };
 
-static const unsigned viprom_pins[] = { 12, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89 };
+static const unsigned viprom_pins[] = { 12, 79, 80, 81, 82, 83, 84, 85, 86,
+	87, 88, 89 };
 
 static const struct sirfsoc_muxmask pwm0_muxmask[] = {
 	{
@@ -936,16 +944,19 @@ static const char * const uart1grp[] = { "uart1grp" };
 static const char * const uart2grp[] = { "uart2grp" };
 static const char * const uart2_nostreamctrlgrp[] = { "uart2_nostreamctrlgrp" };
 static const char * const usp0grp[] = { "usp0grp" };
-static const char * const usp0_uart_nostreamctrl_grp[] =
-					{ "usp0_uart_nostreamctrl_grp" };
+static const char * const usp0_uart_nostreamctrl_grp[] = {
+	"usp0_uart_nostreamctrl_grp"
+};
 static const char * const usp0_only_utfs_grp[] = { "usp0_only_utfs_grp" };
 static const char * const usp0_only_urfs_grp[] = { "usp0_only_urfs_grp" };
 static const char * const usp1grp[] = { "usp1grp" };
-static const char * const usp1_uart_nostreamctrl_grp[] =
-					{ "usp1_uart_nostreamctrl_grp" };
+static const char * const usp1_uart_nostreamctrl_grp[] = {
+	"usp1_uart_nostreamctrl_grp"
+};
 static const char * const usp2grp[] = { "usp2grp" };
-static const char * const usp2_uart_nostreamctrl_grp[] =
-					{ "usp2_uart_nostreamctrl_grp" };
+static const char * const usp2_uart_nostreamctrl_grp[] = {
+	"usp2_uart_nostreamctrl_grp"
+};
 static const char * const i2c0grp[] = { "i2c0grp" };
 static const char * const i2c1grp[] = { "i2c1grp" };
 static const char * const pwm0grp[] = { "pwm0grp" };
@@ -966,7 +977,8 @@ static const char * const sdmmc5grp[] = { "sdmmc5grp" };
 static const char * const usb0_utmi_drvbusgrp[] = { "usb0_utmi_drvbusgrp" };
 static const char * const usb1_utmi_drvbusgrp[] = { "usb1_utmi_drvbusgrp" };
 static const char * const usb1_dp_dngrp[] = { "usb1_dp_dngrp" };
-static const char * const uart1_route_io_usb1grp[] = { "uart1_route_io_usb1grp" };
+static const char * const
+	uart1_route_io_usb1grp[] = { "uart1_route_io_usb1grp" };
 static const char * const pulse_countgrp[] = { "pulse_countgrp" };
 static const char * const i2sgrp[] = { "i2sgrp" };
 static const char * const ac97grp[] = { "ac97grp" };
@@ -981,15 +993,19 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 	SIRFSOC_PMX_FUNCTION("lcd_24bits", lcd_24bitsgrp, lcd_24bits_padmux),
 	SIRFSOC_PMX_FUNCTION("lcdrom", lcdromgrp, lcdrom_padmux),
 	SIRFSOC_PMX_FUNCTION("uart0", uart0grp, uart0_padmux),
-	SIRFSOC_PMX_FUNCTION("uart0_nostreamctrl", uart0_nostreamctrlgrp, uart0_nostreamctrl_padmux),
+	SIRFSOC_PMX_FUNCTION("uart0_nostreamctrl",
+		uart0_nostreamctrlgrp, uart0_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("uart1", uart1grp, uart1_padmux),
 	SIRFSOC_PMX_FUNCTION("uart2", uart2grp, uart2_padmux),
-	SIRFSOC_PMX_FUNCTION("uart2_nostreamctrl", uart2_nostreamctrlgrp, uart2_nostreamctrl_padmux),
+	SIRFSOC_PMX_FUNCTION("uart2_nostreamctrl",
+		uart2_nostreamctrlgrp, uart2_nostreamctrl_padmux),
 	SIRFSOC_PMX_FUNCTION("usp0", usp0grp, usp0_padmux),
 	SIRFSOC_PMX_FUNCTION("usp0_uart_nostreamctrl",
 		usp0_uart_nostreamctrl_grp, usp0_uart_nostreamctrl_padmux),
-	SIRFSOC_PMX_FUNCTION("usp0_only_utfs", usp0_only_utfs_grp, usp0_only_utfs_padmux),
-	SIRFSOC_PMX_FUNCTION("usp0_only_urfs", usp0_only_urfs_grp, usp0_only_urfs_padmux),
+	SIRFSOC_PMX_FUNCTION("usp0_only_utfs",
+		usp0_only_utfs_grp, usp0_only_utfs_padmux),
+	SIRFSOC_PMX_FUNCTION("usp0_only_urfs",
+		usp0_only_urfs_grp, usp0_only_urfs_padmux),
 	SIRFSOC_PMX_FUNCTION("usp1", usp1grp, usp1_padmux),
 	SIRFSOC_PMX_FUNCTION("usp1_uart_nostreamctrl",
 		usp1_uart_nostreamctrl_grp, usp1_uart_nostreamctrl_padmux),
@@ -1013,10 +1029,13 @@ static const struct sirfsoc_pmx_func sirfsoc_pmx_functions[] = {
 	SIRFSOC_PMX_FUNCTION("sdmmc3", sdmmc3grp, sdmmc3_padmux),
 	SIRFSOC_PMX_FUNCTION("sdmmc4", sdmmc4grp, sdmmc4_padmux),
 	SIRFSOC_PMX_FUNCTION("sdmmc5", sdmmc5grp, sdmmc5_padmux),
-	SIRFSOC_PMX_FUNCTION("usb0_utmi_drvbus", usb0_utmi_drvbusgrp, usb0_utmi_drvbus_padmux),
-	SIRFSOC_PMX_FUNCTION("usb1_utmi_drvbus", usb1_utmi_drvbusgrp, usb1_utmi_drvbus_padmux),
+	SIRFSOC_PMX_FUNCTION("usb0_utmi_drvbus",
+		usb0_utmi_drvbusgrp, usb0_utmi_drvbus_padmux),
+	SIRFSOC_PMX_FUNCTION("usb1_utmi_drvbus",
+		usb1_utmi_drvbusgrp, usb1_utmi_drvbus_padmux),
 	SIRFSOC_PMX_FUNCTION("usb1_dp_dn", usb1_dp_dngrp, usb1_dp_dn_padmux),
-	SIRFSOC_PMX_FUNCTION("uart1_route_io_usb1", uart1_route_io_usb1grp, uart1_route_io_usb1_padmux),
+	SIRFSOC_PMX_FUNCTION("uart1_route_io_usb1",
+		uart1_route_io_usb1grp, uart1_route_io_usb1_padmux),
 	SIRFSOC_PMX_FUNCTION("pulse_count", pulse_countgrp, pulse_count_padmux),
 	SIRFSOC_PMX_FUNCTION("i2s", i2sgrp, i2s_padmux),
 	SIRFSOC_PMX_FUNCTION("ac97", ac97grp, ac97_padmux),
diff --git a/drivers/pinctrl/sirf/pinctrl-sirf.c b/drivers/pinctrl/sirf/pinctrl-sirf.c
index 08d1f5a9..45f93f95 100644
--- a/drivers/pinctrl/sirf/pinctrl-sirf.c
+++ b/drivers/pinctrl/sirf/pinctrl-sirf.c
@@ -58,17 +58,18 @@ static const char *sirfsoc_get_group_name(struct pinctrl_dev *pctldev,
 	return sirfsoc_pin_groups[selector].name;
 }
 
-static int sirfsoc_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
-			       const unsigned **pins,
-			       unsigned *num_pins)
+static int sirfsoc_get_group_pins(struct pinctrl_dev *pctldev,
+				unsigned selector,
+				const unsigned **pins,
+				unsigned *num_pins)
 {
 	*pins = sirfsoc_pin_groups[selector].pins;
 	*num_pins = sirfsoc_pin_groups[selector].num_pins;
 	return 0;
 }
 
-static void sirfsoc_pin_dbg_show(struct pinctrl_dev *pctldev, struct seq_file *s,
-		   unsigned offset)
+static void sirfsoc_pin_dbg_show(struct pinctrl_dev *pctldev,
+				struct seq_file *s, unsigned offset)
 {
 	seq_printf(s, " " DRIVER_NAME);
 }
@@ -138,22 +139,25 @@ static struct pinctrl_ops sirfsoc_pctrl_ops = {
 static struct sirfsoc_pmx_func *sirfsoc_pmx_functions;
 static int sirfsoc_pmxfunc_cnt;
 
-static void sirfsoc_pinmux_endisable(struct sirfsoc_pmx *spmx, unsigned selector,
-	bool enable)
+static void sirfsoc_pinmux_endisable(struct sirfsoc_pmx *spmx,
+					unsigned selector, bool enable)
 {
 	int i;
-	const struct sirfsoc_padmux *mux = sirfsoc_pmx_functions[selector].padmux;
+	const struct sirfsoc_padmux *mux =
+		sirfsoc_pmx_functions[selector].padmux;
 	const struct sirfsoc_muxmask *mask = mux->muxmask;
 
 	for (i = 0; i < mux->muxmask_counts; i++) {
 		u32 muxval;
 		if (!spmx->is_marco) {
-			muxval = readl(spmx->gpio_virtbase + SIRFSOC_GPIO_PAD_EN(mask[i].group));
+			muxval = readl(spmx->gpio_virtbase +
+				SIRFSOC_GPIO_PAD_EN(mask[i].group));
 			if (enable)
 				muxval = muxval & ~mask[i].mask;
 			else
 				muxval = muxval | mask[i].mask;
-			writel(muxval, spmx->gpio_virtbase + SIRFSOC_GPIO_PAD_EN(mask[i].group));
+			writel(muxval, spmx->gpio_virtbase +
+				SIRFSOC_GPIO_PAD_EN(mask[i].group));
 		} else {
 			if (enable)
 				writel(mask[i].mask, spmx->gpio_virtbase +
@@ -197,9 +201,10 @@ static const char *sirfsoc_pinmux_get_func_name(struct pinctrl_dev *pctldev,
 	return sirfsoc_pmx_functions[selector].name;
 }
 
-static int sirfsoc_pinmux_get_groups(struct pinctrl_dev *pctldev, unsigned selector,
-			       const char * const **groups,
-			       unsigned * const num_groups)
+static int sirfsoc_pinmux_get_groups(struct pinctrl_dev *pctldev,
+				unsigned selector,
+				const char * const **groups,
+				unsigned * const num_groups)
 {
 	*groups = sirfsoc_pmx_functions[selector].groups;
 	*num_groups = sirfsoc_pmx_functions[selector].num_groups;
@@ -218,9 +223,11 @@ static int sirfsoc_pinmux_request_gpio(struct pinctrl_dev *pmxdev,
 	spmx = pinctrl_dev_get_drvdata(pmxdev);
 
 	if (!spmx->is_marco) {
-		muxval = readl(spmx->gpio_virtbase + SIRFSOC_GPIO_PAD_EN(group));
+		muxval = readl(spmx->gpio_virtbase +
+			SIRFSOC_GPIO_PAD_EN(group));
 		muxval = muxval | (1 << (offset - range->pin_base));
-		writel(muxval, spmx->gpio_virtbase + SIRFSOC_GPIO_PAD_EN(group));
+		writel(muxval, spmx->gpio_virtbase +
+			SIRFSOC_GPIO_PAD_EN(group));
 	} else {
 		writel(1 << (offset - range->pin_base), spmx->gpio_virtbase +
 			SIRFSOC_GPIO_PAD_EN(group));
@@ -518,24 +525,29 @@ static int sirfsoc_gpio_irq_type(struct irq_data *d, unsigned type)
 	case IRQ_TYPE_NONE:
 		break;
 	case IRQ_TYPE_EDGE_RISING:
-		val |= SIRFSOC_GPIO_CTL_INTR_HIGH_MASK | SIRFSOC_GPIO_CTL_INTR_TYPE_MASK;
+		val |= SIRFSOC_GPIO_CTL_INTR_HIGH_MASK |
+			SIRFSOC_GPIO_CTL_INTR_TYPE_MASK;
 		val &= ~SIRFSOC_GPIO_CTL_INTR_LOW_MASK;
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
 		val &= ~SIRFSOC_GPIO_CTL_INTR_HIGH_MASK;
-		val |= SIRFSOC_GPIO_CTL_INTR_LOW_MASK | SIRFSOC_GPIO_CTL_INTR_TYPE_MASK;
+		val |= SIRFSOC_GPIO_CTL_INTR_LOW_MASK |
+			SIRFSOC_GPIO_CTL_INTR_TYPE_MASK;
 		break;
 	case IRQ_TYPE_EDGE_BOTH:
-		val |= SIRFSOC_GPIO_CTL_INTR_HIGH_MASK | SIRFSOC_GPIO_CTL_INTR_LOW_MASK |
-			 SIRFSOC_GPIO_CTL_INTR_TYPE_MASK;
+		val |= SIRFSOC_GPIO_CTL_INTR_HIGH_MASK |
+			SIRFSOC_GPIO_CTL_INTR_LOW_MASK |
+			SIRFSOC_GPIO_CTL_INTR_TYPE_MASK;
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
-		val &= ~(SIRFSOC_GPIO_CTL_INTR_HIGH_MASK | SIRFSOC_GPIO_CTL_INTR_TYPE_MASK);
+		val &= ~(SIRFSOC_GPIO_CTL_INTR_HIGH_MASK |
+			SIRFSOC_GPIO_CTL_INTR_TYPE_MASK);
 		val |= SIRFSOC_GPIO_CTL_INTR_LOW_MASK;
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
 		val |= SIRFSOC_GPIO_CTL_INTR_HIGH_MASK;
-		val &= ~(SIRFSOC_GPIO_CTL_INTR_LOW_MASK | SIRFSOC_GPIO_CTL_INTR_TYPE_MASK);
+		val &= ~(SIRFSOC_GPIO_CTL_INTR_LOW_MASK |
+			SIRFSOC_GPIO_CTL_INTR_TYPE_MASK);
 		break;
 	}
 
@@ -694,7 +706,8 @@ static inline void sirfsoc_gpio_set_output(struct sirfsoc_gpio_chip *sgpio,
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-static int sirfsoc_gpio_direction_output(struct gpio_chip *chip, unsigned gpio, int value)
+static int sirfsoc_gpio_direction_output(struct gpio_chip *chip,
+	unsigned gpio, int value)
 {
 	struct sirfsoc_gpio_chip *sgpio = to_sirfsoc_gpio(chip);
 	struct sirfsoc_gpio_bank *bank = sirfsoc_gpio_to_bank(sgpio, gpio);
-- 
2.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
