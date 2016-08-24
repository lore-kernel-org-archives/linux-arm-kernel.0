From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 23 Aug 2016 18:33:11 -0700
Subject: [PATCH 2/4] arm64: dts: qcom: msm8916: Add Hexagon SMD edge
In-Reply-To: <1472002393-1875-1-git-send-email-bjorn.andersson@linaro.org>
References: <1472002393-1875-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1472002393-1875-2-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Hexagon SMD edge, so that QRTR is probed when the Hexagon is
booted.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 4a268e714db5..3f3ef20865cd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -692,6 +692,14 @@
 			};
 		};
 
+		hexagon {
+			interrupts = <0 25 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,smd-edge = <0>;
+			qcom,ipc = <&apcs 8 12>;
+			qcom,remote-pid = <1>;
+		};
+
 		pronto {
 			interrupts = <0 142 1>;
 
-- 
2.5.0
