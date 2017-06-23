From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 Jun 2017 13:04:25 +0100
Subject: Applied "ASoC: add bindings for ZTE zx-aud96p22 audio codec" to the
 asoc tree
In-Reply-To: <1498114318-32077-2-git-send-email-shawnguo@kernel.org>
Message-ID: <E1dONK5-0006Sf-Lk@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: add bindings for ZTE zx-aud96p22 audio codec

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

>From 7de35c122e2dd8dc4d74b3782ced9c03115dc268 Mon Sep 17 00:00:00 2001
From: Baoyou Xie <baoyou.xie@linaro.org>
Date: Thu, 22 Jun 2017 14:51:57 +0800
Subject: [PATCH] ASoC: add bindings for ZTE zx-aud96p22 audio codec

It adds dt-bindings document for ZTE zx-aud96p22 audio codec.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/zte,zx-aud96p22.txt  | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt b/Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt
new file mode 100644
index 000000000000..41bb1040eb71
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/zte,zx-aud96p22.txt
@@ -0,0 +1,24 @@
+ZTE ZX AUD96P22 Audio Codec
+
+Required properties:
+ - compatible: Must be "zte,zx-aud96p22"
+ - #sound-dai-cells: Should be 0
+ - reg: I2C bus slave address of AUD96P22
+
+Example:
+
+	i2c0: i2c at 1486000 {
+		compatible = "zte,zx296718-i2c";
+		reg = <0x01486000 0x1000>;
+		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clocks = <&audiocrm AUDIO_I2C0_WCLK>;
+		clock-frequency = <1600000>;
+
+		aud96p22: codec at 22 {
+			compatible = "zte,zx-aud96p22";
+			#sound-dai-cells = <0>;
+			reg = <0x22>;
+		};
+	};
-- 
2.13.1
