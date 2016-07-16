From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Jul 2016 17:42:15 -0700
Subject: [PATCH 5/6] arm64: dts: qcom: msm8916: Add Hexagon SMD edge
In-Reply-To: <1468629736-7644-1-git-send-email-bjorn.andersson@linaro.org>
References: <1468629736-7644-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1468629736-7644-5-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Hexagon SMD edge so that SMD channels provided by the Hexagon
is recognized.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 64f85f82602c..85ec5c932975 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -667,6 +667,14 @@
 				};
 			};
 		};
+
+		hexagon {
+			interrupts = <0 25 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs 8 12>;
+
+			qcom,smd-edge = <0>;
+			qcom,remote-pid = <1>;
+		};
 	};
 
 	hexagon-smp2p {
-- 
2.5.0
