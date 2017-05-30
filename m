From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 May 2017 23:51:17 +0200
Subject: [PATCH 36/58] ARM: dts: at91: linea/tse850-3: use TCB0 as clocksource
In-Reply-To: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
Message-ID: <20170530215139.9983-37-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 as the clocksource like previously selected in sama5_defconfig.

Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-linea.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-linea.dtsi b/arch/arm/boot/dts/at91-linea.dtsi
index 0721c8472509..7f73e98e223f 100644
--- a/arch/arm/boot/dts/at91-linea.dtsi
+++ b/arch/arm/boot/dts/at91-linea.dtsi
@@ -27,6 +27,18 @@
 	clock-frequency = <12000000>;
 };
 
+&tcb0 {
+	timer at 0 {
+		compatible = "atmel,tcb-timer";
+		reg = <0>;
+	};
+
+	timer at 1 {
+		compatible = "atmel,tcb-timer";
+		reg = <1>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.11.0
