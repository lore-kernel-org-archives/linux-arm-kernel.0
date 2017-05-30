From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:16 +0200
Subject: [PATCH 35/58] ARM: dts: at91: sama5d3xek_cmp: use TCB0 as clocksource
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-36-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 as the clocksource like previously selected in sama5_defconfig.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi b/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
index dc7572bc7ff0..2908879e84cf 100644
--- a/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
@@ -69,6 +69,18 @@
 				cs-gpios = <&pioD 13 0>, <0>, <0>, <0>;
 			};
 
+			tcb0: timer at f0010000 {
+				timer at 0 {
+					compatible = "atmel,tcb-timer";
+					reg = <0>;
+				};
+
+				timer at 1 {
+					compatible = "atmel,tcb-timer";
+					reg = <1>;
+				};
+			};
+
 			macb0: ethernet at f0028000 {
 				phy-mode = "rgmii";
 				#address-cells = <1>;
-- 
2.11.0
