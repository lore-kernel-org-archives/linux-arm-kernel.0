From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Jun 2016 17:30:56 +0200
Subject: [PATCH 2/5] ARM: dts: add SDCC5 to Qualcomm MSM8660
In-Reply-To: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
References: <1465918259-11138-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1465918259-11138-3-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SDCC5 SD/MMC controller is used for a second uSD slot
on the APQ8060 Dragonboard. On most other systems it is just
dark silicon so define it and leave it as "disabled" in the core
SoC file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 6a62b62ad980..a5a38820554a 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -262,6 +262,22 @@
 				no-1-8-v;
 				vmmc-supply = <&vsdcc_fixed>;
 			};
+
+			sdcc5: sdcc at 12200000 {
+				compatible	= "arm,pl18x", "arm,primecell";
+				arm,primecell-periphid = <0x00051180>;
+				status		= "disabled";
+				reg		= <0x12200000 0x8000>;
+				interrupts	= <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names	= "cmd_irq";
+				clocks		= <&gcc SDC5_CLK>, <&gcc SDC5_H_CLK>;
+				clock-names	= "mclk", "apb_pclk";
+				bus-width	= <4>;
+				cap-sd-highspeed;
+				cap-mmc-highspeed;
+				max-frequency	= <48000000>;
+				vmmc-supply = <&vsdcc_fixed>;
+			};
 		};
 
 		tcsr: syscon at 1a400000 {
-- 
2.4.11
