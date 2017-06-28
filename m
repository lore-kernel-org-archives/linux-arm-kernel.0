From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 20:25:43 +0100
Subject: Applied "spi: stm32: fix example with st,
 spi-midi-ns property" to the spi tree
In-Reply-To: <1498578321-13980-4-git-send-email-amelie.delaunay@st.com>
Message-ID: <E1dQIat-0004fK-1x@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: stm32: fix example with st, spi-midi-ns property

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 5fd3d9433217908e1e8e1c2f841c3b28c75509d6 Mon Sep 17 00:00:00 2001
From: Amelie Delaunay <amelie.delaunay@st.com>
Date: Tue, 27 Jun 2017 17:45:15 +0200
Subject: [PATCH] spi: stm32: fix example with st, spi-midi-ns property

This patch aligns example with the optional property description,
removes status and replace spidev unvalid compatible with
Aarvark SPI Host Adapter one.

In slave mode, Aardvark SPI Host Adapter requires 4ms delay
between the end of byte n and the start of byte n+1, hence the
use of the optional property st,spi-midi-ns.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-stm32.txt | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
index 415378bca480..1b3fa2c119d5 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -48,13 +48,12 @@ Example:
 		dma-names = "rx", "tx";
 		pinctrl-0 = <&spi2_pins_b>;
 		pinctrl-names = "default";
-		status = "okay";
 		cs-gpios = <&gpioa 11 0>;
 
-		spidev at 0 {
-			compatible = "spidev";
+		aardvark at 0 {
+			compatible = "totalphase,aardvark";
 			reg = <0>;
 			spi-max-frequency = <4000000>;
-			st,spi-midi = <4000>;
+			st,spi-midi-ns = <4000>;
 		};
 	};
-- 
2.13.2
