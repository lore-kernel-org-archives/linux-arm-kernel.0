From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 20:37:02 -0700
Subject: [PATCH v2 6/9] ARM: dts: qcom: apq8064: Add syscon for sic-non-secure
In-Reply-To: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1459222625-11440-7-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Andy, this is only here for context, please apply separately.

Changes since v1:
- Added dts patches

 arch/arm/boot/dts/qcom-apq8064.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 65d0e8d98259..9d45c4ef4a97 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -212,6 +212,11 @@
 			regulator;
 		};
 
+		sic_non_secure: sic-non-secure at 12100000 {
+			compatible	= "syscon";
+			reg		= <0x12100000 0x10000>;
+		};
+
 		gsbi1: gsbi at 12440000 {
 			status = "disabled";
 			compatible = "qcom,gsbi-v1.0.0";
-- 
2.5.0
