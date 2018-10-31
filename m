From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu,  1 Nov 2018 00:06:32 +0530
Subject: [PATCH 5/7] arm64: allwinner: h6: Add RTC node
In-Reply-To: <20181031183634.29640-1-jagan@amarulasolutions.com>
References: <20181031183634.29640-1-jagan@amarulasolutions.com>
Message-ID: <20181031183634.29640-5-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@openedev.com>

RTC controller is similar to A31, so use the same compatible
for H6 and update interrupt numbers as per manual.

Signed-off-by: Jagan Teki <jagan@openedev.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 3b9da12e65db..c8d2fe76da7e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -266,6 +266,13 @@
 			status = "disabled";
 		};
 
+		rtc: rtc at 7000000 {
+			compatible = "allwinner,sun6i-a31-rtc";
+			reg = <0x7000000 0x400>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_ccu: clock at 7010000 {
 			compatible = "allwinner,sun50i-h6-r-ccu";
 			reg = <0x07010000 0x400>;
-- 
2.18.0.321.gffc6fa0e3
