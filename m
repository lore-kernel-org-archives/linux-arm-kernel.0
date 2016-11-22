From: broonie@kernel.org (Mark Brown)
Date: Tue, 22 Nov 2016 19:13:48 +0000
Subject: Applied "ASoC: sunxi: Add bindings for A23/A33/H3 codec's analog path
 controls" to the asoc tree
In-Reply-To: <20161112064648.26779-2-wens@csie.org>
Message-ID: <E1c9GVo-0000Kk-Ru@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sunxi: Add bindings for A23/A33/H3 codec's analog path controls

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

>From 837e71847aefd82c903ee0bb2ff2589e70b0808f Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 12 Nov 2016 14:46:39 +0800
Subject: [PATCH] ASoC: sunxi: Add bindings for A23/A33/H3 codec's analog path
 controls

The internal codec on A23/A33/H3 is split into 2 parts. The
analog path controls are routed through an embedded custom register
bus accessed through the PRCM block.

The SoCs share a common set of inputs, outputs, and audio paths.
The following table lists the differences.

    ----------------------------------------
    | Feature \ SoC |  A23  |  A33  |  H3  |
    ----------------------------------------
    | Headphone     |   v   |   v   |      |
    ----------------------------------------
    | Line Out      |       |       |  v   |
    ----------------------------------------
    | Phone In/Out  |   v   |   v   |      |
    ----------------------------------------

Add a binding for this hardware.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/sun8i-codec-analog.txt     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt

diff --git a/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
new file mode 100644
index 000000000000..779b735781ba
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt
@@ -0,0 +1,16 @@
+* Allwinner Codec Analog Controls
+
+Required properties:
+- compatible: must be one of the following compatibles:
+		- "allwinner,sun8i-a23-codec-analog"
+		- "allwinner,sun8i-h3-codec-analog"
+
+Required properties if not a sub-node of the PRCM node:
+- reg: must contain the registers location and length
+
+Example:
+prcm: prcm at 01f01400 {
+	codec_analog: codec-analog {
+		compatible = "allwinner,sun8i-a23-codec-analog";
+	};
+};
-- 
2.10.2
