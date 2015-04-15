From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 15 Apr 2015 19:08:08 +0200
Subject: [PATCH] thermal: armada: Update Armada 380 thermal sensor coefficients
Message-ID: <1429117688-27100-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nadav Haklai <nadavh@marvell.com>

Improve the Armada 380 thermal sensor accuracy by using updated formula.
The updated formula is:
Temperature[C degrees] = 0.4761 * tsen_vsen_out - 279.1

Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: <stable@vger.kernel.org> #v3.16
---
 drivers/thermal/armada_thermal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2556cf5186b..01255fd65135 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -224,9 +224,9 @@ static const struct armada_thermal_data armada380_data = {
 	.is_valid_shift = 10,
 	.temp_shift = 0,
 	.temp_mask = 0x3ff,
-	.coef_b = 1169498786UL,
-	.coef_m = 2000000UL,
-	.coef_div = 4289,
+	.coef_b = 2931108200UL,
+	.coef_m = 5000000UL,
+	.coef_div = 10502,
 	.inverted = true,
 };
 
-- 
2.1.0
