From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Nov 2018 14:14:22 +0000 (GMT)
Subject: Applied "ASoC: dt-bindings: sun50i-codec-analog: Add headphone amp
 regulator supply" to the asoc tree
In-Reply-To: <20181122102325.29495-2-wens@csie.org>
Message-ID: <20181123141422.73C16440078@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: dt-bindings: sun50i-codec-analog: Add headphone amp regulator supply

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

>From 21dd30200e3d350fe420d23a2a00b17633a3d1a2 Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 22 Nov 2018 18:23:18 +0800
Subject: [PATCH] ASoC: dt-bindings: sun50i-codec-analog: Add headphone amp
 regulator supply

On the Allwinner A64 SoC, the audio codec has a built-in headphone
amplifier. This amplifier has a power supply separate from the rest of
the analog audio circuitry.

Add a regulator supply property to handle this.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
index 4f8ad0e04d20..056a098495cc 100644
--- a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
+++ b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
@@ -4,9 +4,11 @@ Required properties:
 - compatible: must be one of the following compatibles:
 		- "allwinner,sun50i-a64-codec-analog"
 - reg: must contain the registers location and length
+- cpvdd-supply: Regulator supply for the headphone amplifier
 
 Example:
 	codec_analog: codec-analog at 1f015c0 {
 		compatible = "allwinner,sun50i-a64-codec-analog";
 		reg = <0x01f015c0 0x4>;
+		cpvdd-supply = <&reg_eldo1>;
 	};
-- 
2.19.1
