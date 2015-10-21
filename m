From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 20 Oct 2015 21:57:49 -0700
Subject: [PATCH 6/7] ARM: dts: qcom: msm8974-honami: Specify charging
 parameters
In-Reply-To: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1445403470-17434-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1445403470-17434-6-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---

Echoing a reasonable limit into [1] is required as there's currently no
way for this value to be propagated from the USB stack to the charging
driver.  Otherwise the block will pull maximum 100mA off USB, which is
not enough to actually charge the running platform.

[1] /sys/class/power_supply/smbb-usbin/charge_control_limit

 arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
index 113cc18ee2f5..1cf455fff3c2 100644
--- a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
+++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
@@ -371,6 +371,17 @@
 
 &spmi_bus {
 	pm8941 at 0 {
+		charger at 1000 {
+			qcom,fast-charge-safe-current = <1500000>;
+			qcom,fast-charge-current-limit = <1500000>;
+			qcom,dc-current-limit = <1800000>;
+			qcom,fast-charge-safe-voltage = <4400000>;
+			qcom,fast-charge-high-threshold-voltage = <4350000>;
+			qcom,fast-charge-low-threshold-voltage = <3400000>;
+			qcom,auto-recharge-threshold-voltage = <4200000>;
+			qcom,minimum-input-voltage = <4300000>;
+		};
+
 		gpios at c000 {
 			boost_bypass_n_pin: boost-bypass {
 				pins = "gpio21";
-- 
2.4.2
