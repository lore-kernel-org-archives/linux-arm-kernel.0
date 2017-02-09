From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Thu,  9 Feb 2017 11:12:57 +0800
Subject: [PATCH v4 2/3] ASoC: zx-i2s: Add the info of pclk to the binding
 document for zx2967 family
In-Reply-To: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
References: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <1486609978-18482-2-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ZTE's zx2967 I2S controller driver introduces pclk, this
patch documents this fact.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
index 7e5aa6f..292ad50 100644
--- a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
@@ -1,10 +1,12 @@
 ZTE ZX296702 I2S controller
 
 Required properties:
- - compatible : Must be "zte,zx296702-i2s"
+ - compatible : Must be one of:
+	"zte,zx296718-i2s", "zte,zx296702-i2s"
+	"zte,zx296702-i2s"
  - reg : Must contain I2S core's registers location and length
  - clocks : Pairs of phandle and specifier referencing the controller's clocks.
- - clock-names: "tx" for the clock to the I2S interface.
+ - clock-names: "wclk" for the wclk, "pclk" for the pclk to the I2S interface.
  - dmas: Pairs of phandle and specifier for the DMA channel that is used by
    the core. The core expects two dma channels for transmit.
  - dma-names : Must be "tx" and "rx"
@@ -16,12 +18,12 @@ please check:
 	* dma/dma.txt
 
 Example:
-	i2s0: i2s0 at 0b005000 {
+	i2s0: i2s at b005000 {
 		#sound-dai-cells = <0>;
-		compatible = "zte,zx296702-i2s";
+		compatible = "zte,zx296718-i2s", "zte,zx296702-i2s";
 		reg = <0x0b005000 0x1000>;
-		clocks = <&lsp0clk ZX296702_I2S0_DIV>;
-		clock-names = "tx";
+		clocks = <&audiocrm AUDIO_I2S0_WCLK>, <&audiocrm AUDIO_I2S0_PCLK>;
+		clock-names = "wclk", "pclk";
 		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 		dmas = <&dma 5>, <&dma 6>;
 		dma-names = "tx", "rx";
-- 
2.7.4
