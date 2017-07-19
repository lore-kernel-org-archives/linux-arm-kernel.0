From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 20 Jul 2017 00:10:17 +0800
Subject: [PATCH 3/5] arm64: allwinner: a64: add AXP803 PMIC to SoPine DTSI
In-Reply-To: <20170719161019.62133-1-icenowy@aosc.io>
References: <20170719161019.62133-1-icenowy@aosc.io>
Message-ID: <20170719161019.62133-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoPine SoM has an AXP803 PMIC connected to the RSB bus of the A64
SoC.

Add its device tree node to the DTSI.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 475518b031dd..ab9464dd50c5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -63,3 +63,14 @@
 	bus-width = <4>;
 	status = "okay";
 };
+
+&r_rsb {
+	status = "okay";
+
+	axp803: pmic at 3a3 {
+		compatible = "x-powers,axp803";
+		reg = <0x3a3>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
-- 
2.13.0
