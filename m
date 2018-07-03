From: broonie@kernel.org (Mark Brown)
Date: Tue, 03 Jul 2018 16:33:55 +0100
Subject: Applied "ASoC: atmel-i2s: dt-bindings: Remove unnecessary phandle to
 aclk" to the asoc tree
In-Reply-To: <20180703145631.15246-3-codrin.ciubotariu@microchip.com>
Message-ID: <E1faNJT-0003di-5D@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: atmel-i2s: dt-bindings: Remove unnecessary phandle to aclk

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 2bd368d7bf21028f37a123041a138922254d4840 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Tue, 3 Jul 2018 17:56:31 +0300
Subject: [PATCH] ASoC: atmel-i2s: dt-bindings: Remove unnecessary phandle to
 aclk

The optional clock phandle to aclk (Audio PLL clock) is no longer needed
by the driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/atmel-i2s.txt | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/atmel-i2s.txt b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
index 735368b8a73f..40549f496a81 100644
--- a/Documentation/devicetree/bindings/sound/atmel-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/atmel-i2s.txt
@@ -15,7 +15,6 @@ Required properties:
 - clock-names:    Should be one of each entry matching the clocks phandles list:
                   - "pclk" (peripheral clock) Required.
                   - "gclk" (generated clock) Optional (1).
-                  - "aclk" (Audio PLL clock) Optional (1).
                   - "muxclk" (I2S mux clock) Optional (1).
 
 Optional properties:
@@ -23,9 +22,9 @@ Optional properties:
 - princtrl-names: Should contain only one value - "default".
 
 
-(1) : Only the peripheral clock is required. The generated clock, the Audio
-      PLL clock adn the I2S mux clock are optional and should only be set
-      together, when Master Mode is required.
+(1) : Only the peripheral clock is required. The generated clock and the I2S
+      mux clock are optional and should only be set together, when Master Mode
+      is required.
 
 Example:
 
@@ -40,8 +39,8 @@ Example:
 			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) |
 			 AT91_XDMAC_DT_PERID(32))>;
 		dma-names = "tx", "rx";
-		clocks = <&i2s0_clk>, <&i2s0_gclk>, <&audio_pll_pmc>, <&i2s0muxck>;
-		clock-names = "pclk", "gclk", "aclk", "muxclk";
+		clocks = <&i2s0_clk>, <&i2s0_gclk>, <&i2s0muxck>;
+		clock-names = "pclk", "gclk", "muxclk";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_i2s0_default>;
 	};
-- 
2.18.0.rc2
