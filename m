From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Mar 2017 10:16:49 +0100
Subject: [PATCH 1/2] ARM: dts: add SDC2 and SDC4 to the MSM8660 family
Message-ID: <20170315091649.7495-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make the picture complete, add DTS entries also for the
second and fourth MMC/SD blocks on the MSM8660. SDC2 is
an 8-bit interface and SDC4 is a 4-bit interface.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Drop non-removable this is a board-specific attribute.
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 91c9a62ae725..747669a62aa8 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -392,6 +392,21 @@
 				cap-mmc-highspeed;
 			};
 
+			sdcc2: sdcc at 12140000 {
+				status		= "disabled";
+				compatible	= "arm,pl18x", "arm,primecell";
+				arm,primecell-periphid = <0x00051180>;
+				reg		= <0x12140000 0x8000>;
+				interrupts	= <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names	= "cmd_irq";
+				clocks		= <&gcc SDC2_CLK>, <&gcc SDC2_H_CLK>;
+				clock-names	= "mclk", "apb_pclk";
+				bus-width	= <8>;
+				max-frequency	= <48000000>;
+				cap-sd-highspeed;
+				cap-mmc-highspeed;
+			};
+
 			sdcc3: sdcc at 12180000 {
 				compatible	= "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
@@ -408,6 +423,21 @@
 				no-1-8-v;
 			};
 
+			sdcc4: sdcc at 121c0000 {
+				compatible	= "arm,pl18x", "arm,primecell";
+				arm,primecell-periphid = <0x00051180>;
+				status		= "disabled";
+				reg		= <0x121c0000 0x8000>;
+				interrupts	= <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names	= "cmd_irq";
+				clocks		= <&gcc SDC4_CLK>, <&gcc SDC4_H_CLK>;
+				clock-names	= "mclk", "apb_pclk";
+				bus-width	= <4>;
+				max-frequency	= <48000000>;
+				cap-sd-highspeed;
+				cap-mmc-highspeed;
+			};
+
 			sdcc5: sdcc at 12200000 {
 				compatible	= "arm,pl18x", "arm,primecell";
 				arm,primecell-periphid = <0x00051180>;
-- 
2.9.3
