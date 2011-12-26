From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Dec 2011 10:58:46 +0000
Subject: [PATCH] ARM: S3C64XX: Reduce residency requirement for cpuidle WFI
 mode
Message-ID: <1324897126-8889-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Entering and leaving WFI is really cheap so there's no reason to have much
of a residency requirement for the state. Lower it to 1ms.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c64xx/cpuidle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
index 625d2c7..179460f 100644
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ b/arch/arm/mach-s3c64xx/cpuidle.c
@@ -55,7 +55,7 @@ static struct cpuidle_state s3c64xx_cpuidle_set[] = {
 	[0] = {
 		.enter			= s3c64xx_enter_idle,
 		.exit_latency		= 1,
-		.target_residency	= 100000,
+		.target_residency	= 1,
 		.flags			= CPUIDLE_FLAG_TIME_VALID,
 		.name			= "IDLE",
 		.desc			= "System active, ARM gated",
-- 
1.7.7.3
