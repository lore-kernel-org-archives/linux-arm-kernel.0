From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu,  1 Nov 2018 00:06:33 +0530
Subject: [PATCH 6/7] arm64: allwinner: h6: Add RTC clock to phandle 32kHz
 external oscillator
In-Reply-To: <20181031183634.29640-1-jagan@amarulasolutions.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
Message-ID: <20181031183634.29640-6-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@openedev.com>

Outside of SOC few chips need external clock source through RTC example
Wifi chip. So H6 RTC clock node need to phandle 32kHz external oscillator
like A64 RTC.

Add support for it.

prefix rtc- with clock-output-names defined in dt-binding to avoid
confusion with existing osc32k name.

Signed-off-by: Jagan Teki <jagan@openedev.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index c8d2fe76da7e..028ec286aa0a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -271,6 +271,9 @@
 			reg = <0x7000000 0x400>;
 			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
+			clocks = <&osc32k>;
+			#clock-cells = <1>;
 		};
 
 		r_ccu: clock at 7010000 {
-- 
2.18.0.321.gffc6fa0e3
