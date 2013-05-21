From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 21 May 2013 14:14:27 +0200
Subject: [PATCH v4 06/21] ARM: shmobile: r8a7778: Add GPIO controller devices
 to device tree
In-Reply-To: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1369138482-5871-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add GPIO controller nodes to the r8a7778 core device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7778.dtsi | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index c8dbf14..0639e8b 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -33,8 +33,59 @@
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
+	};
+
 	pfc: pfc at fffc0000 {
 		compatible = "renesas,pfc-r8a7778";
 		reg = <0xfffc000 0x118>;
+		#gpio-range-cells = <3>;
 	};
 };
-- 
1.8.1.5
