From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 31 Mar 2012 17:44:53 +0100
Subject: [PATCH] ARM: ux300: Fix unimplementable regulation constraints
Message-ID: <1333212293-6287-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't make sense to grant permission to change the status of a
regulator that is also set as always on and similarly it doesn't make
sense to allow a driver to change the voltage of a regulator which can
only be set to a single voltage.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-u300/i2c.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-u300/i2c.c b/arch/arm/mach-u300/i2c.c
index a38f802..cb04bd6 100644
--- a/arch/arm/mach-u300/i2c.c
+++ b/arch/arm/mach-u300/i2c.c
@@ -146,9 +146,6 @@ static struct ab3100_platform_data ab3100_plf_data = {
 				.min_uV = 1800000,
 				.max_uV = 1800000,
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.valid_ops_mask =
-				REGULATOR_CHANGE_VOLTAGE |
-				REGULATOR_CHANGE_STATUS,
 				.always_on = 1,
 				.boot_on = 1,
 			},
@@ -160,9 +157,6 @@ static struct ab3100_platform_data ab3100_plf_data = {
 				.min_uV = 2500000,
 				.max_uV = 2500000,
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.valid_ops_mask =
-				REGULATOR_CHANGE_VOLTAGE |
-				REGULATOR_CHANGE_STATUS,
 				.always_on = 1,
 				.boot_on = 1,
 			},
@@ -230,8 +224,7 @@ static struct ab3100_platform_data ab3100_plf_data = {
 				.max_uV = 1800000,
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
 				.valid_ops_mask =
-				REGULATOR_CHANGE_VOLTAGE |
-				REGULATOR_CHANGE_STATUS,
+				REGULATOR_CHANGE_VOLTAGE,
 				.always_on = 1,
 				.boot_on = 1,
 			},
-- 
1.7.9.1
