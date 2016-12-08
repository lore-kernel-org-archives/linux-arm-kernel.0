From: broonie@kernel.org (Mark Brown)
Date: Thu, 08 Dec 2016 16:55:28 +0000
Subject: Applied "spi: armada-3700: Add documentation for the Armada 3700 SPI
 Controller" to the spi tree
In-Reply-To: <20161129143939.3191-4-romain.perier@free-electrons.com>
Message-ID: <E1cF1yi-00056u-Dv@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: armada-3700: Add documentation for the Armada 3700 SPI Controller

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

>From 4049537742b3ed39fac4da10d31f3171a2ee9a3e Mon Sep 17 00:00:00 2001
From: Romain Perier <romain.perier@free-electrons.com>
Date: Thu, 8 Dec 2016 15:58:45 +0100
Subject: [PATCH] spi: armada-3700: Add documentation for the Armada 3700 SPI
 Controller

This adds the devicetree bindings documentation for the SPI controller
present in the Marvell Armada 3700 SoCs.

Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/spi/spi-armada-3700.txt    | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-armada-3700.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-armada-3700.txt b/Documentation/devicetree/bindings/spi/spi-armada-3700.txt
new file mode 100644
index 000000000000..1564aa8c02cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-armada-3700.txt
@@ -0,0 +1,25 @@
+* Marvell Armada 3700 SPI Controller
+
+Required Properties:
+
+- compatible: should be "marvell,armada-3700-spi"
+- reg: physical base address of the controller and length of memory mapped
+       region.
+- interrupts: The interrupt number. The interrupt specifier format depends on
+	      the interrupt controller and of its driver.
+- clocks: Must contain the clock source, usually from the North Bridge clocks.
+- num-cs: The number of chip selects that is supported by this SPI Controller
+- #address-cells: should be 1.
+- #size-cells: should be 0.
+
+Example:
+
+	spi0: spi at 10600 {
+		compatible = "marvell,armada-3700-spi";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x10600 0x5d>;
+		clocks = <&nb_perih_clk 7>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+		num-cs = <4>;
+	};
-- 
2.10.2
