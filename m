From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Mon,  7 Sep 2015 18:57:46 +0200
Subject: [PATCH 1/4] ARM: dts: imx6dql-nitrogen6x: add touchscreen support
In-Reply-To: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1441645069-27263-2-git-send-email-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the different touchscreens that can be connected using
the displays available for this board.
http://boundarydevices.com/product-category/displays/

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index ad16dce..ec9da5e 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -284,6 +284,22 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
+
+	egalax_ts at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 2>;
+		wakeup-gpios = <&gpio1 9 0>;
+	};
+
+	ft5x06_ts at 38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 2>;
+		wakeup-gpios = <&gpio1 9 0>;
+	};
 };
 
 &iomuxc {
-- 
2.5.1
