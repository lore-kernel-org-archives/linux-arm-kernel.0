From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 15 Jul 2016 17:42:12 -0700
Subject: [PATCH 2/6] arm64: dts: qcom: msm8916: Add mba memory reserve
In-Reply-To: <1468629736-7644-1-git-send-email-bjorn.andersson@linaro.org>
References: <1468629736-7644-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1468629736-7644-2-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The modem boot authenticator needs space to play in, this is supposed to
be relocatable and as such could later be replaced with a dynamically
allocated chunk of memory. But let's give it a reserve for now, as we
know that works.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 6148ea05b50a..4f2882605138 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -86,6 +86,11 @@
 			reg = <0x0 0x89300000 0x0 0x600000>;
 			no-map;
 		};
+
+		mba_mem: mba at 8ea00000 {
+			no-map;
+			reg = <0 0x8ea00000 0 0x100000>;
+		};
 	};
 
 	cpus {
-- 
2.5.0
