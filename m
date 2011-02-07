From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon,  7 Feb 2011 02:51:57 +0100
Subject: [PATCH 05/09] ARM: s3c2440: gta02: Fix regulator valid_modes_ops
In-Reply-To: <1297043521-21903-1-git-send-email-lars@metafoo.de>
References: <1297043521-21903-1-git-send-email-lars@metafoo.de>
Message-ID: <1297043521-21903-5-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The REGULATOR_CHANGE_STATUS flag needs to be set on valid_ops_mask, otherwise it
a driver wont be able to turn the regulator on or off.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/arm/mach-s3c2440/mach-gta02.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 6629998..e57c4d8 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -314,8 +314,8 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
 				.min_uV = 2000000,
 				.max_uV = 3300000,
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
-				.always_on = 1,
+				.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+						REGULATOR_CHANGE_STATUS,
 			},
 		},
 		[PCF50633_REGULATOR_LDO1] = {
@@ -323,6 +323,7 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
 				.min_uV = 3300000,
 				.max_uV = 3300000,
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
+				.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 				.apply_uV = 1,
 				.state_mem = {
 					.enabled = 0,
@@ -350,6 +351,7 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
 				.min_uV = 3200000,
 				.max_uV = 3200000,
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
+				.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 				.apply_uV = 1,
 			},
 		},
@@ -358,6 +360,7 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
 				.min_uV = 3000000,
 				.max_uV = 3000000,
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
+				.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 				.apply_uV = 1,
 				.state_mem = {
 					.enabled = 1,
-- 
1.7.2.3
