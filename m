From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 12 Dec 2013 14:31:38 +0100
Subject: [PATCH 3/3] ARM: ux500: regulators: Remove dead code for SD-card
 regulator
In-Reply-To: <1386855098-14272-1-git-send-email-ulf.hansson@linaro.org>
References: <1386855098-14272-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1386855098-14272-4-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The signal-voltage regulator is handled through a gpio regulator
configured in DT. Remove the old dead code.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 0dc44c6..a4e139a 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -30,20 +30,6 @@ struct regulator_init_data gpio_en_3v3_regulator = {
        .consumer_supplies = gpio_en_3v3_consumers,
 };
 
-static struct regulator_consumer_supply sdi0_reg_consumers[] = {
-        REGULATOR_SUPPLY("vqmmc", "sdi0"),
-};
-
-struct regulator_init_data sdi0_reg_init_data = {
-        .constraints = {
-                .min_uV         = 1800000,
-                .max_uV         = 2900000,
-                .valid_ops_mask = REGULATOR_CHANGE_VOLTAGE|REGULATOR_CHANGE_STATUS,
-        },
-        .num_consumer_supplies  = ARRAY_SIZE(sdi0_reg_consumers),
-        .consumer_supplies      = sdi0_reg_consumers,
-};
-
 /*
  * TPS61052 regulator
  */
-- 
1.7.9.5
