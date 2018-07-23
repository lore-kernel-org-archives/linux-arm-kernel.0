From: baolin.wang@linaro.org (Baolin Wang)
Date: Mon, 23 Jul 2018 14:10:19 +0800
Subject: [PATCH 4/5] arm64: dts: sprd: Add SC27XX ADC device
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
Message-ID: <1b98cf860c86f745a1efea21f39abb2ba4d5493f.1531881619.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Spreadtrum SC27XX PMICs ADC device node which contains 32 channels.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index fc68076..82bd642 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -65,6 +65,15 @@
 			hwlocks = <&hwlock 12>;
 		};
 
+		pmic_adc: adc at 480 {
+			compatible = "sprd,sc27xx-adc", "sprd,sc2731-adc";
+			reg = <0x480>;
+			interrupt-parent = <&sc2731_pmic>;
+			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+			#io-channel-cells = <1>;
+			hwlocks = <&hwlock 4>;
+		};
+
 		vibrator at ec8 {
 			compatible = "sprd,sc27xx-vibrator", "sprd,sc2731-vibrator";
 			reg = <0xec8>;
-- 
1.7.9.5
