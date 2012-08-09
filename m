From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu,  9 Aug 2012 19:05:49 +0100
Subject: [PATCH 2/2] ARM: S3C64XX: Register audio platform devices for Bells
 on Cragganmore
In-Reply-To: <1344535549-4371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1344535549-4371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1344535549-4371-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index ab8dbbe4..4103ed3 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -287,6 +287,16 @@ static struct platform_device littlemill_device = {
 	.id		= -1,
 };
 
+static struct platform_device bells_wm5102_device = {
+	.name		= "bells",
+	.id		= 0,
+};
+
+static struct platform_device bells_wm5110_device = {
+	.name		= "bells",
+	.id		= 1,
+};
+
 static struct regulator_consumer_supply wallvdd_consumers[] = {
 	REGULATOR_SUPPLY("SPKVDD", "1-001a"),
 	REGULATOR_SUPPLY("SPKVDD1", "1-001a"),
@@ -359,6 +369,8 @@ static struct platform_device *crag6410_devices[] __initdata = {
 	&tobermory_device,
 	&littlemill_device,
 	&lowland_device,
+	&bells_wm5102_device,
+	&bells_wm5110_device,
 	&wallvdd_device,
 };
 
-- 
1.7.10.4
