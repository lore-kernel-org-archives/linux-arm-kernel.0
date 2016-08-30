From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 30 Aug 2016 14:09:29 -0700
Subject: [PATCH v2 1/2] arm64: dts: qcom: msm8916: Add Hexagon SMD edge
Message-ID: <1472591370-20550-1-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Hexagon SMD edge, so that QRTR is probed when the Hexagon is
booted.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Rebase ontop of linux-next

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 74daf89d977d..5a1b5f5b3a90 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -731,6 +731,14 @@
 				};
 			};
 		};
+
+		hexagon {
+			interrupts = <0 25 IRQ_TYPE_EDGE_RISING>;
+
+			qcom,smd-edge = <0>;
+			qcom,ipc = <&apcs 8 12>;
+			qcom,remote-pid = <1>;
+		};
 	};
 
 	hexagon-smp2p {
-- 
2.5.0
