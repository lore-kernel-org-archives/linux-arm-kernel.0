From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 11 Jun 2016 00:03:34 +0200
Subject: [PATCH 31/48] ARM: dts: at91: sama5d3xek; use TCB0 as clocksource
In-Reply-To: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465596231-21766-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1465596231-21766-32-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 as the clocksource like previously selected in sama5_defconfig.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3xcm.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index 2cf9c3611db6..90d36b755858 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -35,6 +35,18 @@
 				cs-gpios = <&pioD 13 0>, <0>, <0>, <0>;
 			};
 
+			tcb0: timer at f0010000 {
+				timer at 0 {
+					compatible = "atmel,tcb-clksrc";
+					reg = <0>;
+				};
+
+				timer at 1 {
+					compatible = "atmel,tcb-clkevt";
+					reg = <1>;
+				};
+			};
+
 			macb0: ethernet at f0028000 {
 				phy-mode = "rgmii";
 				#address-cells = <1>;
-- 
2.8.1
