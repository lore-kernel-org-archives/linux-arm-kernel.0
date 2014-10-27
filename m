From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Oct 2014 16:03:42 +0100
Subject: [PATCH 4/8] regulator: max77686: Make regulator_desc array const
In-Reply-To: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
References: <1414422226-10948-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414422226-10948-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The regulator_register() expects array of 'regulator_desc' to be const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/max77686.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
index 04af7a2b0910..7930b4f82c0b 100644
--- a/drivers/regulator/max77686.c
+++ b/drivers/regulator/max77686.c
@@ -395,7 +395,7 @@ static struct regulator_ops max77686_buck_dvs_ops = {
 			<< MAX77686_OPMODE_BUCK234_SHIFT,		\
 }
 
-static struct regulator_desc regulators[] = {
+static const struct regulator_desc regulators[] = {
 	regulator_desc_ldo1_low(1),
 	regulator_desc_ldo_low(2),
 	regulator_desc_ldo(3),
-- 
1.9.1
