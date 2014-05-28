From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 28 May 2014 14:56:05 +0530
Subject: [PATCH 2/2] ARM: ux500: Staticize ab8505_regulators
In-Reply-To: <1401269165-2996-1-git-send-email-sachin.kamat@linaro.org>
References: <1401269165-2996-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1401269165-2996-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'ab8505_regulators' is used only in this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index a4e139aa2441..32d744e91ec2 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -796,7 +796,7 @@ static struct ab8500_regulator_reg_init ab8505_reg_init[] = {
 	INIT_REGULATOR_REGISTER(AB8505_CTRLVAUX6,              0x00, 0x00),
 };
 
-struct regulator_init_data ab8505_regulators[AB8505_NUM_REGULATORS] = {
+static struct regulator_init_data ab8505_regulators[AB8505_NUM_REGULATORS] = {
 	/* supplies to the display/camera */
 	[AB8505_LDO_AUX1] = {
 		.constraints = {
-- 
1.7.9.5
