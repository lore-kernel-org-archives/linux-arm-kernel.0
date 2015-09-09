From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Wed,  9 Sep 2015 14:30:45 +0200
Subject: [PATCH v3 1/9] ARM: dts: imx6dql-nitrogen6x: add touchscreen support
In-Reply-To: <1441801853-10264-1-git-send-email-gary.bisson@boundarydevices.com>
References: <1441645069-27263-1-git-send-email-gary.bisson@boundarydevices.com>
 <1441801853-10264-1-git-send-email-gary.bisson@boundarydevices.com>
Message-ID: <1441801853-10264-2-git-send-email-gary.bisson@boundarydevices.com>
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
index 340bc8e..5466368 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -247,6 +247,21 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
+
+	touchscreen at 04 {
+		compatible = "eeti,egalax_ts";
+		reg = <0x04>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
+	};
+
+	touchscreen at 38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+	};
 };
 
 &iomuxc {
@@ -258,6 +273,7 @@
 			fsl,pins = <
 				/* SGTL5000 sys_mclk */
 				MX6QDL_PAD_GPIO_0__CCM_CLKO1    0x030b0
+				MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0
 			>;
 		};
 
-- 
2.5.1
