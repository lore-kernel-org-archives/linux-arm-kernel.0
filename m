From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 21 Jan 2015 12:04:23 +0100
Subject: [PATCH] ARM: sunxi: dt: Fix aliases
Message-ID: <1421838263-20332-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f77d55a3b56a ("serial: 8250_dw: get index of serial line from DT
aliases") made the serial driver now use the serial aliases to get the tty
number, pointing out that our aliases have been wrong all along.

Remove them from the DTSI and add custom ones in the relevant boards.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi                 | 12 ------------
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  6 ++++++
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  8 --------
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts         |  4 ++++
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts  |  4 ++++
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts        |  4 ++++
 arch/arm/boot/dts/sun5i-a13.dtsi                 |  5 -----
 arch/arm/boot/dts/sun6i-a31.dtsi                 | 10 ----------
 arch/arm/boot/dts/sun7i-a20-bananapi.dts         |  6 ++++++
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts      |  8 ++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts  |  3 +++
 arch/arm/boot/dts/sun7i-a20.dtsi                 | 12 ------------
 arch/arm/boot/dts/sun8i-a23.dtsi                 |  9 ---------
 arch/arm/boot/dts/sun9i-a80-optimus.dts          |  5 +++++
 arch/arm/boot/dts/sun9i-a80.dtsi                 | 10 ----------
 15 files changed, 40 insertions(+), 66 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index e3422309e54b..e20a5855bef8 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -15,18 +15,6 @@
 / {
 	interrupt-parent = <&intc>;
 
-	aliases {
-		ethernet0 = &emac;
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-		serial4 = &uart4;
-		serial5 = &uart5;
-		serial6 = &uart6;
-		serial7 = &uart7;
-	};
-
 	chosen {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index fe3c559ca6a8..bfa742817690 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -55,6 +55,12 @@
 	model = "Olimex A10s-Olinuxino Micro";
 	compatible = "olimex,a10s-olinuxino-micro", "allwinner,sun5i-a10s";
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart2;
+		serial2 = &uart3;
+	};
+
 	soc at 01c00000 {
 		emac: ethernet at 01c0b000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 3c3c1920788a..c67e39b4ccb9 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -16,14 +16,6 @@
 / {
 	interrupt-parent = <&intc>;
 
-	aliases {
-		ethernet0 = &emac;
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-	};
-
 	chosen {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
index eeed1f236ee8..c7be3abd9fcc 100644
--- a/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
+++ b/arch/arm/boot/dts/sun5i-a13-hsg-h702.dts
@@ -53,6 +53,10 @@
 	model = "HSG H702";
 	compatible = "hsg,h702", "allwinner,sun5i-a13";
 
+	aliases {
+		serial0 = &uart1;
+	};
+
 	soc at 01c00000 {
 		mmc0: mmc at 01c0f000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
index 916ee8bb826f..3decefb3c37a 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts
@@ -54,6 +54,10 @@
 	model = "Olimex A13-Olinuxino Micro";
 	compatible = "olimex,a13-olinuxino-micro", "allwinner,sun5i-a13";
 
+	aliases {
+		serial0 = &uart1;
+	};
+
 	soc at 01c00000 {
 		mmc0: mmc at 01c0f000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
index e31d291d14cb..b421f7fa197b 100644
--- a/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
+++ b/arch/arm/boot/dts/sun5i-a13-olinuxino.dts
@@ -55,6 +55,10 @@
 	model = "Olimex A13-Olinuxino";
 	compatible = "olimex,a13-olinuxino", "allwinner,sun5i-a13";
 
+	aliases {
+		serial0 = &uart1;
+	};
+
 	soc at 01c00000 {
 		mmc0: mmc at 01c0f000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 2448d7f38d6b..c556688f8b8b 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -16,11 +16,6 @@
 / {
 	interrupt-parent = <&intc>;
 
-	aliases {
-		serial0 = &uart1;
-		serial1 = &uart3;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index f47156b6572b..f823e8cd6d61 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -52,16 +52,6 @@
 / {
 	interrupt-parent = <&gic>;
 
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-		serial4 = &uart4;
-		serial5 = &uart5;
-		ethernet0 = &gmac;
-	};
-
 	chosen {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 1cf1214cc068..bd7b15add697 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -55,6 +55,12 @@
 	model = "LeMaker Banana Pi";
 	compatible = "lemaker,bananapi", "allwinner,sun7i-a20";
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart3;
+		serial2 = &uart7;
+	};
+
 	soc at 01c00000 {
 		spi0: spi at 01c05000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index 0e4bfa3b2b85..0bcefcbbb756 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -19,6 +19,14 @@
 	model = "Merrii A20 Hummingbird";
 	compatible = "merrii,a20-hummingbird", "allwinner,sun7i-a20";
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart2;
+		serial2 = &uart3;
+		serial3 = &uart4;
+		serial4 = &uart5;
+	};
+
 	soc at 01c00000 {
 		mmc0: mmc at 01c0f000 {
 			pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 9d669cdf031d..66cc77707198 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -20,6 +20,9 @@
 	compatible = "olimex,a20-olinuxino-micro", "allwinner,sun7i-a20";
 
 	aliases {
+		serial0 = &uart0;
+		serial1 = &uart6;
+		serial2 = &uart7;
 		spi0 = &spi1;
 		spi1 = &spi2;
 	};
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e21ce5992d56..cab0eab179df 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -52,18 +52,6 @@
 / {
 	interrupt-parent = <&gic>;
 
-	aliases {
-		ethernet0 = &gmac;
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-		serial4 = &uart4;
-		serial5 = &uart5;
-		serial6 = &uart6;
-		serial7 = &uart7;
-	};
-
 	chosen {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 0746cd1024d7..86584fcf5e32 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -52,15 +52,6 @@
 / {
 	interrupt-parent = <&gic>;
 
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-		serial4 = &uart4;
-		serial5 = &r_uart;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 506948f582ee..11ec71072e81 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -54,6 +54,11 @@
 	model = "Merrii A80 Optimus Board";
 	compatible = "merrii,a80-optimus", "allwinner,sun9i-a80";
 
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart4;
+	};
+
 	chosen {
 		bootargs = "earlyprintk console=ttyS0,115200";
 	};
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 494714f67b57..9ef4438206a9 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -52,16 +52,6 @@
 / {
 	interrupt-parent = <&gic>;
 
-	aliases {
-		serial0 = &uart0;
-		serial1 = &uart1;
-		serial2 = &uart2;
-		serial3 = &uart3;
-		serial4 = &uart4;
-		serial5 = &uart5;
-		serial6 = &r_uart;
-	};
-
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.2.2
