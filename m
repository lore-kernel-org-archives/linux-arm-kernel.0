From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 19 Jan 2015 14:05:12 +0100
Subject: [PATCH v2] ARM: dts: sunxi: Add simplefb nodes for de_be0-lcd0,
 de_be0-lcd0-tve0 pipelines
In-Reply-To: <1421672712-13298-1-git-send-email-hdegoede@redhat.com>
References: <1421672712-13298-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1421672712-13298-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simplefb nodes for "[de_fe0-]de_be0-lcd0" and "[de_fe0-]de_be0-lcd0-tve0"
display pipelines for when u-boot has set up a pipeline to drive a LCD panel /
VGA output rather then the HDMI output.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  | 18 ++++++++++++++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi |  8 ++++++++
 arch/arm/boot/dts/sun5i-a13.dtsi  | 14 ++++++++++++++
 arch/arm/boot/dts/sun6i-a31.dtsi  |  8 ++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi  | 17 +++++++++++++++++
 arch/arm/boot/dts/sun8i-a23.dtsi  | 14 ++++++++++++++
 6 files changed, 79 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ccd60e3..a033ece 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -52,6 +52,24 @@
 				 <&ahb_gates 44>, <&ahb_gates 46>;
 			status = "disabled";
 		};
+
+		framebuffer at 2 {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "de_fe0-de_be0-lcd0";
+			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>,
+				 <&ahb_gates 46>;
+			status = "disabled";
+		};
+
+		framebuffer at 3 {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
+			clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
+				 <&ahb_gates 44>, <&ahb_gates 46>;
+			status = "disabled";
+		};
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 8cc6ec9..678fbc3 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -39,6 +39,14 @@
 				 <&ahb_gates 44>;
 			status = "disabled";
 		};
+
+		framebuffer at 1 {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "de_be0-lcd0";
+			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>;
+			status = "disabled";
+		};
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 005c31a..34d9138 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -26,6 +26,20 @@
 		serial1 = &uart3;
 	};
 
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer at 0 {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "de_be0-lcd0";
+			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>;
+			status = "disabled";
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index a516522..f226ff0 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -77,6 +77,14 @@
 			clocks = <&pll6 0>;
 			status = "disabled";
 		};
+
+		framebuffer at 1 {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "de_be0-lcd0";
+			clocks = <&pll6 0>;
+			status = "disabled";
+		};
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index f3a74e2..8d888f4 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -82,6 +82,23 @@
 				 <&ahb_gates 44>;
 			status = "disabled";
 		};
+
+		framebuffer at 1 {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "de_be0-lcd0";
+			clocks = <&pll5 1>, <&ahb_gates 36>, <&ahb_gates 44>;
+			status = "disabled";
+		};
+
+		framebuffer at 2 {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "de_be0-lcd0-tve0";
+			clocks = <&pll5 1>, <&ahb_gates 34>, <&ahb_gates 36>,
+				 <&ahb_gates 44>;
+			status = "disabled";
+		};
 	};
 
 	cpus {
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 8663229..c2ceafb 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -65,6 +65,20 @@
 		serial5 = &r_uart;
 	};
 
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer at 0 {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "de_be0-lcd0";
+			clocks = <&pll6 0>;
+			status = "disabled";
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.1.0
