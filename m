From: broonie@kernel.org (Mark Brown)
Date: Thu, 09 Feb 2017 23:46:24 +0000
Subject: Applied "ASoC: zx-i2s: Add the info of pclk to the binding document
 for zx2967 family" to the asoc tree
In-Reply-To: <1486609978-18482-2-git-send-email-baoyou.xie@linaro.org>
Message-ID: <E1cbyPw-0004Dw-6f@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: zx-i2s: Add the info of pclk to the binding document for zx2967 family

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b5f18ba89391da7a92605dc76822580d13e2ef74 Mon Sep 17 00:00:00 2001
From: Baoyou Xie <baoyou.xie@linaro.org>
Date: Thu, 9 Feb 2017 11:12:57 +0800
Subject: [PATCH] ASoC: zx-i2s: Add the info of pclk to the binding document
 for zx2967 family

ZTE's zx2967 I2S controller driver introduces pclk, this
patch documents this fact.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
index 7e5aa6f6b5a1..292ad5083704 100644
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
2.11.0
