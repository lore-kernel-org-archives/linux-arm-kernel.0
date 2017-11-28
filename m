From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Nov 2017 14:39:01 +0100
Subject: [PATCH v4] ARM: dts: r8a7794: Add SMP support
Message-ID: <1511876341-8639-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Add the device tree node for the Advanced Power Management Unit (APMU).
Use the "enable-method" prop to  point out that the APMU should be used
for the SMP support.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Dependency 3fd45a136ff61bb5 ("ARM: shmobile: rcar-gen2: Make sure
CNTVOFF is initialized on CA7/15") is part of v4.15-rc1.

v4:
  - Rebased against renesas-devel-20171127-v4.15-rc1,

v3:
  - No changes,

v2:
  - No changes.
---
 arch/arm/boot/dts/r8a7794.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index ef7fb1d2c3a31a6e..2437598ca2f5b034 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -37,6 +37,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "renesas,apmu";
 
 		cpu0: cpu at 0 {
 			device_type = "cpu";
@@ -66,6 +67,12 @@
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
