From: zhiyong.tao@mediatek.com (Zhiyong Tao)
Date: Mon, 11 Jul 2016 11:09:55 +0800
Subject: [PATCH v3 1/2] dt-bindings: auxadc: Add binding document for Mediatek
 auxadc.
In-Reply-To: <1468206596-13792-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1468206596-13792-1-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <1468206596-13792-2-git-send-email-zhiyong.tao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit adds the device tree binding documentation for the mediatek
auxadc found on Mediatek MT2701.
Thermal gets auxadc sample data by iio device.
So the commit changes auxadc device tree binding documentation from
/soc/mediatek/auxadc.txt to /iio/adc/mt65xx_auxadc.txt.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 .../devicetree/bindings/iio/adc/mt65xx_auxadc.txt  |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt b/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
index 47fcd1b..bc23792 100644
--- a/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/mt65xx_auxadc.txt
@@ -14,11 +14,11 @@ Required properties:
   - reg: Address range of the AUXADC unit.
   - clocks: Should contain a clock specifier for each entry in clock-names
   - clock-names: Should contain "main".
-  - io-channel-cells: Should be 1, see ../iio-bindings.txt
+  - #io-channel-cells: Should be 1, see ../iio-bindings.txt
 
 Example:
 
-auxadc: auxadc at 11001000 {
+auxadc: adc at 11001000 {
 	compatible = "mediatek,mt2701-auxadc";
 	reg = <0 0x11001000 0 0x1000>;
 	clocks = <&pericfg CLK_PERI_AUXADC>;
-- 
1.7.9.5
