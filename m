From: chunkeey@googlemail.com (Christian Lamparter)
Date: Fri,  7 Jul 2017 16:57:10 +0200
Subject: [PATCH] arm: dts: qcom: add pseudo random number generator on the
 IPQ4019
Message-ID: <20170707145710.13458-1-chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This architecture has a pseudo random number generator
supported by the existing "qcom,prng" binding.

rngtest: bits received from input: 5795960032
rngtest: FIPS 140-2 successes: 289591
rngtest: FIPS 140-2 failures: 207
rngtest: FIPS 140-2(2001-10-10) Monobit: 25
rngtest: FIPS 140-2(2001-10-10) Poker: 28
rngtest: FIPS 140-2(2001-10-10) Runs: 91
rngtest: FIPS 140-2(2001-10-10) Long run: 67
rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
rngtest: input channel speed: (min=244; avg=46122; max=3906250)Kibits/s
rngtest: FIPS tests speed: (min=1.327; avg=20.966; max=26.345)Mibits/s
rngtest: Program run time: 386965827 microseconds

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 4 ++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
index b9457dd21a69..c25d8f5c669d 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
@@ -40,6 +40,10 @@
 			clock-frequency = <48000000>;
 		};
 
+		rng at 22000 {
+			status = "ok";
+		};
+
 		pinctrl at 0x01000000 {
 			serial_pins: serial_pinmux {
 				mux {
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index d8c87faa0124..d1a56331ce96 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -120,6 +120,14 @@
 			reg = <0x1800000 0x60000>;
 		};
 
+		rng at 22000 {
+			compatible = "qcom,prng";
+			reg = <0x22000 0x140>;
+			clocks = <&gcc GCC_PRNG_AHB_CLK>;
+			clock-names = "core";
+			status = "disabled";
+		};
+
 		tlmm: pinctrl at 0x01000000 {
 			compatible = "qcom,ipq4019-pinctrl";
 			reg = <0x01000000 0x300000>;
-- 
2.13.2
