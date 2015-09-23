From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Wed, 23 Sep 2015 11:41:23 +0800
Subject: [PATCH 2/2] Documentation: DT bindings: rockchip-i2s: add capture and
 lrck-mode
In-Reply-To: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1442979683-9441-3-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rockchip,capture-channels: max capture channels, 2 channels default.
rockchip,lrck-mode: 0: rxtx separate, 1: tx share, 2: rx share.
default use 'rxtx separate' mode.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 9b82c20..4066b85 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -21,6 +21,9 @@ Required properties:
 - clock-names: should contain followings:
    - "i2s_hclk": clock for I2S BUS
    - "i2s_clk" : clock for I2S controller
+- rockchip,capture-channels: max capture channels, if not set, 2 channels default.
+- rockchip,lrck-mode: select lrck use mode: 0: rxtx separate, 1: tx share, 2: rx share.
+  default use 'rxtx seprate' mode.
 
 Example for rk3288 I2S controller:
 
@@ -34,4 +37,6 @@ i2s at ff890000 {
 	dma-names = "tx", "rx";
 	clock-names = "i2s_hclk", "i2s_clk";
 	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+	rockchip,capture-channels = <2>;
+	rockchip,lrck-mode = <0>;
 };
-- 
2.3.6
