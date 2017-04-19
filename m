From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 19 Apr 2017 10:37:37 +0200
Subject: [PATCH v2] arm64: dts: r8a7795: salvator-x: Add current sense
 amplifiers
In-Reply-To: <1492590950-10534-1-git-send-email-geert+renesas@glider.be>
References: <1492590950-10534-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1492591057-10674-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device nodes for two Maxim max961x current sense amplifiers
sensing the VDD_0.8V and DVFS_0.8V lines.

Based on a patch for r8a7796-salvator-x.dts by Jacopo Mondi.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Bindings and driver are now in staging-next.

v2:
  - Use shunt-resistor-micro-ohms to match updated bindings.
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index ff68bac4cd7ed2f5..bd6cccb0d4a75561 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -415,6 +415,24 @@
 	};
 };
 
+&i2c4 {
+	status = "okay";
+
+	csa_vdd: adc at 7c {
+		compatible = "maxim,max9611";
+		reg = <0x7c>;
+
+		shunt-resistor-micro-ohms = <5000>;
+	};
+
+	csa_dvfs: adc at 7f {
+		compatible = "maxim,max9611";
+		reg = <0x7f>;
+
+		shunt-resistor-micro-ohms = <5000>;
+	};
+};
+
 &rcar_sound {
 	pinctrl-0 = <&sound_pins &sound_clk_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
