From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  2 Apr 2012 12:35:19 +0100
Subject: [PATCH] ARM: S3C64XX: Hook up new style regulator-regulator supplies
 on Cragganmore
Message-ID: <1333366519-7900-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator API now allows supplies used by regulators to be specified
as normal supplies - provide the hookup for that mechanism on Cragganmore.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 02fd009..4ee0249 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -306,6 +306,24 @@ static struct regulator_consumer_supply wallvdd_consumers[] = {
 	REGULATOR_SUPPLY("SPKVDD2", "1-001a"),
 	REGULATOR_SUPPLY("SPKVDDL", "1-001a"),
 	REGULATOR_SUPPLY("SPKVDDR", "1-001a"),
+
+	REGULATOR_SUPPLY("DC1VDD", "0-0034"),
+	REGULATOR_SUPPLY("DC2VDD", "0-0034"),
+	REGULATOR_SUPPLY("DC3VDD", "0-0034"),
+	REGULATOR_SUPPLY("LDO1VDD", "0-0034"),
+	REGULATOR_SUPPLY("LDO2VDD", "0-0034"),
+	REGULATOR_SUPPLY("LDO4VDD", "0-0034"),
+	REGULATOR_SUPPLY("LDO5VDD", "0-0034"),
+	REGULATOR_SUPPLY("LDO6VDD", "0-0034"),
+	REGULATOR_SUPPLY("LDO7VDD", "0-0034"),
+	REGULATOR_SUPPLY("LDO8VDD", "0-0034"),
+	REGULATOR_SUPPLY("LDO9VDD", "0-0034"),
+	REGULATOR_SUPPLY("LDO10VDD", "0-0034"),
+	REGULATOR_SUPPLY("LDO11VDD", "0-0034"),
+
+	REGULATOR_SUPPLY("DC1VDD", "1-0034"),
+	REGULATOR_SUPPLY("DC2VDD", "1-0034"),
+	REGULATOR_SUPPLY("DC3VDD", "1-0034"),
 };
 
 static struct regulator_init_data wallvdd_data = {
-- 
1.7.9.1
