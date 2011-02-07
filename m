From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon,  7 Feb 2011 02:51:58 +0100
Subject: [PATCH 06/09] ARM: s3c2440: gta02: Remove state_mem constraints for
	the pcf50633 regulators
In-Reply-To: <1297043521-21903-1-git-send-email-lars@metafoo.de>
References: <1297043521-21903-1-git-send-email-lars@metafoo.de>
Message-ID: <1297043521-21903-6-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pcf50633 regulator driver does not use the state_mem constraints, so there
is no use in setting them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/arm/mach-s3c2440/mach-gta02.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index e57c4d8..01e0930 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -283,9 +283,6 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
 				.always_on = 1,
 				.apply_uV = 1,
-				.state_mem = {
-					.enabled = 1,
-				},
 			},
 		},
 		[PCF50633_REGULATOR_DOWN1] = {
@@ -304,9 +301,6 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
 				.apply_uV = 1,
 				.always_on = 1,
-				.state_mem = {
-					.enabled = 1,
-				},
 			},
 		},
 		[PCF50633_REGULATOR_HCLDO] = {
@@ -325,9 +319,6 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
 				.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 				.apply_uV = 1,
-				.state_mem = {
-					.enabled = 0,
-				},
 			},
 		},
 		[PCF50633_REGULATOR_LDO2] = {
@@ -362,9 +353,6 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
 				.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 				.apply_uV = 1,
-				.state_mem = {
-					.enabled = 1,
-				},
 			},
 		},
 		[PCF50633_REGULATOR_LDO6] = {
@@ -379,9 +367,6 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
 				.min_uV = 1800000,
 				.max_uV = 1800000,
 				.valid_modes_mask = REGULATOR_MODE_NORMAL,
-				.state_mem = {
-					.enabled = 1,
-				},
 			},
 		},
 
-- 
1.7.2.3
