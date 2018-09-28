From: broonie@kernel.org (Mark Brown)
Date: Fri, 28 Sep 2018 15:05:17 +0100 (BST)
Subject: Applied "spi: mediatek: add bindings for Mediatek MT2712 soc
 platform" to the spi tree
In-Reply-To: <1538131985-9471-2-git-send-email-leilk.liu@mediatek.com>
Message-ID: <20180928140517.8E077440078@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   spi: mediatek: add bindings for Mediatek MT2712 soc platform

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

>From c0116e6b30473c7a75d33077bfd60f3b4eec7808 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Fri, 28 Sep 2018 18:53:03 +0800
Subject: [PATCH] spi: mediatek: add bindings for Mediatek MT2712 soc platform

This patch adds a DT binding documentation for the MT2712 soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/spi/spi-slave-mt27xx.txt         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
new file mode 100644
index 000000000000..c37e5a179b21
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
@@ -0,0 +1,32 @@
+Binding for MTK SPI Slave controller
+
+Required properties:
+- compatible: should be one of the following.
+    - mediatek,mt2712-spi-slave: for mt2712 platforms
+- reg: Address and length of the register set for the device.
+- interrupts: Should contain spi interrupt.
+- clocks: phandles to input clocks.
+  It's clock gate, and should be <&infracfg CLK_INFRA_AO_SPI1>.
+- clock-names: should be "spi" for the clock gate.
+
+Optional properties:
+- assigned-clocks: it's mux clock, should be <&topckgen CLK_TOP_SPISLV_SEL>.
+- assigned-clock-parents: parent of mux clock.
+  It's PLL, and should be one of the following.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D2>: specify parent clock 312MHZ.
+				       It's the default one.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D4>: specify parent clock 156MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL2_D4>: specify parent clock 104MHZ.
+   -  <&topckgen CLK_TOP_UNIVPLL1_D8>: specify parent clock 78MHZ.
+
+Example:
+- SoC Specific Portion:
+spis1: spi at 10013000 {
+	compatible = "mediatek,mt2712-spi-slave";
+	reg = <0 0x10013000 0 0x100>;
+	interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&infracfg CLK_INFRA_AO_SPI1>;
+	clock-names = "spi";
+	assigned-clocks = <&topckgen CLK_TOP_SPISLV_SEL>;
+	assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL1_D2>;
+};
-- 
2.19.0
