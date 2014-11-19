From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Wed, 19 Nov 2014 11:06:04 +0800
Subject: [PATCH 1/2] ASoC: rockchip-i2s: dt: add i2s_clkout to list of clocks
In-Reply-To: <1416366365-4632-1-git-send-email-jay.xu@rock-chips.com>
References: <1416366365-4632-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1416366365-4632-2-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add i2s_clkout property, which enables output clock to chip outside,
this is generally for audio codec outside.

Also add it to example.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 9b82c20..3d23b15 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -21,6 +21,7 @@ Required properties:
 - clock-names: should contain followings:
    - "i2s_hclk": clock for I2S BUS
    - "i2s_clk" : clock for I2S controller
+   - "i2s_clko" : clock for codec outside of chip
 
 Example for rk3288 I2S controller:
 
@@ -32,6 +33,6 @@ i2s at ff890000 {
 	#size-cells = <0>;
 	dmas = <&pdma1 0>, <&pdma1 1>;
 	dma-names = "tx", "rx";
-	clock-names = "i2s_hclk", "i2s_clk";
-	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+	clock-names = "i2s_hclk", "i2s_clk", "i2s_clko";
+	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>, <&cru SCLK_I2S0_CLKOUT>;
 };
-- 
1.9.1
