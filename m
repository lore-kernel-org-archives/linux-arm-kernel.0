From: broonie@kernel.org (Mark Brown)
Date: Tue, 21 Feb 2017 16:26:08 -0800
Subject: Applied "ASoC: zx-tdm: add bindings doc for zte's tdm controller" to
 the asoc tree
In-Reply-To: <1487243106-22841-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <E1cgKky-0005Tb-3E@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: zx-tdm: add bindings doc for zte's tdm controller

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

>From 5949dae3a4512fa1ca61eac947c349442acc12b0 Mon Sep 17 00:00:00 2001
From: Baoyou Xie <baoyou.xie@linaro.org>
Date: Thu, 16 Feb 2017 19:05:04 +0800
Subject: [PATCH] ASoC: zx-tdm: add bindings doc for zte's tdm controller

This patch adds dt-binding documentation for zte's tdm controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Reviewed-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/zte,tdm.txt          | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,tdm.txt

diff --git a/Documentation/devicetree/bindings/sound/zte,tdm.txt b/Documentation/devicetree/bindings/sound/zte,tdm.txt
new file mode 100644
index 000000000000..2a07ca655264
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/zte,tdm.txt
@@ -0,0 +1,30 @@
+ZTE TDM DAI driver
+
+Required properties:
+
+- compatible : should be one of the following.
+       * zte,zx296718-tdm
+- reg : physical base address of the controller and length of memory mapped
+    region.
+- clocks : Pairs of phandle and specifier referencing the controller's clocks.
+- clock-names: "wclk" for the wclk.
+               "pclk" for the pclk.
+-#clock-cells: should be 1.
+- zte,tdm-dma-sysctrl : Reference to the sysctrl controller controlling
+    the dma. includes:
+	phandle of sysctrl.
+	register offset in sysctrl for control dma.
+	mask of the register that be written to sysctrl.
+
+Example:
+
+	tdm: tdm at 1487000 {
+		compatible = "zte,zx296718-tdm";
+		reg = <0x01487000 0x1000>;
+		clocks = <&audiocrm AUDIO_TDM_WCLK>, <&audiocrm AUDIO_TDM_PCLK>;
+		clock-names = "wclk", "pclk";
+		#clock-cells = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tdm_global_pin>;
+		zte,tdm-dma-sysctrl = <&sysctrl 0x10c 4>;
+	};
-- 
2.11.0
