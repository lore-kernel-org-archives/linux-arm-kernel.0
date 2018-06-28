From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 28 Jun 2018 14:09:14 -0700
Subject: [PATCH 2/3] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
In-Reply-To: <20180628210915.160893-1-mka@chromium.org>
References: <20180628210915.160893-1-mka@chromium.org>
Message-ID: <20180628210915.160893-2-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the spmi-temp-alarm node to pm8998 based on the examples in the
bindings.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 92bed1e7d4bb..f2d39074ed74 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -44,6 +44,12 @@
 				     <0 0xd9 0 IRQ_TYPE_NONE>;
 		};
 
+		pm8998_temp: qcom,temp-alarm at 2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400 0x100>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
+		};
 	};
 
 	pm8998_lsid1: pmic at 1 {
-- 
2.18.0.rc2.346.g013aa6912e-goog
