From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Wed,  3 Dec 2014 15:18:37 +0800
Subject: [PATCH v2 1/2] ASoC: dt-bindings: rockchip-i2s: add an optional
 property "i2s_clk_out"
In-Reply-To: <1417591118-18695-1-git-send-email-jay.xu@rock-chips.com>
References: <1417531766-29669-1-git-send-email-jay.xu@rock-chips.com>
 <1417591118-18695-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1417591118-18695-2-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an property "i2s_clk_out", which enables to output clock to outside
of rockchip SoCs. Let's make it optional since not each board needs it.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 9b82c20..c8f5ac0 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -22,6 +22,10 @@ Required properties:
    - "i2s_hclk": clock for I2S BUS
    - "i2s_clk" : clock for I2S controller
 
+Optional property:
+- "i2s_clk_out" : clock output to outside of chip, usally as master clock for audio
+	codec chip
+
 Example for rk3288 I2S controller:
 
 i2s at ff890000 {
@@ -32,6 +36,6 @@ i2s at ff890000 {
 	#size-cells = <0>;
 	dmas = <&pdma1 0>, <&pdma1 1>;
 	dma-names = "tx", "rx";
-	clock-names = "i2s_hclk", "i2s_clk";
-	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+	clock-names = "i2s_hclk", "i2s_clk", "i2s_clk_out";
+	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>, <&cru SCLK_I2S0_CLKOUT>;
 };
-- 
1.9.1
