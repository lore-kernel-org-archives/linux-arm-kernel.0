From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 17 Feb 2012 11:23:49 +0800
Subject: [PATCH 1/2] ARM: U300: Don't specify regulator consumers by struct
 device
Message-ID: <1329449029.17110.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dev field is remove from struct regulator_consumer_supply since commit
737f36 "regulator: Remove support for supplies specified by struct device".

This fixes below build error:
  CC      arch/arm/mach-u300/i2c.o
arch/arm/mach-u300/i2c.c:63: error: unknown field 'dev' specified in initializer
arch/arm/mach-u300/i2c.c:95: error: unknown field 'dev' specified in initializer
make[1]: *** [arch/arm/mach-u300/i2c.o] Error 1
make: *** [arch/arm/mach-u300] Error 2

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
This patch is against linux-next 20120217.

 arch/arm/mach-u300/i2c.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-u300/i2c.c b/arch/arm/mach-u300/i2c.c
index 5140dee..a38f802 100644
--- a/arch/arm/mach-u300/i2c.c
+++ b/arch/arm/mach-u300/i2c.c
@@ -60,7 +60,6 @@ static struct regulator_consumer_supply supply_ldo_c[] = {
  */
 static struct regulator_consumer_supply supply_ldo_d[] = {
 	{
-		.dev = NULL,
 		.supply = "vana15", /* Powers the SoC (CPU etc) */
 	},
 };
@@ -92,7 +91,6 @@ static struct regulator_consumer_supply supply_ldo_k[] = {
  */
 static struct regulator_consumer_supply supply_ldo_ext[] = {
 	{
-		.dev = NULL,
 		.supply = "vext", /* External power */
 	},
 };
-- 
1.7.5.4
