From: broonie@kernel.org (Mark Brown)
Date: Tue, 26 Jun 2018 16:11:33 +0100 (BST)
Subject: Applied "ASoC: q6afe: dt-bindings: add compatible string to dais" to
 the asoc tree
In-Reply-To: <20180626092016.9296-4-srinivas.kandagatla@linaro.org>
Message-ID: <20180626151133.5E097440070@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: q6afe: dt-bindings: add compatible string to dais

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From e43792c6e5027ad3f0280f5a2e6952b0d436b19b Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 26 Jun 2018 10:20:07 +0100
Subject: [PATCH] ASoC: q6afe: dt-bindings: add compatible string to dais

Add compatible string to dais so that it can support DT based module
autoloading.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/qcom,q6afe.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
index bdbf87df8c0b..a8179409c194 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -17,6 +17,11 @@ used by all apr services. Must contain the following properties.
 subnode of "dais" representing board specific dai setup.
 "dais" node should have following properties followed by dai children.
 
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6afe-dais"
+
 - #sound-dai-cells
 	Usage: required
 	Value type: <u32>
@@ -100,6 +105,7 @@ q6afe at 4 {
 	reg = <APR_SVC_AFE>;
 
 	dais {
+		compatible = "qcom,q6afe-dais";
 		#sound-dai-cells = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.17.1
