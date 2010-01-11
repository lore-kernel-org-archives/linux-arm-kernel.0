From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 11 Jan 2010 22:04:12 +0800
Subject: [PATCH 04/16] [ARM] pxa: simplify the LCD pin configuration for
	pxa27x platforms
In-Reply-To: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
References: <1263218664-11546-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1263218664-11546-5-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/balloon3.c                |   21 +--------------------
 arch/arm/mach-pxa/cm-x270.c                 |   21 +--------------------
 arch/arm/mach-pxa/em-x270.c                 |   21 +--------------------
 arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |   27 +++++++++++++++++++++++++++
 arch/arm/mach-pxa/magician.c                |   21 +--------------------
 arch/arm/mach-pxa/mainstone.c               |   21 +--------------------
 arch/arm/mach-pxa/mioa701.c                 |   20 +-------------------
 arch/arm/mach-pxa/palmld.c                  |   21 +--------------------
 arch/arm/mach-pxa/palmt5.c                  |   21 +--------------------
 arch/arm/mach-pxa/palmtreo.c                |   20 +-------------------
 arch/arm/mach-pxa/palmtx.c                  |   21 +--------------------
 arch/arm/mach-pxa/palmz72.c                 |   22 ++--------------------
 arch/arm/mach-pxa/spitz.c                   |   20 +-------------------
 arch/arm/mach-pxa/trizeps4.c                |   21 +--------------------
 14 files changed, 41 insertions(+), 257 deletions(-)

diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index b8cd07c..6f813aa 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -140,26 +140,7 @@ static void balloon3_backlight_power(int on)
 
 static unsigned long balloon3_lcd_pin_config[] = {
 	/* LCD - 16bpp Active TFT */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 
 	GPIO99_GPIO,		/* Backlight */
 };
diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index eea78b6..425efbc 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -71,26 +71,7 @@ static unsigned long cmx270_pin_config[] = {
 	GPIO111_MMC_DAT_3,
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* I2C */
 	GPIO117_I2C_SCL,
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index c8a01bc..aab04f3 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -109,26 +109,7 @@ static unsigned long common_pin_config[] = {
 	GPIO111_MMC_DAT_3,
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* QCI */
 	GPIO84_CIF_FV,
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
index 6543c05..ec0f0b0 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
@@ -434,5 +434,32 @@
 #define GPIO112_nMSINS		MFP_CFG_IN(GPIO112, AF2)
 #define GPIO32_MSSCLK		MFP_CFG_OUT(GPIO32, AF1, DRIVE_LOW)
 
+/* commonly used pin configurations */
+#define GPIOxx_LCD_16BPP	\
+	GPIO58_LCD_LDD_0,	\
+	GPIO59_LCD_LDD_1,	\
+	GPIO60_LCD_LDD_2,	\
+	GPIO61_LCD_LDD_3,	\
+	GPIO62_LCD_LDD_4,	\
+	GPIO63_LCD_LDD_5,	\
+	GPIO64_LCD_LDD_6,	\
+	GPIO65_LCD_LDD_7,	\
+	GPIO66_LCD_LDD_8,	\
+	GPIO67_LCD_LDD_9,	\
+	GPIO68_LCD_LDD_10,	\
+	GPIO69_LCD_LDD_11,	\
+	GPIO70_LCD_LDD_12,	\
+	GPIO71_LCD_LDD_13,	\
+	GPIO72_LCD_LDD_14,	\
+	GPIO73_LCD_LDD_15
+
+#define GPIOxx_LCD_TFT_16BPP	\
+	GPIOxx_LCD_16BPP,	\
+	GPIO74_LCD_FCLK,	\
+	GPIO75_LCD_LCLK,	\
+	GPIO76_LCD_PCLK,	\
+	GPIO77_LCD_BIAS
+
+
 extern int keypad_set_wake(unsigned int on);
 #endif /* __ASM_ARCH_MFP_PXA27X_H */
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 8a38d60..cca1192 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -88,26 +88,7 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO112_MMC_CMD,
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* QCI */
 	GPIO12_CIF_DD_7,
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index a8674aa..3637039 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -60,26 +60,7 @@ static unsigned long mainstone_pin_config[] = {
 	GPIO15_nCS_1,
 
 	/* LCD - 16bpp Active TFT */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 	GPIO16_PWM0_OUT,	/* Backlight */
 
 	/* MMC */
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 2466a44..ca47ee1 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -86,25 +86,7 @@ static unsigned long mioa701_pin_config[] = {
 	MIO_CFG_OUT(GPIO22_USB_ENABLE, AF0, DRIVE_LOW),
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* QCI */
 	GPIO12_CIF_DD_7,
diff --git a/arch/arm/mach-pxa/palmld.c b/arch/arm/mach-pxa/palmld.c
index 5914021..18981f8 100644
--- a/arch/arm/mach-pxa/palmld.c
+++ b/arch/arm/mach-pxa/palmld.c
@@ -83,26 +83,7 @@ static unsigned long palmld_pin_config[] __initdata = {
 	GPIO105_KP_MKOUT_2,
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* PWM */
 	GPIO16_PWM0_OUT,
diff --git a/arch/arm/mach-pxa/palmt5.c b/arch/arm/mach-pxa/palmt5.c
index 7f89ca2..4ec71ac 100644
--- a/arch/arm/mach-pxa/palmt5.c
+++ b/arch/arm/mach-pxa/palmt5.c
@@ -87,26 +87,7 @@ static unsigned long palmt5_pin_config[] __initdata = {
 	GPIO105_KP_MKOUT_2,
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* PWM */
 	GPIO16_PWM0_OUT,
diff --git a/arch/arm/mach-pxa/palmtreo.c b/arch/arm/mach-pxa/palmtreo.c
index 606eb7e..e7c82ca 100644
--- a/arch/arm/mach-pxa/palmtreo.c
+++ b/arch/arm/mach-pxa/palmtreo.c
@@ -99,25 +99,7 @@ static unsigned long treo_pin_config[] __initdata = {
 	GPIO93_KP_DKIN_0 | WAKEUP_ON_LEVEL_HIGH,	/* Hotsync button */
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* Quick Capture Interface */
 	GPIO84_CIF_FV,
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 7bf18c2..c40a3bf 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -110,26 +110,7 @@ static unsigned long palmtx_pin_config[] __initdata = {
 	GPIO105_KP_MKOUT_2,
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* FFUART */
 	GPIO34_FFUART_RXD,
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index d787ac7..beb4eea 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -95,26 +95,8 @@ static unsigned long palmz72_pin_config[] __initdata = {
 	GPIO105_KP_MKOUT_2,
 
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
+
 	GPIO20_GPIO,	/* bl power */
 	GPIO21_GPIO,	/* LCD border switch */
 	GPIO22_GPIO,	/* LCD border color */
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 4b50f14..6d9c472 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -56,25 +56,7 @@ static unsigned long spitz_pin_config[] __initdata = {
 	GPIO80_nCS_4,	/* SCOOP #1 */
 
 	/* LCD - 16bpp Active TFT */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* PC Card */
 	GPIO48_nPOE,
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 0aa858e..4416008 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -73,26 +73,7 @@ static unsigned long trizeps4_pin_config[] __initdata = {
 	GPIO0_GPIO | WAKEUP_ON_EDGE_RISE,	/* Logic irq */
 
 	/* LCD - 16bpp Active TFT */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 
 	/* UART */
 	GPIO9_FFUART_CTS,
-- 
1.6.3.3
