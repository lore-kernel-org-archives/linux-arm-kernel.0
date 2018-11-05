From: broonie@kernel.org (Mark Brown)
Date: Mon,  5 Nov 2018 12:01:53 +0000 (GMT)
Subject: Applied "spi: uniphier: re-add addressing properties" to the spi tree
In-Reply-To: <1540533525-1816-3-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <20181105120153.EB1181124D98@debutante.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: uniphier: re-add addressing properties

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 2a35a643f138a97e3bfee0c599c72e5ca80ebe7c Mon Sep 17 00:00:00 2001
From: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Date: Fri, 26 Oct 2018 14:58:45 +0900
Subject: [PATCH] spi: uniphier: re-add addressing properties

In commit 7662d1dc17d4 ("spi: uniphier: fix incorrect property items")
addressing properties of #address-cells and #size-cells were removed.
Since it is not necessary to remove them, they are back again.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-uniphier.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-uniphier.txt b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
index b04e66a52de5..e1201573a29a 100644
--- a/Documentation/devicetree/bindings/spi/spi-uniphier.txt
+++ b/Documentation/devicetree/bindings/spi/spi-uniphier.txt
@@ -5,6 +5,8 @@ UniPhier SoCs have SCSSI which supports SPI single channel.
 Required properties:
  - compatible: should be "socionext,uniphier-scssi"
  - reg: address and length of the spi master registers
+ - #address-cells: must be <1>, see spi-bus.txt
+ - #size-cells: must be <0>, see spi-bus.txt
  - interrupts: a single interrupt specifier
  - pinctrl-names: should be "default"
  - pinctrl-0: pin control state for the default mode
@@ -16,6 +18,8 @@ Example:
 spi0: spi at 54006000 {
 	compatible = "socionext,uniphier-scssi";
 	reg = <0x54006000 0x100>;
+	#address-cells = <1>;
+	#size-cells = <0>;
 	interrupts = <0 39 4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_spi0>;
-- 
2.19.0.rc2
