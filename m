From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Tue, 10 Nov 2015 15:32:08 +0800
Subject: [PATCH 2/3] ASoC: rockchip: add playback property
In-Reply-To: <1447140729-18267-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1447140729-18267-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1447140729-18267-3-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rockchip,playback-channels: max playback channels, 8 channels default.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 2267d24..b7f3a93 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -19,6 +19,7 @@ Required properties:
 - clock-names: should contain followings:
    - "i2s_hclk": clock for I2S BUS
    - "i2s_clk" : clock for I2S controller
+- rockchip,playback-channels: max playback channels, if not set, 8 channels default.
 - rockchip,capture-channels: max capture channels, if not set, 2 channels default.
 
 Example for rk3288 I2S controller:
@@ -31,5 +32,6 @@ i2s at ff890000 {
 	dma-names = "tx", "rx";
 	clock-names = "i2s_hclk", "i2s_clk";
 	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+	rockchip,playback-channels = <8>;
 	rockchip,capture-channels = <2>;
 };
-- 
2.3.6
