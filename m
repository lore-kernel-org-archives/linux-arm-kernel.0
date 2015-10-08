From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Thu,  8 Oct 2015 20:40:08 +0800
Subject: [PATCH v2 2/3] Documentation: DT bindings: rockchip-i2s: add capture
 property
In-Reply-To: <1444308009-29088-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1444308009-29088-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1444308009-29088-3-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rockchip,capture-channels: max capture channels, 2 channels default.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

Changes in v2:
- remove unused lrck property

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 9b82c20..925dd52 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -21,6 +21,7 @@ Required properties:
 - clock-names: should contain followings:
    - "i2s_hclk": clock for I2S BUS
    - "i2s_clk" : clock for I2S controller
+- rockchip,capture-channels: max capture channels, if not set, 2 channels default.
 
 Example for rk3288 I2S controller:
 
@@ -34,4 +35,5 @@ i2s at ff890000 {
 	dma-names = "tx", "rx";
 	clock-names = "i2s_hclk", "i2s_clk";
 	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+	rockchip,capture-channels = <2>;
 };
-- 
2.3.6
