From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue,  8 Jul 2014 18:21:14 +0200
Subject: [PATCHv2 4/6] ARM: at91/dt: sama5d3: define mpddr clock and ramc
 clocks
In-Reply-To: <1404836476-23787-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404836476-23787-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1404836476-23787-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the available clock for mprddr and take both mpddr_clk and ddrck in the
ram controller driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index e0b15a6e8897..04c35ce1e33e 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -402,8 +402,10 @@
 			};
 
 			ramc0: ramc at ffffea00 {
-				compatible = "atmel,at91sam9g45-ddramc";
+				compatible = "atmel,sama5d3-ddramc";
 				reg = <0xffffea00 0x200>;
+				clocks = <&ddrck>, <&mpddr_clk>;
+				clock-names = "ddrck", "mpddr";
 			};
 
 			dbgu: serial at ffffee00 {
@@ -1170,6 +1172,11 @@
 						#clock-cells = <0>;
 						reg = <48>;
 					};
+
+					mpddr_clk: mpddr_clk {
+						#clock-cells = <0>;
+						reg = <49>;
+					};
 				};
 			};
 
-- 
1.9.1
