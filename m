From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Apr 2018 16:35:24 +0200
Subject: [PATCH 1/2] ARM: dts: stm32: add RTC support to stm32mp157c
In-Reply-To: <1524148525-25209-1-git-send-email-amelie.delaunay@st.com>
References: <1524148525-25209-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1524148525-25209-2-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for RTC (Real Time Clock) to STM32MP157C SoC.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index bc3eddc..3333954 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -174,5 +174,14 @@
 			clocks = <&rcc USART1_K>;
 			status = "disabled";
 		};
+
+		rtc: rtc at 5c004000 {
+			compatible = "st,stm32mp1-rtc";
+			reg = <0x5c004000 0x400>;
+			clocks = <&rcc RTCAPB>, <&rcc RTC>;
+			clock-names = "pclk", "rtc_ck";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_HIGH_LEVEL>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4
