From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Oct 2014 16:06:43 +0100
Subject: [PATCH v2 5/8] regulator: max77686: Initialize opmode explicitly to
 normal mode
In-Reply-To: <1414595206-1437-1-git-send-email-k.kozlowski@samsung.com>
References: <1414595206-1437-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414595206-1437-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor nit: Initialize the opmode for each regulator to normal mode in a
readable explicit way.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Suggested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/regulator/max77686.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
index 7ec9b4e5b917..5497e10b9659 100644
--- a/drivers/regulator/max77686.c
+++ b/drivers/regulator/max77686.c
@@ -497,8 +497,8 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 		config.init_data = rdata[i].init_data;
 		config.of_node = rdata[i].of_node;
 
-		max77686->opmode[id] = regulators[i].enable_mask >>
-						max77686_get_opmode_shift(id);
+		max77686->opmode[id] = MAX77686_NORMAL;
+
 		rdev = devm_regulator_register(&pdev->dev,
 						&regulators[i], &config);
 		if (IS_ERR(rdev)) {
-- 
1.9.1
