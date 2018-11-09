From: vkoul@kernel.org (Vinod Koul)
Date: Fri,  9 Nov 2018 15:14:10 +0530
Subject: [PATCH v5 11/18] arm64: dts: qcom: pms405: add rtc node
In-Reply-To: <20181109094417.12109-1-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
Message-ID: <20181109094417.12109-12-vkoul@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RTC is found on PMIC PMS405 and is same as other PMIC used, so add the
rtc node with compatible as qcom,pm8941-rtc

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
index 7b8104e21507..2b275bbdafa3 100644
--- a/arch/arm64/boot/dts/qcom/pms405.dtsi
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -10,5 +10,11 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		rtc at 6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
+		};
 	};
 };
-- 
2.14.4
