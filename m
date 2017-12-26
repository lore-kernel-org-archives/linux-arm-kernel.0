From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 26 Dec 2017 12:07:13 +0530
Subject: [PATCH 10/11 v2] ARM: s3c24xx/s3c64xx: constify gpio_led
In-Reply-To: <2b8dd58f9d6dae7f0fa04694e8147524be9300ea.1514267721.git.arvind.yadav.cs@gmail.com>
References: <2b8dd58f9d6dae7f0fa04694e8147524be9300ea.1514267721.git.arvind.yadav.cs@gmail.com>
Message-ID: <adb77ba31b66d391a49a12434dfe7811e8a8ba0f.1514267721.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
              The GPIO LED driver can be built as a module, it can
              be loaded after the init sections have gone away.
              So removed '__initconst'.

 arch/arm/mach-s3c24xx/mach-h1940.c    | 2 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c   | 2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c      | 2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c  | 2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c  | 2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-h1940.c b/arch/arm/mach-s3c24xx/mach-h1940.c
index 7ed7861..6a3e0e6 100644
--- a/arch/arm/mach-s3c24xx/mach-h1940.c
+++ b/arch/arm/mach-s3c24xx/mach-h1940.c
@@ -413,7 +413,7 @@ int h1940_led_blink_set(struct gpio_desc *desc, int state,
 }
 EXPORT_SYMBOL(h1940_led_blink_set);
 
-static struct gpio_led h1940_leds_desc[] = {
+static const struct gpio_led h1940_leds_desc[] = {
 	{
 		.name			= "Green",
 		.default_trigger	= "main-battery-full",
diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index e86ad6a..97bb6a5 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -295,7 +295,7 @@ static int rx1950_led_blink_set(struct gpio_desc *desc, int state,
 	return 0;
 }
 
-static struct gpio_led rx1950_leds_desc[] = {
+static const struct gpio_led rx1950_leds_desc[] = {
 	{
 		.name			= "Green",
 		.default_trigger	= "main-battery-full",
diff --git a/arch/arm/mach-s3c64xx/mach-hmt.c b/arch/arm/mach-s3c64xx/mach-hmt.c
index 59b5531..f8d644f 100644
--- a/arch/arm/mach-s3c64xx/mach-hmt.c
+++ b/arch/arm/mach-s3c64xx/mach-hmt.c
@@ -207,7 +207,7 @@ static struct s3c2410_platform_nand hmt_nand_info = {
 	.ecc_mode       = NAND_ECC_SOFT,
 };
 
-static struct gpio_led hmt_leds[] = {
+static const struct gpio_led hmt_leds[] = {
 	{ /* left function keys */
 		.name			= "left:blue",
 		.gpio			= S3C64XX_GPO(12),
diff --git a/arch/arm/mach-s3c64xx/mach-smartq5.c b/arch/arm/mach-s3c64xx/mach-smartq5.c
index 0972b6c..5a7cd8f 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq5.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq5.c
@@ -35,7 +35,7 @@
 #include "common.h"
 #include "mach-smartq.h"
 
-static struct gpio_led smartq5_leds[] = {
+static const struct gpio_led smartq5_leds[] = {
 	{
 		.name			= "smartq5:green",
 		.active_low		= 1,
diff --git a/arch/arm/mach-s3c64xx/mach-smartq7.c b/arch/arm/mach-s3c64xx/mach-smartq7.c
index 51ac1c6..9de9fc2 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq7.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq7.c
@@ -35,7 +35,7 @@
 #include "common.h"
 #include "mach-smartq.h"
 
-static struct gpio_led smartq7_leds[] = {
+static const struct gpio_led smartq7_leds[] = {
 	{
 		.name			= "smartq7:red",
 		.active_low		= 1,
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 92ec8c3..be9d98f 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -497,7 +497,7 @@ static struct wm8350_platform_data __initdata smdk6410_wm8350_pdata = {
 #endif
 
 #ifdef CONFIG_SMDK6410_WM1192_EV1
-static struct gpio_led wm1192_pmic_leds[] = {
+static const struct gpio_led wm1192_pmic_leds[] = {
 	{
 		.name = "PMIC:red:power",
 		.gpio = GPIO_BOARD_START + 3,
-- 
2.7.4
