From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 18:04:44 +0200
Subject: [PATCH 2/9] pinctrl: dt-bindings: add documentation for AP806 pin
 controllers
In-Reply-To: <cover.0dd8a92ae74fcec8d0470d0a7016035089e46eed.1495209664.git-series.gregory.clement@free-electrons.com>
References: <cover.0dd8a92ae74fcec8d0470d0a7016035089e46eed.1495209664.git-series.gregory.clement@free-electrons.com>
Message-ID: <bfd5b618a295f98a056784d7486dbd128d36fefb.1495209664.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device tree binding for the pin controllers found on the
Armada 7K and Armada 8K SoCs.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt | 53 ++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
index 888c50e0d64f..4228d158fb31 100644
--- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
@@ -28,14 +28,53 @@ Required properties:
  - compatible: must be: "marvell,ap806-clock"
  - #clock-cells: must be set to 1
 
+Pinctrl:
+--------
+
+For common binding part and usage, refer to
+Documentation/devicetree/bindings/pinctrl/marvell,mvebu-pinctrl.txt.
+
+Required properties:
+- compatible must be "marvell,ap806-pinctrl",
+
+Available mpp pins/groups and functions:
+Note: brackets (x) are not part of the mpp name for marvell,function and given
+only for more detailed description in this document.
+
+name	pins	functions
+================================================================================
+mpp0	0	gpio, sdio(clk), spi0(clk)
+mpp1	1	gpio, sdio(cmd), spi0(miso)
+mpp2	2	gpio, sdio(d0), spi0(mosi)
+mpp3	3	gpio, sdio(d1), spi0(cs0n)
+mpp4	4	gpio, sdio(d2), i2c0(sda)
+mpp5	5	gpio, sdio(d3), i2c0(sdk)
+mpp6	6	gpio, sdio(ds)
+mpp7	7	gpio, sdio(d4), uart1(rxd)
+mpp8	8	gpio, sdio(d5), uart1(txd)
+mpp9	9	gpio, sdio(d6), spi0(cs1n)
+mpp10	10	gpio, sdio(d7)
+mpp11	11	gpio, uart0(txd)
+mpp12	12	gpio, sdio(pw_off), sdio(hw_rst)
+mpp13	13	gpio
+mpp14	14	gpio
+mpp15	15	gpio
+mpp16	16	gpio
+mpp17	17	gpio
+mpp18	18	gpio
+mpp19	19	gpio, uart0(rxd), sdio(pw_off)
+
 Example:
+ap_syscon: system-controller at 6f4000 {
+	compatible = "syscon", "simple-mfd";
+	reg = <0x6f4000 0x1000>;
 
-	syscon: system-controller at 6f4000 {
-		compatible = "syscon", "simple-mfd";
-		reg = <0x6f4000 0x1000>;
+	ap_clk: clock {
+		compatible = "marvell,ap806-clock";
+		#clock-cells = <1>;
+	};
 
-		ap_clk: clock {
-			compatible = "marvell,ap806-clock";
-			#clock-cells = <1>;
-		};
+	ap_pinctrl: pinctrl {
+		compatible = "marvell,ap806-pinctrl";
 	};
+};
-- 
git-series 0.9.1
