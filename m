From: rask@formelder.dk (Rask Ingemann Lambertsen)
Date: Sat, 21 Jan 2017 17:11:43 +0100
Subject: [PATCH] regulator: axp20x: AXP806: Fix dcdcb being set instead of
 dcdce
Message-ID: <20170121161142.g4zslhohb6vvcvwd@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A typo or copy-paste bug means that the register access intended for
regulator dcdce goes to dcdcb instead. This patch corrects it.

Signed-off-by: Rask Ingemann Lambertsen <rask@formelder.dk>
Fixes: 2ca342d391e3 (regulator: axp20x: Support AXP806 variant)
---

I have a board where dcdcb powers the DRAM, which I found running at 2.05 V
rather than 1.50 V. The bug was introduced nearly five months ago. Thanks
must go to Samsung for making DRAM chips which tolerate that sort of abuse.

 drivers/regulator/axp20x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index e6a512e..a3ade9e 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -272,7 +272,7 @@ static const struct regulator_desc axp806_regulators[] = {
 			64, AXP806_DCDCD_V_CTRL, 0x3f, AXP806_PWR_OUT_CTRL1,
 			BIT(3)),
 	AXP_DESC(AXP806, DCDCE, "dcdce", "vine", 1100, 3400, 100,
-		 AXP806_DCDCB_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL1, BIT(4)),
+		 AXP806_DCDCE_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL1, BIT(4)),
 	AXP_DESC(AXP806, ALDO1, "aldo1", "aldoin", 700, 3300, 100,
 		 AXP806_ALDO1_V_CTRL, 0x1f, AXP806_PWR_OUT_CTRL1, BIT(5)),
 	AXP_DESC(AXP806, ALDO2, "aldo2", "aldoin", 700, 3400, 100,
-- 
2.10.2

-- 
Rask Ingemann Lambertsen
