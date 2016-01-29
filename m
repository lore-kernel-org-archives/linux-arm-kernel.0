From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 15:50:37 +0100
Subject: [PATCH 5/6] ARM: s3c64xx: mark regulator init data as unused
In-Reply-To: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
References: <1454079040-3567945-1-git-send-email-arnd@arndb.de>
Message-ID: <1454079040-3567945-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smdk6410 board defines lots of regulator settings, but uses
most of them only in certain configurations, and otherwise leaves
them without any references, so we get lots of randconfig warnings
about them:

mach-s3c64xx/mach-smdk6410.c:303:35: error: 'smdk6410_vddarm' defined but not used [-Werror=unused-variable]
mach-s3c64xx/mach-smdk6410.c:316:35: error: 'smdk6410_vddint' defined but not used [-Werror=unused-variable]
mach-s3c64xx/mach-smdk6410.c:327:35: error: 'smdk6410_vddhi' defined but not used [-Werror=unused-variable]
mach-s3c64xx/mach-smdk6410.c:335:35: error: 'smdk6410_vddpll' defined but not used [-Werror=unused-variable]
mach-s3c64xx/mach-smdk6410.c:343:35: error: 'smdk6410_vdduh_mmc' defined but not used [-Werror=unused-variable]

This marks all regulator_init_data structures in this file as
__maybe_unused, indicating that we don't care whether there
are any references or not in a given configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c64xx/mach-smdk6410.c | 38 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 8a894ee3ee76..92ec8c3b42b9 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -216,7 +216,7 @@ static struct regulator_consumer_supply smdk6410_b_pwr_5v_consumers[] = {
 	REGULATOR_SUPPLY("AVDD", "0-001b"),
 };
 
-static struct regulator_init_data smdk6410_b_pwr_5v_data = {
+static struct regulator_init_data __maybe_unused smdk6410_b_pwr_5v_data = {
 	.constraints = {
 		.always_on = 1,
 	},
@@ -300,7 +300,7 @@ static struct regulator_consumer_supply smdk6410_vddarm_consumers[] = {
 };
 
 /* VDDARM, BUCK1 on J5 */
-static struct regulator_init_data smdk6410_vddarm = {
+static struct regulator_init_data __maybe_unused smdk6410_vddarm = {
 	.constraints = {
 		.name = "PVDD_ARM",
 		.min_uV = 1000000,
@@ -313,7 +313,7 @@ static struct regulator_init_data smdk6410_vddarm = {
 };
 
 /* VDD_INT, BUCK2 on J5 */
-static struct regulator_init_data smdk6410_vddint = {
+static struct regulator_init_data __maybe_unused smdk6410_vddint = {
 	.constraints = {
 		.name = "PVDD_INT",
 		.min_uV = 1000000,
@@ -324,7 +324,7 @@ static struct regulator_init_data smdk6410_vddint = {
 };
 
 /* VDD_HI, LDO3 on J5 */
-static struct regulator_init_data smdk6410_vddhi = {
+static struct regulator_init_data __maybe_unused smdk6410_vddhi = {
 	.constraints = {
 		.name = "PVDD_HI",
 		.always_on = 1,
@@ -332,7 +332,7 @@ static struct regulator_init_data smdk6410_vddhi = {
 };
 
 /* VDD_PLL, LDO2 on J5 */
-static struct regulator_init_data smdk6410_vddpll = {
+static struct regulator_init_data __maybe_unused smdk6410_vddpll = {
 	.constraints = {
 		.name = "PVDD_PLL",
 		.always_on = 1,
@@ -340,7 +340,7 @@ static struct regulator_init_data smdk6410_vddpll = {
 };
 
 /* VDD_UH_MMC, LDO5 on J5 */
-static struct regulator_init_data smdk6410_vdduh_mmc = {
+static struct regulator_init_data __maybe_unused smdk6410_vdduh_mmc = {
 	.constraints = {
 		.name = "PVDD_UH+PVDD_MMC",
 		.always_on = 1,
@@ -348,7 +348,7 @@ static struct regulator_init_data smdk6410_vdduh_mmc = {
 };
 
 /* VCCM3BT, LDO8 on J5 */
-static struct regulator_init_data smdk6410_vccmc3bt = {
+static struct regulator_init_data __maybe_unused smdk6410_vccmc3bt = {
 	.constraints = {
 		.name = "PVCCM3BT",
 		.always_on = 1,
@@ -356,7 +356,7 @@ static struct regulator_init_data smdk6410_vccmc3bt = {
 };
 
 /* VCCM2MTV, LDO11 on J5 */
-static struct regulator_init_data smdk6410_vccm2mtv = {
+static struct regulator_init_data __maybe_unused smdk6410_vccm2mtv = {
 	.constraints = {
 		.name = "PVCCM2MTV",
 		.always_on = 1,
@@ -364,7 +364,7 @@ static struct regulator_init_data smdk6410_vccm2mtv = {
 };
 
 /* VDD_LCD, LDO12 on J5 */
-static struct regulator_init_data smdk6410_vddlcd = {
+static struct regulator_init_data __maybe_unused smdk6410_vddlcd = {
 	.constraints = {
 		.name = "PVDD_LCD",
 		.always_on = 1,
@@ -372,7 +372,7 @@ static struct regulator_init_data smdk6410_vddlcd = {
 };
 
 /* VDD_OTGI, LDO9 on J5 */
-static struct regulator_init_data smdk6410_vddotgi = {
+static struct regulator_init_data __maybe_unused smdk6410_vddotgi = {
 	.constraints = {
 		.name = "PVDD_OTGI",
 		.always_on = 1,
@@ -380,7 +380,7 @@ static struct regulator_init_data smdk6410_vddotgi = {
 };
 
 /* VDD_OTG, LDO14 on J5 */
-static struct regulator_init_data smdk6410_vddotg = {
+static struct regulator_init_data __maybe_unused smdk6410_vddotg = {
 	.constraints = {
 		.name = "PVDD_OTG",
 		.always_on = 1,
@@ -388,7 +388,7 @@ static struct regulator_init_data smdk6410_vddotg = {
 };
 
 /* VDD_ALIVE, LDO15 on J5 */
-static struct regulator_init_data smdk6410_vddalive = {
+static struct regulator_init_data __maybe_unused smdk6410_vddalive = {
 	.constraints = {
 		.name = "PVDD_ALIVE",
 		.always_on = 1,
@@ -396,7 +396,7 @@ static struct regulator_init_data smdk6410_vddalive = {
 };
 
 /* VDD_AUDIO, VLDO_AUDIO on J5 */
-static struct regulator_init_data smdk6410_vddaudio = {
+static struct regulator_init_data __maybe_unused smdk6410_vddaudio = {
 	.constraints = {
 		.name = "PVDD_AUDIO",
 		.always_on = 1,
@@ -406,7 +406,7 @@ static struct regulator_init_data smdk6410_vddaudio = {
 
 #ifdef CONFIG_SMDK6410_WM1190_EV1
 /* S3C64xx internal logic & PLL */
-static struct regulator_init_data wm8350_dcdc1_data = {
+static struct regulator_init_data __maybe_unused wm8350_dcdc1_data = {
 	.constraints = {
 		.name = "PVDD_INT+PVDD_PLL",
 		.min_uV = 1200000,
@@ -417,7 +417,7 @@ static struct regulator_init_data wm8350_dcdc1_data = {
 };
 
 /* Memory */
-static struct regulator_init_data wm8350_dcdc3_data = {
+static struct regulator_init_data __maybe_unused wm8350_dcdc3_data = {
 	.constraints = {
 		.name = "PVDD_MEM",
 		.min_uV = 1800000,
@@ -437,7 +437,7 @@ static struct regulator_consumer_supply wm8350_dcdc4_consumers[] = {
 	REGULATOR_SUPPLY("DVDD", "0-001b"),
 };
 
-static struct regulator_init_data wm8350_dcdc4_data = {
+static struct regulator_init_data __maybe_unused wm8350_dcdc4_data = {
 	.constraints = {
 		.name = "PVDD_HI+PVDD_EXT+PVDD_SYS+PVCCM2MTV",
 		.min_uV = 3000000,
@@ -449,7 +449,7 @@ static struct regulator_init_data wm8350_dcdc4_data = {
 };
 
 /* OTGi/1190-EV1 HPVDD & AVDD */
-static struct regulator_init_data wm8350_ldo4_data = {
+static struct regulator_init_data __maybe_unused wm8350_ldo4_data = {
 	.constraints = {
 		.name = "PVDD_OTGI+HPVDD+AVDD",
 		.min_uV = 1200000,
@@ -537,7 +537,7 @@ static struct wm831x_backlight_pdata wm1192_backlight_pdata = {
 	.max_uA = 27554,
 };
 
-static struct regulator_init_data wm1192_dcdc3 = {
+static struct regulator_init_data __maybe_unused wm1192_dcdc3 = {
 	.constraints = {
 		.name = "PVDD_MEM+PVDD_GPS",
 		.always_on = 1,
@@ -548,7 +548,7 @@ static struct regulator_consumer_supply wm1192_ldo1_consumers[] = {
 	REGULATOR_SUPPLY("DVDD", "0-001b"),   /* WM8580 */
 };
 
-static struct regulator_init_data wm1192_ldo1 = {
+static struct regulator_init_data __maybe_unused wm1192_ldo1 = {
 	.constraints = {
 		.name = "PVDD_LCD+PVDD_EXT",
 		.always_on = 1,
-- 
2.7.0
