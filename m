From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Sat, 15 Oct 2016 17:23:40 +0200
Subject: [PATCH] ARM: dts: sunxi: Add cpu-supply for Olimex A20 EVB
Message-ID: <20161015152340.43315-1-manu@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun7i-a20-olimex-som-evb.dts doesn't contain cpu-supply needed for
voltage-scaling with cpufreq-dt so define it.
The default voltages are defined in sun7i-a20.dtsi.

Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index 23aacce..134e0c1 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -88,6 +88,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &codec {
 	status = "okay";
 };
-- 
2.9.2
