From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jun 2017 20:25:52 +0100
Subject: Applied "spi: stm32: use SoC specific compatible" to the spi tree
In-Reply-To: <1498222550-19092-2-git-send-email-amelie.delaunay@st.com>
Message-ID: <E1dQIb2-0004hK-Sr@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: stm32: use SoC specific compatible

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

>From 567300d11ef54f7779aa7324510fd4dbd470f73e Mon Sep 17 00:00:00 2001
From: Amelie Delaunay <amelie.delaunay@st.com>
Date: Tue, 27 Jun 2017 17:45:13 +0200
Subject: [PATCH] spi: stm32: use SoC specific compatible

This patch replaces st,stm32-spi compatible with st,stm32h7-spi SoC
specific compatible and updates the example accondingly.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-stm32.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-stm32.txt b/Documentation/devicetree/bindings/spi/spi-stm32.txt
index 3958bf6e8b37..415378bca480 100644
--- a/Documentation/devicetree/bindings/spi/spi-stm32.txt
+++ b/Documentation/devicetree/bindings/spi/spi-stm32.txt
@@ -7,7 +7,7 @@ from 4 to 32-bit data size. Although it can be configured as master or slave,
 only master is supported by the driver.
 
 Required properties:
-- compatible: Must be "st,stm32-spi".
+- compatible: Must be "st,stm32h7-spi".
 - reg: Offset and length of the device's register set.
 - interrupts: Must contain the interrupt id.
 - clocks: Must contain an entry for spiclk (which feeds the internal clock
@@ -38,7 +38,7 @@ Example:
 	spi2: spi at 40003800 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "st,stm32-spi";
+		compatible = "st,stm32h7-spi";
 		reg = <0x40003800 0x400>;
 		interrupts = <36>;
 		clocks = <&rcc SPI2_CK>;
-- 
2.13.2
