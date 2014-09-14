From: jay.xu@rock-chips.com (Jianqun)
Date: Sun, 14 Sep 2014 11:39:59 +0800
Subject: [PATCH v2] ASoC: rockchip-i2s: dt: fix an error in the example
In-Reply-To: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com>
References: <1410570281-23681-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <1410665999-16718-1-git-send-email-jay.xu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reference to RK3288 TRM, fix an error in the example by swap "tx" and "rx".

Table 10-1 DMAC_BUS Request Mapping Table
Req number	Source	Polarity
0		I2S tx	High level
1		I2S rx	High level

Tested on RK3288 board.

Signed-off-by: Jianqun <jay.xu@rock-chips.com>
---
change since v1:
- modify patch's changelog as Mark's suggestion

 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 6c55fcf..9b82c20 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -31,7 +31,7 @@ i2s at ff890000 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	dmas = <&pdma1 0>, <&pdma1 1>;
-	dma-names = "rx", "tx";
+	dma-names = "tx", "rx";
 	clock-names = "i2s_hclk", "i2s_clk";
 	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
 };
-- 
1.9.1
