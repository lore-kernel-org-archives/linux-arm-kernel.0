From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 10 Jun 2016 17:15:28 -0500
Subject: [PATCH] ARM: dts: qcom: msm8974-honami: Set DMA as remotely controlled
Message-ID: <1465596928-20843-1-git-send-email-andy.gross@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the qcom,controlled-remotely property for the blsp2_bam
controller node.  This board requires this, otherwise the board fails to
boot due to access of protected registers during BAM initialization.

Fixes: 62bc81792223 dts: msm8974: Add blsp2_bam dma node

Signed-off-by: Andy Gross <andy.gross@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index a0398b6..3fb4dad 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -367,6 +367,10 @@
 		};
 
 	};
+
+	dma-controller at f9944000 {
+		qcom,controlled-remotely;
+	};
 };
 
 &spmi_bus {
-- 
1.9.1
