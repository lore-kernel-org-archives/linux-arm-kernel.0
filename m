From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 09:32:31 +0900
Subject: [PATCH 04/19] ARM: shmobile: r8a7778: Add GPIO controller devices to
 device tree
In-Reply-To: <cover.1374625203.git.horms+renesas@verge.net.au>
References: <cover.1374625203.git.horms+renesas@verge.net.au>
Message-ID: <aaf7eda80cb8371bbf26d7171241cfb94b787b0f.1374625203.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add GPIO controller nodes to the r8a7778 core device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 61 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index c8dbf14..45ac404 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -33,8 +33,69 @@
 		      <0xfe430000 0x100>;
 	};
 
+	gpio0: gpio at ffc40000 {
+		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		reg = <0xffc40000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 103 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 0 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio1: gpio at ffc41000 {
+		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		reg = <0xffc41000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 103 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 32 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio2: gpio at ffc42000 {
+		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		reg = <0xffc42000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 103 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 64 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio3: gpio at ffc43000 {
+		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		reg = <0xffc43000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 103 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 96 32>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
+	gpio4: gpio at ffc44000 {
+		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";
+		reg = <0xffc44000 0x2c>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 103 0x4>;
+		#gpio-cells = <2>;
+		gpio-controller;
+		gpio-ranges = <&pfc 0 128 27>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+	};
+
 	pfc: pfc at fffc0000 {
 		compatible = "renesas,pfc-r8a7778";
 		reg = <0xfffc000 0x118>;
+		#gpio-range-cells = <3>;
 	};
 };
-- 
1.8.2.1
