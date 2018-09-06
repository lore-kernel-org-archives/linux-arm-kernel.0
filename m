From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu,  6 Sep 2018 14:04:54 -0700
Subject: [PATCH v2 3/3] arm64: dts: qcom: pm8998: Add die temperature channel
 node to the ADC
In-Reply-To: <20180906210454.247219-1-mka@chromium.org>
References: <20180906210454.247219-1-mka@chromium.org>
Message-ID: <20180906210454.247219-4-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a channel node for the die temperature to the ADC.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
--
Changes in v2:
- none
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 41593ebbea2c..d18d4f260fbe 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -19,6 +19,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
+
+			die-temp {
+				reg = <ADC5_DIE_TEMP>;
+				label = "die_temp";
+			};
 		};
 
 		pm8998_gpio: gpios at c000 {
-- 
2.19.0.rc2.392.g5ba43deb5a-goog
