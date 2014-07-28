From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 28 Jul 2014 14:24:37 +0300
Subject: [PATCH 1/2] ARM: davinci: board-da850-evm: Mark dcdc2 of TPS65070 as
 always_on
Message-ID: <1406546678-797-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DCDC2 should not be turned off since it is powering the CPU among other
things.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-davinci/board-da850-evm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 234c5bb091f5..77d8968336df 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -936,6 +936,7 @@ static struct regulator_init_data tps65070_regulator_data[] = {
 			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
 				REGULATOR_CHANGE_STATUS),
 			.boot_on = 1,
+			.always_on = 1,
 		},
 		.num_consumer_supplies = ARRAY_SIZE(tps65070_dcdc2_consumers),
 		.consumer_supplies = tps65070_dcdc2_consumers,
-- 
2.0.2
