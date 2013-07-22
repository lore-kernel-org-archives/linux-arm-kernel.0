From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 Jul 2013 16:36:16 +0900
Subject: [PATCH 04/11] ARM: shmobile: Add GIO to EMEV2 dtsi
In-Reply-To: <cover.1374478037.git.horms+renesas@verge.net.au>
References: <cover.1374478037.git.horms+renesas@verge.net.au>
Message-ID: <12d035b13b224ee69886b64fd33d1c1224e79187.1374478037.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add GIO0->GIO4 device nodes to the EMEV2 dtsi file.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi | 59 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index c8a8c08..99ad2b2 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -14,6 +14,14 @@
 	compatible = "renesas,emev2";
 	interrupt-parent = <&gic>;
 
+	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -67,4 +75,55 @@
 		reg = <0xe1050000 0x38>;
 		interrupts = <0 11 0>;
 	};
+
+	gpio0: gpio at e0050000 {
+		compatible = "renesas,em-gio";
+		reg = <0xe0050000 0x2c>, <0xe0050040 0x20>;
+		interrupts = <0 67 0>, <0 68 0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <32>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+	gpio1: gpio at e0050080 {
+		compatible = "renesas,em-gio";
+		reg = <0xe0050080 0x2c>, <0xe00500c0 0x20>;
+		interrupts = <0 69 0>, <0 70 0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <32>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+	gpio2: gpio at e0050100 {
+		compatible = "renesas,em-gio";
+		reg = <0xe0050100 0x2c>, <0xe0050140 0x20>;
+		interrupts = <0 71 0>, <0 72 0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <32>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+	gpio3: gpio at e0050180 {
+		compatible = "renesas,em-gio";
+		reg = <0xe0050180 0x2c>, <0xe00501c0 0x20>;
+		interrupts = <0 73 0>, <0 74 0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <32>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+	gpio4: gpio at e0050200 {
+		compatible = "renesas,em-gio";
+		reg = <0xe0050200 0x2c>, <0xe0050240 0x20>;
+		interrupts = <0 75 0>, <0 76 0>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		ngpios = <31>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
 };
-- 
1.8.2.1
