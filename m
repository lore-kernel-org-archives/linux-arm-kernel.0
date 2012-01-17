From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Jan 2012 15:07:46 +0000
Subject: [PATCH] ARM: S3C64XX: Add a SPKVDD supply for CODECs on Cragganmore
Message-ID: <1326812866-27271-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up a SPKVDD supply for CODECs that can use it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 202f724..d5a7982 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -300,6 +300,7 @@ static struct platform_device littlemill_device = {
 };
 
 static struct regulator_consumer_supply wallvdd_consumers[] = {
+	REGULATOR_SUPPLY("SPKVDD", "1-001a"),
 	REGULATOR_SUPPLY("SPKVDD1", "1-001a"),
 	REGULATOR_SUPPLY("SPKVDD2", "1-001a"),
 	REGULATOR_SUPPLY("SPKVDDL", "1-001a"),
-- 
1.7.7.3
