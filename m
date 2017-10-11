From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 10 Oct 2017 22:08:57 -0700
Subject: [PATCH v4 5/5] arm64: dts: msm8916: Mark rmtfs node as qcom,
 rmtfs-mem compatible
In-Reply-To: <20171011050857.7588-1-bjorn.andersson@linaro.org>
References: <20171011050857.7588-1-bjorn.andersson@linaro.org>
Message-ID: <20171011050857.7588-6-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a binding defined for the shared file system memory use
this to describe the rmtfs memory region.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- None

Changes since v2:
- Update compatible

Changes since v1:
- New patch

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 039991f80831..f6ae6f9b27e1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -69,8 +69,11 @@
 		};
 
 		rmtfs at 86700000 {
+			compatible = "qcom,rmtfs-mem";
 			reg = <0x0 0x86700000 0x0 0xe0000>;
 			no-map;
+
+			qcom,client-id = <1>;
 		};
 
 		rfsa at 867e00000 {
-- 
2.12.0
