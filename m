From: lost.distance@yahoo.com (Paul Parsons)
Date: Fri, 15 Apr 2011 14:39:27 +0000
Subject: [PATCH] pxa/hx4700: bq24022 regulator needs to be enabled
Message-ID: <E1QAkBF-0003bF-A0@outmx04.plus.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add REGULATOR_CHANGE_STATUS flag to hx4700 bq24022 regulator. Without this flag the bq24022 cannot be enabled and the battery will not charge.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---
--- clean-2.6.38/arch/arm/mach-pxa/hx4700.c	2011-03-15 01:20:32.000000000 +0000
+++ linux-2.6.38/arch/arm/mach-pxa/hx4700.c	2011-04-15 04:39:04.869989025 +0100
@@ -711,7 +711,7 @@ static struct regulator_consumer_supply 
 static struct regulator_init_data bq24022_init_data = {
 	.constraints = {
 		.max_uA         = 500000,
-		.valid_ops_mask = REGULATOR_CHANGE_CURRENT,
+		.valid_ops_mask = REGULATOR_CHANGE_CURRENT|REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies  = ARRAY_SIZE(bq24022_consumers),
 	.consumer_supplies      = bq24022_consumers,
