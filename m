From: broonie@kernel.org (Mark Brown)
Date: Mon, 13 Feb 2017 18:53:54 +0000
Subject: Applied "ASoC: sun4i-i2s: Update binding documentation to include
 A31" to the asoc tree
In-Reply-To: <20170202092422.5588-2-mylene.josserand@free-electrons.com>
Message-ID: <E1cdLl4-00011Z-FN@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: sun4i-i2s: Update binding documentation to include A31

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

>From f55d404f49194563974f5462f9f4bd7cbc48d9c6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
 <mylene.josserand@free-electrons.com>
Date: Fri, 10 Feb 2017 11:00:46 +0100
Subject: [PATCH] ASoC: sun4i-i2s: Update binding documentation to include A31
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a new compatible for sun4i-i2s driver to handle some
SoCs that have a reset line that must be asserted/deasserted.

This new compatible, "allwinner,sun6i-a31-i2s", requires the
property "resets" which should be a phandle to the reset line.
Except these differences, the compatible is identical to previous one
which will not handle a reset line.

Signed-off-by: Myl??ne Josserand <mylene.josserand@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sun4i-i2s.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
index 7b526ec64991..f4adc58f82ba 100644
--- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -7,6 +7,7 @@ Required properties:
 
 - compatible: should be one of the followings
    - "allwinner,sun4i-a10-i2s"
+   - "allwinner,sun6i-a31-i2s"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the I2S interrupt.
@@ -19,6 +20,10 @@ Required properties:
    - "mod" : module clock for the I2S controller
 - #sound-dai-cells : Must be equal to 0
 
+Required properties for the following compatibles:
+	- "allwinner,sun6i-a31-i2s"
+- resets: phandle to the reset line for this codec
+
 Example:
 
 i2s0: i2s at 01c22400 {
-- 
2.11.0
