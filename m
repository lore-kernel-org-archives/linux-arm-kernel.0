From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 19 Dec 2017 22:32:00 +0100
Subject: [PATCH 36/45] ARM: dts: at91: linea/tse850-3: use TCB0 as timers
In-Reply-To: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
Message-ID: <20171219213209.13823-37-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use tcb0 for timers as selected in sama5_defconfig.

Tested-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91-linea.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/at91-linea.dtsi b/arch/arm/boot/dts/at91-linea.dtsi
index 87e5090fb4c4..c7b964e25321 100644
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
2.15.1
