From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 30 Jul 2015 10:53:57 -0700
Subject: [PATCHv2 4/4] ARM: dts: qcom-pm8941: Add charger node
In-Reply-To: <1438278837-29967-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1438278837-29967-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1438278837-29967-5-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Courtney Cavin <courtney.cavin@sonymobile.com>

Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---

Changes since v1:
- Corrected authorship

 arch/arm/boot/dts/qcom-pm8941.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index aa774e685018..6063c7ddda0f 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -26,6 +26,27 @@
 			bias-pull-up;
 		};
 
+		charger at 1000 {
+			compatible = "qcom,pm8941-charger";
+			reg = <0x1000 0x700>;
+			interrupts = <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x10 5 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x10 4 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x12 1 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x12 0 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x13 2 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x13 1 IRQ_TYPE_EDGE_BOTH>,
+				     <0x0 0x14 1 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "chg-done",
+					  "chg-fast",
+					  "chg-trkl",
+					  "bat-temp-ok",
+					  "bat-present",
+					  "chg-gone",
+					  "usb-valid",
+					  "dc-valid";
+		};
+
 		pm8941_gpios: gpios at c000 {
 			compatible = "qcom,pm8941-gpio";
 			reg = <0xc000 0x2400>;
-- 
1.8.2.2
