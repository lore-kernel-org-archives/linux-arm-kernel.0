From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 15 Jan 2016 21:49:49 +0800
Subject: [PATCH v3 2/9] ARM: dts: rockchip: add i2s_clk_out to list of clocks
 used on rk3036 i2s
In-Reply-To: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1452865796-23527-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The I2S block that it needs to claim that output clock. This also
adds properties to model the relationship between the output clock and
the i2s clock itself, to ensure that the clock muxing is set correctly.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

Changes in v3: None

 arch/arm/boot/dts/rk3036.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 0b128be..cf0968c 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -277,8 +277,8 @@
 		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-		clock-names = "i2s_clk", "i2s_hclk";
-		clocks = <&cru SCLK_I2S>, <&cru HCLK_I2S>;
+		clock-names = "i2s_clk", "i2s_hclk", "i2s_clk_out";
+		clocks = <&cru SCLK_I2S>, <&cru HCLK_I2S>, <&cru SCLK_I2S_OUT>;
 		dmas = <&pdma 0>, <&pdma 1>;
 		dma-names = "tx", "rx";
 		pinctrl-names = "default";
-- 
1.9.1
