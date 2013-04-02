From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Tue,  2 Apr 2013 10:51:56 +0200
Subject: [PATCH RESEND] ARM: ux500: update V-INTCORE constraints
In-Reply-To: <20130402084658.GD23065@opensource.wolfsonmicro.com>
References: <20130402084658.GD23065@opensource.wolfsonmicro.com>
Message-ID: <1364892716-25505-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update V-INTCORE regulator constraints to allow voltage and
configuration changes from consumer drivers.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-regulators.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 2a17bc5..0a428db 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -392,7 +392,15 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 	[AB8500_LDO_INTCORE] = {
 		.constraints = {
 			.name = "V-INTCORE",
-			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.min_uV = 1250000,
+			.max_uV = 1350000,
+			.input_uV = 1800000,
+			.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE |
+					  REGULATOR_CHANGE_STATUS |
+					  REGULATOR_CHANGE_MODE |
+					  REGULATOR_CHANGE_DRMS,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL |
+					    REGULATOR_MODE_IDLE,
 		},
 		.num_consumer_supplies = ARRAY_SIZE(ab8500_vintcore_consumers),
 		.consumer_supplies = ab8500_vintcore_consumers,
-- 
1.8.1.3
