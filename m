From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:01:27 -0700
Subject: [PATCH 01/15] pinctrl: sunxi: Add const qualifier to the pin
 descriptor
In-Reply-To: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1398711701-11309-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pins description structure were declared as const, but the of_device_id
data magic was losing it silently.

Make sure we have it on both sides.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 2 +-
 drivers/pinctrl/pinctrl-sunxi.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index 07af35a127b2..0807963a2954 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -812,7 +812,7 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 	if (!device)
 		return -ENODEV;
 
-	pctl->desc = (struct sunxi_pinctrl_desc *)device->data;
+	pctl->desc = (const struct sunxi_pinctrl_desc *)device->data;
 
 	ret = sunxi_pinctrl_build_state(pdev);
 	if (ret) {
diff --git a/drivers/pinctrl/pinctrl-sunxi.h b/drivers/pinctrl/pinctrl-sunxi.h
index 35d15b229a70..90040accb11c 100644
--- a/drivers/pinctrl/pinctrl-sunxi.h
+++ b/drivers/pinctrl/pinctrl-sunxi.h
@@ -468,7 +468,7 @@ struct sunxi_pinctrl_group {
 struct sunxi_pinctrl {
 	void __iomem			*membase;
 	struct gpio_chip		*chip;
-	struct sunxi_pinctrl_desc	*desc;
+	const struct sunxi_pinctrl_desc	*desc;
 	struct device			*dev;
 	struct irq_domain		*domain;
 	struct sunxi_pinctrl_function	*functions;
-- 
1.9.1
