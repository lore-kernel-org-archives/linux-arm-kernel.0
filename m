From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Mon,  1 Apr 2013 23:04:04 +0300
Subject: [PATCH] ARM: OMAP: RX-51: add missing regulator supply definitions
 for lis3lv02d
Message-ID: <1364846644-5302-1-git-send-email-aaro.koskinen@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing regulator definitions for lis3lv02d accelerometer. Fixes
the following probe issue:

[   57.737518] lis3lv02d_i2c 3-001d: Failed to get supply 'Vdd': -517
[   57.747100] i2c 3-001d: Driver lis3lv02d_i2c requests probe deferral

Reported-by: Pali Roh?r <pali.rohar@gmail.com>
Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---

	The patch was discussed in this thread...

		http://marc.info/?t=136105842400001&r=1&w=2

	...and now sending it to relevant mailing lists.

 arch/arm/mach-omap2/board-rx51-peripherals.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 3a077df..1a88467 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -547,12 +547,16 @@ static struct regulator_consumer_supply rx51_vio_supplies[] = {
 	REGULATOR_SUPPLY("DVDD", "2-0019"),
 	/* Si4713 IO supply */
 	REGULATOR_SUPPLY("vio", "2-0063"),
+	/* lis3lv02d */
+	REGULATOR_SUPPLY("Vdd_IO", "3-001d"),
 };
 
 static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
 	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
 	/* Si4713 supply */
 	REGULATOR_SUPPLY("vdd", "2-0063"),
+	/* lis3lv02d */
+	REGULATOR_SUPPLY("Vdd", "3-001d"),
 };
 
 static struct regulator_init_data rx51_vaux1 = {
-- 
1.7.10.4
