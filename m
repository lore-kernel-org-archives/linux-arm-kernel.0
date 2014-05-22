From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 22 May 2014 16:18:20 +0100
Subject: [PATCH 6/8] ARM: STi: DT: Enable mmc0 for both stih415 and stih416
 SoCs
In-Reply-To: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
References: <1400771902-26553-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1400771902-26553-7-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because the first sdhci controller is present on both stih415 and
stih416 SoC which can both populate the b2020 board, it can be
enabled in the generic DT file.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
---
 arch/arm/boot/dts/stih41x-b2020x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

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
