From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Wed, 27 Aug 2014 07:41:43 +0800
Subject: [PATCH v2 2/2] dt-bindings: document Rockchip thermal
In-Reply-To: <1409096503-7081-1-git-send-email-caesar.wang@rock-chips.com>
References: <1409096503-7081-1-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <1409096503-7081-3-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add the necessary binding documentation for the thermal
found on Rockchip SoCs

Signed-off-by: zhaoyifeng <zyf@rock-chips.com>
Signed-off-by: Caesar Wang <caesar.wang@rock-chips.com>

Change-Id: I822eba808c76ab51a5562eb61020a4aed4ff555e
---
 .../bindings/thermal/rockchip-thermal.txt          |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
new file mode 100644
index 0000000..ff8db39
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
@@ -0,0 +1,20 @@
+* Temperature Sensor ADC (TSADC) on rockchip SoCs
+
+Required properties:
+- compatible : "rockchip,rk3288-tsadc"
+- reg : physical base address of the controller and length of memory mapped
+  region.
+- interrupts : The interrupt number to the cpu. The interrupt specifier format
+  depends on the interrupt controller.
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : Shall be "tsadc_clk" for the transfer-clock, and "tsadc_pclk" for
+    the peripheral clock.
+
+Example:
+tsadc: tsadc at ff280000 {
+	compatible = "rockchip,rk3288-tsadc";
+	reg = <0xff280000 0x100>;
+	interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&cru SCLK_TSADC>, <&cru PCLK_TSADC>;
+	clock-names = "tsadc_clk", "tsadc_pclk";
+};
-- 
1.7.9.5
