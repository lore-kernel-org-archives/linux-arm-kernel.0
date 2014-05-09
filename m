From: ipaton0@gmail.com (Iain Paton)
Date: Fri, 09 May 2014 16:01:56 +0100
Subject: [PATCH v3 1/2] ARM: dts: imx6: i2c4 cleanup
In-Reply-To: <20140509142118.GQ2794@dragon>
References: <53695C34.5000604@gmail.com> <20140508054106.GH2794@dragon>
 <536B4ACD.30001@gmail.com> <20140509030938.GK2794@dragon>
 <536C8837.9090802@gmail.com> <20140509120845.GO2794@dragon>
 <536CE331.7030001@gmail.com> <20140509142118.GQ2794@dragon>
Message-ID: <536CEDE4.40002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add missing i2c4 clock and correct the compatible string to match other
imx6 i2c blocks

Signed-off-by: Iain Paton<ipaton0@gmail.com>
---
 arch/arm/boot/dts/imx6dl.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 5c5f574..0a9c49d 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -84,9 +84,10 @@
 			i2c4: i2c at 021f8000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fsl,imx1-i2c";
+				compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
 				reg = <0x021f8000 0x4000>;
 				interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks 116>;
 				status = "disabled";
 			};
 		};
-- 
1.8.5.1
