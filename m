From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  9 Aug 2017 14:30:43 +0800
Subject: [PATCH 02/10] arm64: dts: zx296718: add I2S and I2C audio codec
In-Reply-To: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
References: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1502260251-6316-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds I2S and I2C audio codec devices for zx296718 SoC support.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/zx296718.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/zte/zx296718.dtsi b/arch/arm64/boot/dts/zte/zx296718.dtsi
index fdb1a57867ac..37eb93a39c92 100644
--- a/arch/arm64/boot/dts/zte/zx296718.dtsi
+++ b/arch/arm64/boot/dts/zte/zx296718.dtsi
@@ -455,6 +455,36 @@
 			#clock-cells = <1>;
 		};
 
+		i2s0: i2s at 1482000 {
+			compatible = "zte,zx296718-i2s", "zte,zx296702-i2s";
+			reg = <0x01482000 0x1000>;
+			clocks = <&audiocrm AUDIO_I2S0_WCLK>,
+				 <&audiocrm AUDIO_I2S0_PCLK>;
+			clock-names = "wclk", "pclk";
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&dma 22>, <&dma 23>;
+			dma-names = "tx", "rx";
+			#sound-dai-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c0: i2c at 1486000 {
+			compatible = "zte,zx296718-i2c";
+			reg = <0x01486000 0x1000>;
+			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&audiocrm AUDIO_I2C0_WCLK>;
+			clock-frequency = <1600000>;
+			status = "disabled";
+
+			aud96p22: codec at 22 {
+				compatible = "zte,zx-aud96p22";
+				#sound-dai-cells = <0>;
+				reg = <0x22>;
+			};
+		};
+
 		spdif0: spdif at 1488000 {
 			compatible = "zte,zx296702-spdif";
 			reg = <0x1488000 0x1000>;
-- 
1.9.1
