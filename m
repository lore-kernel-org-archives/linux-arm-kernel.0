From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Fri,  6 Nov 2015 09:38:10 +0800
Subject: [PATCH v3 2/3] Documentation: DT bindings: rockchip-i2s: add capture
 property
In-Reply-To: <1446773891-32174-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1446773891-32174-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1446773891-32174-3-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rockchip,capture-channels: max capture channels, 2 channels default.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

Changes in v3:
- move property into the Optional properties section

Changes in v2:
- remove unused lrck property

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 9b82c20..ace3b1e 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -22,6 +22,10 @@ Required properties:
    - "i2s_hclk": clock for I2S BUS
    - "i2s_clk" : clock for I2S controller
 
+Optional properties:
+
+- rockchip,capture-channels: max capture channels, if not set, 2 channels default.
+
 Example for rk3288 I2S controller:
 
 i2s at ff890000 {
@@ -34,4 +38,5 @@ i2s at ff890000 {
 	dma-names = "tx", "rx";
 	clock-names = "i2s_hclk", "i2s_clk";
 	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+	rockchip,capture-channels = <2>;
 };
-- 
2.3.6
