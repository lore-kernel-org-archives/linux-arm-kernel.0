From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  7 Sep 2012 14:18:13 +0200
Subject: [PATCH 4/7] gpio: 74x164: Add device tree support
In-Reply-To: <1347020296-18796-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1347020296-18796-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1347020296-18796-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Florian Fainelli <florian@openwrt.org>
Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-74x164.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
index ef8baac..2e31bd3 100644
--- a/drivers/gpio/gpio-74x164.c
+++ b/drivers/gpio/gpio-74x164.c
@@ -148,10 +148,17 @@ static int __devexit gen_74x164_remove(struct spi_device *spi)
 	return ret;
 }
 
+static const struct of_device_id gen_74x164_dt_ids[] = {
+	{ .compatible = "fairchild,74hc595" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gen_74x164_dt_ids);
+
 static struct spi_driver gen_74x164_driver = {
 	.driver = {
 		.name		= "74x164",
 		.owner		= THIS_MODULE,
+		.of_match_table	= of_match_ptr(gen_74x164_dt_ids),
 	},
 	.probe		= gen_74x164_probe,
 	.remove		= __devexit_p(gen_74x164_remove),
-- 
1.7.9.5
