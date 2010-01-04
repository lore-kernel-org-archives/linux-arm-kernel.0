From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon,  4 Jan 2010 18:24:50 +0000
Subject: [PATCH 2/3] mx31ads: Allow enable/disable of switchable supplies
In-Reply-To: <1262629491-18942-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1262629491-18942-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1262629491-18942-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They will be automatically powered off at startup so users will
need to enable them for use.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-mx3/mx31ads.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31ads.c b/arch/arm/mach-mx3/mx31ads.c
index cda570b..718fbe6 100644
--- a/arch/arm/mach-mx3/mx31ads.c
+++ b/arch/arm/mach-mx3/mx31ads.c
@@ -302,6 +302,7 @@ static struct regulator_init_data ldo1_data = {
 		.min_uV = 2800000,
 		.max_uV = 2800000,
 		.valid_modes_mask = REGULATOR_MODE_NORMAL,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		.apply_uV = 1,
 	},
 };
@@ -318,6 +319,7 @@ static struct regulator_init_data ldo2_data = {
 		.min_uV = 3300000,
 		.max_uV = 3300000,
 		.valid_modes_mask = REGULATOR_MODE_NORMAL,
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		.apply_uV = 1,
 	},
 	.num_consumer_supplies = ARRAY_SIZE(ldo2_consumers),
-- 
1.6.5.7
