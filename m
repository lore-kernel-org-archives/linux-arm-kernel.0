From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Jun 2011 13:12:01 +0100
Subject: [PATCH 2/2] ARM: Configure supplies for all Cragganmore regulators
In-Reply-To: <1308658321-25936-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1308658321-25936-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1308658321-25936-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the regulators on the system are supplied from the fixed wall supply.
While there's no functional value in telling the regulator core this it
does ensure that as a regulator maintainer I'll be exercising the supply
logic frequently.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index f01e440..a2c080e 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -367,6 +367,7 @@ static struct regulator_init_data vddarm __initdata = {
 	},
 	.num_consumer_supplies = ARRAY_SIZE(vddarm_consumers),
 	.consumer_supplies = vddarm_consumers,
+	.supply_regulator = "WALLVDD",
 };
 
 static struct regulator_init_data vddint __initdata = {
@@ -406,6 +407,7 @@ static struct regulator_init_data vddmmc __initdata = {
 	},
 	.num_consumer_supplies = ARRAY_SIZE(vddmmc_consumers),
 	.consumer_supplies = vddmmc_consumers,
+	.supply_regulator = "WALLVDD",
 };
 
 static struct regulator_init_data vddotgi __initdata = {
@@ -413,6 +415,7 @@ static struct regulator_init_data vddotgi __initdata = {
 		.name = "VDDOTGi",
 		.always_on = 1,
 	},
+	.supply_regulator = "WALLVDD",
 };
 
 static struct regulator_init_data vddotg __initdata = {
@@ -420,6 +423,7 @@ static struct regulator_init_data vddotg __initdata = {
 		.name = "VDDOTG",
 		.always_on = 1,
 	},
+	.supply_regulator = "WALLVDD",
 };
 
 static struct regulator_init_data vddhi __initdata = {
@@ -427,6 +431,7 @@ static struct regulator_init_data vddhi __initdata = {
 		.name = "VDDHI",
 		.always_on = 1,
 	},
+	.supply_regulator = "WALLVDD",
 };
 
 static struct regulator_init_data vddadc __initdata = {
@@ -434,6 +439,7 @@ static struct regulator_init_data vddadc __initdata = {
 		.name = "VDDADC,VDDDAC",
 		.always_on = 1,
 	},
+	.supply_regulator = "WALLVDD",
 };
 
 static struct regulator_init_data vddmem0 __initdata = {
@@ -441,6 +447,7 @@ static struct regulator_init_data vddmem0 __initdata = {
 		.name = "VDDMEM0",
 		.always_on = 1,
 	},
+	.supply_regulator = "WALLVDD",
 };
 
 static struct regulator_init_data vddpll __initdata = {
@@ -448,6 +455,7 @@ static struct regulator_init_data vddpll __initdata = {
 		.name = "VDDPLL",
 		.always_on = 1,
 	},
+	.supply_regulator = "WALLVDD",
 };
 
 static struct regulator_init_data vddlcd __initdata = {
@@ -455,6 +463,7 @@ static struct regulator_init_data vddlcd __initdata = {
 		.name = "VDDLCD",
 		.always_on = 1,
 	},
+	.supply_regulator = "WALLVDD",
 };
 
 static struct regulator_init_data vddalive __initdata = {
@@ -462,6 +471,7 @@ static struct regulator_init_data vddalive __initdata = {
 		.name = "VDDALIVE",
 		.always_on = 1,
 	},
+	.supply_regulator = "WALLVDD",
 };
 
 static struct wm831x_status_pdata banff_red_led __initdata = {
-- 
1.7.5.4
