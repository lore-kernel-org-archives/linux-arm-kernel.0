From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 28 Jan 2016 17:44:16 +0000
Subject: [PATCH v2 8/9] arm64: dts: apq8016-sbc: move sdhci node under soc node
In-Reply-To: <1454002960-3106-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454002960-3106-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1454003056-3456-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To be consistent with other nodes move sdhci node under the soc node,
rather than using lable references.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 279af22..8102929 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -129,11 +129,11 @@
 				default-state = "off";
 			};
 		};
-	};
-};
 
-&sdhc_1 {
-	status = "okay";
+		sdhci at 07824000 {
+			status = "okay";
+		};
+	};
 };
 
 &smd_rpm_regulators {
-- 
1.9.1
