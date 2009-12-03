From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 3 Dec 2009 20:30:34 +0100
Subject: [PATCH] mx31moboard: fix typo
Message-ID: <20091203193034.GD22533@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, linux-next breaks due to a typo introduced in commit
33c4d91928bea4444b067e620496befbeb87029c

This patch fixes it.

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
Cc: Valentin Longchamp <valentin.longchamp@epfl.ch>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mx3/mx31moboard.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31moboard.c b/arch/arm/mach-mx3/mx31moboard.c
index 1ec679a..b705291 100644
--- a/arch/arm/mach-mx3/mx31moboard.c
+++ b/arch/arm/mach-mx3/mx31moboard.c
@@ -226,7 +226,7 @@ static struct mc13783_regulator_init_data moboard_regulators[] = {
 static struct mc13783_platform_data moboard_pmic = {
 	.regulators = moboard_regulators,
 	.num_regulators = ARRAY_SIZE(moboard_regulators),
-	.flags = MC13783_USE_REGULATOR | MC13783_USE_RTC,
+	.flags = MC13783_USE_REGULATOR | MC13783_USE_RTC |
 		MC13783_USE_ADC,
 };
 
-- 
1.5.6.5
