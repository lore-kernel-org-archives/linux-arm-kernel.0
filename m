From: vz@mleia.com (Vladimir Zapolskiy)
Date: Fri, 20 Nov 2015 03:05:04 +0200
Subject: [PATCH 04/11] arm: dts: lpc32xx: add device nodes for external
 oscillators
In-Reply-To: <1447981511-29653-1-git-send-email-vz@mleia.com>
References: <1447981511-29653-1-git-send-email-vz@mleia.com>
Message-ID: <1447981511-29653-5-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NXP LPC32xx SoC has two external oscillators - one is mandatory and
always on 32768 Hz oscillator and one optional 10-20MHz oscillator,
which is practically always present on LPC32xx boards, because its
presence is needed to supply USB controller clock and by default it
supplies ARM and most of the peripheral clocks, LPC32xx User's Manual
references it as a main oscillator.

The change adds device nodes for both oscillators, frequency of
the main oscillator is selected to be 13MHz by default, this variant
is found on all LPC32xx reference boards.

The device nodes for external oscillators are needed to describe input
clocks of LPC32xx clock controller.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index c85cf97..a9f2d9a 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -28,6 +28,22 @@
 		};
 	};
 
+	clocks {
+		xtal_32k: xtal_32k {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+			clock-output-names = "xtal_32k";
+		};
+
+		xtal: xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <13000000>;
+			clock-output-names = "xtal";
+		};
+	};
+
 	ahb {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.1.4
