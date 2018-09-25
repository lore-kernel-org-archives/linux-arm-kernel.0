From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 25 Sep 2018 11:03:08 +0200
Subject: [PATCH 10/14] ARM64: dts: hisilicon: Add interrupt names for the
 tsensors
In-Reply-To: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
References: <1537866192-12320-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1537866192-12320-11-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing interrupts for the temperature sensors as well as
their names.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt | 8 ++++++--
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi                       | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
index 3edfae3..4cb8add 100644
--- a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
@@ -29,7 +29,11 @@ for Hi3660:
 	tsensor: tsensor at fff30000 {
 		compatible = "hisilicon,hi3660-tsensor";
 		reg = <0x0 0xfff30000 0x0 0x1000>;
-		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "tsensor_a73";
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "tsensor_a73", "tsensor_a53",
+				  "tsensor_g3d", "tsensor_modem";
 		#thermal-sensor-cells = <1>;
 	};
diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index bf8a479..dd398cb 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1080,8 +1080,12 @@
 		tsensor: tsensor at fff30000 {
 			compatible = "hisilicon,hi3660-tsensor";
 			reg = <0x0 0xfff30000 0x0 0x1000>;
-			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "tsensor_a73";
+			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tsensor_a73", "tsensor_a53",
+			                  "tsensor_g3d", "tsensor_modem";
 			#thermal-sensor-cells = <1>;
 		};
 
-- 
2.7.4
