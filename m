From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 22 May 2014 10:18:30 +0100
Subject: [PATCH] mfd: axp20x: Remove unnecessary const qualifier from
 axp20x_supplies[]
In-Reply-To: <1400750311-15323-1-git-send-email-lee.jones@linaro.org>
References: <1400750311-15323-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1400750311-15323-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/mfd/axp20x.c:159:3:
  warning: initialization discards ?const? qualifier from pointer target type
   .parent_supplies = axp20x_supplies,
   ^
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index dee6539..5734f8c 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -140,7 +140,7 @@ static const struct regmap_irq_chip axp20x_regmap_irq_chip = {
 	.init_ack_masked	= true,
 };
 
-static const char * const axp20x_supplies[] = {
+static const char * axp20x_supplies[] = {
 	"acin",
 	"vin2",
 	"vin3",
-- 
1.8.3.2
