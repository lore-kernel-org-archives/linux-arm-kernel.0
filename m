From: kevin.wangtao@hisilicon.com (Tao Wang)
Date: Fri, 22 Sep 2017 17:42:10 +0800
Subject: [PATCH 7/9] dt-bindings: Document the hi3660 thermal sensor binding
In-Reply-To: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
References: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
Message-ID: <1506073332-92438-8-git-send-email-kevin.wangtao@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wangtao <kevin.wangtao@linaro.org>

This adds documentation of device tree bindings for the
thermal sensor controller of hi3660 SoC.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
---
 Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
index d48fc52..cef716a 100644
--- a/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
@@ -13,6 +13,7 @@
 
 Example :
 
+for Hi6220:
 	tsensor: tsensor at 0,f7030700 {
 		compatible = "hisilicon,tsensor";
 		reg = <0x0 0xf7030700 0x0 0x1000>;
@@ -21,3 +22,11 @@ Example :
 		clock-names = "thermal_clk";
 		#thermal-sensor-cells = <1>;
 	}
+
+for Hi3660:
+	tsensor: tsensor at fff30000 {
+		compatible = "hisilicon,hi3660-tsensor";
+		reg = <0x0 0xfff30000 0x0 0x1000>;
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+		#thermal-sensor-cells = <1>;
+	};
-- 
2.8.1
