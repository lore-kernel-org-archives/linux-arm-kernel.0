From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  4 Jul 2017 19:02:13 +0200
Subject: [PATCH 2/2] ARM: dts: r8a7794: Add SMP support
In-Reply-To: <1499187733-1430-1-git-send-email-geert+renesas@glider.be>
References: <1499187733-1430-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499187733-1430-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the device tree node for the Advanced Power Management Unit (APMU).
Use the "enable-method" prop to  point out that the APMU should be used
for the SMP support.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index f32b458e93285adc..8afd04339c84c65e 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -37,6 +37,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
@@ -65,6 +66,12 @@
 		};
 	};
 
+	apmu at e6151000 {
+		compatible = "renesas,r8a7794-apmu", "renesas,apmu";
+		reg = <0 0xe6151000 0 0x188>;
+		cpus = <&cpu0 &cpu1>;
+	};
+
 	gic: interrupt-controller at f1001000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-- 
2.7.4
