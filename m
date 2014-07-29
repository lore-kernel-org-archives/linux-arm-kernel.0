From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Jul 2014 09:24:45 +0200
Subject: [PATCH 3/4] gpio: pca953x: Add pca9506 as DT compatible
In-Reply-To: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
References: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1406618686-22385-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver can also be used for the nxp,pca9506 device.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/gpio/gpio-pca953x.txt | 1 +
 drivers/gpio/gpio-pca953x.c                             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
index b9a42f294dd0..eb65157d47f6 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
@@ -3,6 +3,7 @@
 Required properties:
  - compatible: Has to contain one of the following:
 	nxp,pca9505
+	nxp,pca9506
 	nxp,pca9534
 	nxp,pca9535
 	nxp,pca9536
diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index fda3eae835d0..df5eb6e6be1e 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -729,6 +729,7 @@ static int pca953x_remove(struct i2c_client *client)
 
 static const struct of_device_id pca953x_dt_ids[] = {
 	{ .compatible = "nxp,pca9505", },
+	{ .compatible = "nxp,pca9506", },
 	{ .compatible = "nxp,pca9534", },
 	{ .compatible = "nxp,pca9535", },
 	{ .compatible = "nxp,pca9536", },
-- 
2.0.1
