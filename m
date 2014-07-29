From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 29 Jul 2014 09:24:44 +0200
Subject: [PATCH 2/4] gpio: pca953x: Add DT binding documentation
In-Reply-To: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
References: <1406618686-22385-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1406618686-22385-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a devicetree binding documentation for the pca953x driver.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 .../devicetree/bindings/gpio/gpio-pca953x.txt      | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-pca953x.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
new file mode 100644
index 000000000000..b9a42f294dd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca953x.txt
@@ -0,0 +1,39 @@
+* NXP PCA953x I2C GPIO multiplexer
+
+Required properties:
+ - compatible: Has to contain one of the following:
+	nxp,pca9505
+	nxp,pca9534
+	nxp,pca9535
+	nxp,pca9536
+	nxp,pca9537
+	nxp,pca9538
+	nxp,pca9539
+	nxp,pca9554
+	nxp,pca9555
+	nxp,pca9556
+	nxp,pca9557
+	nxp,pca9574
+	nxp,pca9575
+	nxp,pca9698
+	maxim,max7310
+	maxim,max7312
+	maxim,max7313
+	maxim,max7315
+	ti,pca6107
+	ti,tca6408
+	ti,tca6416
+	ti,tca6424
+	exar,xra1202
+
+Example:
+
+
+	gpio at 20 {
+		compatible = "nxp,pca9505";
+		reg = <0x20>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pca9505>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+	};
-- 
2.0.1
