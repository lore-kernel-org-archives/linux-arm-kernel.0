From: jagan@amarulasolutions.com (Jagan Teki)
Date: Fri,  1 Jun 2018 23:05:26 +0530
Subject: [PATCH v3 1/2] arm64: allwinner: a64: Add RTC clock to phandle 32kHz
 external oscillator
Message-ID: <20180601173527.18051-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Outside of SOC few chips need external clock source
through RTC example Wifi chip. So RTC clock nodes to
phandle 32kHz external oscillator.

prefix rtc- with clock-output-names defined in
dt-binding to avoid confusion with existing osc32k name.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- squash of previous v2 patch

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b2ef28c42bd..82516aec4153 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -634,6 +634,9 @@
 			reg = <0x01f00000 0x54>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
+			clocks = <&osc32k>;
+			#clock-cells = <1>;
 		};
 
 		r_intc: interrupt-controller at 1f00c00 {
-- 
2.14.3
