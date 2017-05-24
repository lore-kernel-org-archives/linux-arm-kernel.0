From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 May 2017 18:42:37 +0100
Subject: Applied "spi: meson: Add SPICC bindings" to the spi tree
In-Reply-To: <1495546773-20479-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <E1dDaIv-000333-0q@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: meson: Add SPICC bindings

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

>From 01a330da0c0ea2971be039f74a2288cbd2d17fbf Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Tue, 23 May 2017 15:39:32 +0200
Subject: [PATCH] spi: meson: Add SPICC bindings

Add the SPICC (SPI Communications Controller) bindings variant.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-meson.txt          | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-meson.txt b/Documentation/devicetree/bindings/spi/spi-meson.txt
index dc6d0313324a..825c39cae74a 100644
--- a/Documentation/devicetree/bindings/spi/spi-meson.txt
+++ b/Documentation/devicetree/bindings/spi/spi-meson.txt
@@ -20,3 +20,34 @@ Required properties:
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
+
+* SPICC (SPI Communication Controller)
+
+The Meson SPICC is generic SPI controller for general purpose Full-Duplex
+communications with dedicated 16 words RX/TX PIO FIFOs.
+
+Required properties:
+ - compatible: should be "amlogic,meson-gx-spicc" on Amlogic GX SoCs.
+ - reg: physical base address and length of the controller registers
+ - interrupts: The interrupt specifier
+ - clock-names: Must contain "core"
+ - clocks: phandle of the input clock for the baud rate generator
+ - #address-cells: should be 1
+ - #size-cells: should be 0
+
+Optional properties:
+ - resets: phandle of the internal reset line
+
+See ../spi/spi-bus.txt for more details on SPI bus master and slave devices
+required and optional properties.
+
+Example :
+	spi at c1108d80 {
+		compatible = "amlogic,meson-gx-spicc";
+		reg = <0xc1108d80 0x80>;
+		interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+		clock-names = "core";
+		clocks = <&clk81>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
-- 
2.11.0
