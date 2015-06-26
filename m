From: bjorn@kryo.se (bjorn at kryo.se)
Date: Fri, 26 Jun 2015 14:50:16 -0700
Subject: [PATCH v2 08/11] ARM: dts: msm8974: Add tcsr mutex node
In-Reply-To: <1435355419-23602-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1435355419-23602-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1435355419-23602-9-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 37b47b5..7c7b7dc 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -220,6 +220,11 @@
 			reg = <0xfc400000 0x4000>;
 		};
 
+		tcsr_mutex_block: syscon at fd484000 {
+			compatible = "syscon";
+			reg = <0xfd484000 0x2000>;
+		};
+
 		mmcc: clock-controller at fd8c0000 {
 			compatible = "qcom,mmcc-msm8974";
 			#clock-cells = <1>;
@@ -227,6 +232,13 @@
 			reg = <0xfd8c0000 0x6000>;
 		};
 
+		tcsr_mutex: tcsr-mutex {
+			compatible = "qcom,tcsr-mutex";
+			syscon = <&tcsr_mutex_block 0 0x80>;
+
+			#hwlock-cells = <1>;
+		};
+
 		serial at f991e000 {
 			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
 			reg = <0xf991e000 0x1000>;
-- 
1.9.3 (Apple Git-50)
