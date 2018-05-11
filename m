From: broonie@kernel.org (Mark Brown)
Date: Fri, 11 May 2018 04:18:34 +0100 (BST)
Subject: Applied "ASoC: qdsp6: dt-bindings: Add q6core dt bindings" to the
 asoc tree
In-Reply-To: <20180509125635.5653-4-srinivas.kandagatla@linaro.org>
Message-ID: <20180511031834.6BFF644007A@finisterre.ee.mobilebroadband>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: qdsp6: dt-bindings: Add q6core dt bindings

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

>From 8c943ef123669b0c4100d69039326696c1662d60 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Wed, 9 May 2018 13:56:14 +0100
Subject: [PATCH] ASoC: qdsp6: dt-bindings: Add q6core dt bindings

This patch add DT bindings for Q6CORE DSP module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Banajit Goswami <bgoswami@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/qcom,q6core.txt | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6core.txt

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6core.txt b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
new file mode 100644
index 000000000000..7f36ff8bec18
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,q6core.txt
@@ -0,0 +1,21 @@
+Qualcomm ADSP Core service binding
+
+Q6CORE is one of the APR audio service on Q6DSP.
+Please refer to qcom,apr.txt for details of the common apr service bindings
+used by the apr service device.
+
+- but must contain the following property:
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,q6core-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
+		   Or "qcom,q6core" where the version number can be queried
+		   from DSP.
+		   example "qcom,q6core-v2.0"
+
+= EXAMPLE
+q6core at 3 {
+	compatible = "qcom,q6core";
+	reg = <APR_SVC_ADSP_CORE>;
+};
-- 
2.17.0
