From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed,  8 Aug 2018 12:13:39 -0700
Subject: [PATCH 3/3] arm64: dts: qcom: pm8998: Add die temperature channel
 node to the ADC
In-Reply-To: <20180808191339.16875-1-mka@chromium.org>
References: <20180808191339.16875-1-mka@chromium.org>
Message-ID: <20180808191339.16875-4-mka@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a channel node for the die temperature to the ADC.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index f70f6101bceb..499bae0afb7f 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -20,6 +20,11 @@
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
 			io-channel-ranges;
+
+			die-temp {
+				reg = <ADC5_DIE_TEMP>;
+				label = "die_temp";
+			};
 		};
 
 		pm8998_gpio: gpios at c000 {
-- 
2.18.0.597.ga71716f1ad-goog
