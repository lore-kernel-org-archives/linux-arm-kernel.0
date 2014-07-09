From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  9 Jul 2014 16:07:38 +0100
Subject: [PATCH v4 07/10] ARM: STi: DT: Enable mmc0 for both stih415 and
 stih416 SoCs
In-Reply-To: <1404918461-25390-1-git-send-email-peter.griffin@linaro.org>
References: <1404918461-25390-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1404918461-25390-8-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the first sdhci controller is present on both stih415 and
stih416 SoC which can both populate the b2020 board, it can be
enabled in the generic DT file.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih41x-b2020.dtsi  | 4 ++++
 arch/arm/boot/dts/stih41x-b2020x.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stih41x-b2020.dtsi b/arch/arm/boot/dts/stih41x-b2020.dtsi
index d8a8429..5c2df46 100644
--- a/arch/arm/boot/dts/stih41x-b2020.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2020.dtsi
@@ -74,5 +74,9 @@
 
 			pinctrl-0	= <&pinctrl_rgmii1>;
 		};
+
+		mmc0: sdhci at fe81e000 {
+			bus-width = <8>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih41x-b2020x.dtsi b/arch/arm/boot/dts/stih41x-b2020x.dtsi
index df01c12..f797a06 100644
--- a/arch/arm/boot/dts/stih41x-b2020x.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2020x.dtsi
@@ -8,6 +8,10 @@
  */
 / {
 	soc {
+		mmc0: sdhci at fe81e000 {
+			status = "okay";
+		};
+
 		spifsm: spifsm at fe902000 {
 			#address-cells = <1>;
 			#size-cells    = <1>;
-- 
1.9.1
