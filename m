From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 22 Feb 2018 14:16:35 -0300
Subject: [PATCH] ARM: dts: imx6: Pass memory unit-adress
Message-ID: <1519319795-18161-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Pass the memory unit-adress to fix the following build warnings with W=1:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

There are cases where dts passes an empty memory node, which will be filled
by the bootloader. Passing the memory base address still allows the 
bootloader to fill the memory size.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts   | 4 ++--
 arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts     | 4 ++--
 arch/arm/boot/dts/imx6dl-ts4900.dts            | 4 ++--
 arch/arm/boot/dts/imx6dl-ts7970.dts            | 4 ++--
 arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts      | 4 ++--
 arch/arm/boot/dts/imx6q-h100.dts               | 4 ++--
 arch/arm/boot/dts/imx6q-novena.dts             | 4 ++--
 arch/arm/boot/dts/imx6q-ts4900.dts             | 4 ++--
 arch/arm/boot/dts/imx6q-ts7970.dts             | 4 ++--
 arch/arm/boot/dts/imx6q-zii-rdu2.dts           | 4 ++--
 arch/arm/boot/dts/imx6qdl-apalis.dtsi          | 4 ++--
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi         | 4 ++--
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi    | 4 ++--
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi   | 4 ++--
 arch/arm/boot/dts/imx6qdl-tx6.dtsi             | 4 ++--
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts          | 4 ++--
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi            | 4 ++--
 arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi | 2 +-
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi    | 2 +-
 19 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index 700e129..d565d32 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -54,8 +54,8 @@
 		     "fsl,imx6dl";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 
 	aliases {
diff --git a/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts b/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
index c195ad6..89384cb 100644
--- a/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
+++ b/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
@@ -22,7 +22,7 @@
 	compatible = "dfi,fs700-m60-6dl", "dfi,fs700e-m60", "fsl,imx6dl";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-ts4900.dts b/arch/arm/boot/dts/imx6dl-ts4900.dts
index e23f789..cc01a7a 100644
--- a/arch/arm/boot/dts/imx6dl-ts4900.dts
+++ b/arch/arm/boot/dts/imx6dl-ts4900.dts
@@ -48,7 +48,7 @@
 	compatible = "technologic,imx6dl-ts4900", "fsl,imx6dl";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-ts7970.dts b/arch/arm/boot/dts/imx6dl-ts7970.dts
index cae3313..82435d5 100644
--- a/arch/arm/boot/dts/imx6dl-ts7970.dts
+++ b/arch/arm/boot/dts/imx6dl-ts7970.dts
@@ -49,7 +49,7 @@
 	compatible = "technologic,imx6dl-ts7970", "fsl,imx6dl";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts b/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
index a266fe6..ad12d76 100644
--- a/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
+++ b/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
@@ -22,7 +22,7 @@
 	compatible = "dfi,fs700-m60-6qd", "dfi,fs700e-m60", "fsl,imx6q";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6q-h100.dts b/arch/arm/boot/dts/imx6q-h100.dts
index dd24b46..714e09e0 100644
--- a/arch/arm/boot/dts/imx6q-h100.dts
+++ b/arch/arm/boot/dts/imx6q-h100.dts
@@ -50,8 +50,8 @@
 	compatible = "auvidea,h100", "fsl,imx6q";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 
 	aliases {
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index 43a0c32..52f3937 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -56,8 +56,8 @@
 	compatible = "kosagi,imx6q-novena", "fsl,imx6q";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/imx6q-ts4900.dts b/arch/arm/boot/dts/imx6q-ts4900.dts
index 9cf7b37..e655107 100644
--- a/arch/arm/boot/dts/imx6q-ts4900.dts
+++ b/arch/arm/boot/dts/imx6q-ts4900.dts
@@ -48,8 +48,8 @@
 	compatible = "technologic,imx6q-ts4900", "fsl,imx6q";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6q-ts7970.dts b/arch/arm/boot/dts/imx6q-ts7970.dts
index fd84fc5..c615ac4 100644
--- a/arch/arm/boot/dts/imx6q-ts7970.dts
+++ b/arch/arm/boot/dts/imx6q-ts7970.dts
@@ -49,8 +49,8 @@
 	compatible = "technologic,imx6q-ts7970", "fsl,imx6q";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6q-zii-rdu2.dts b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
index fe8b12f..7da6dde 100644
--- a/arch/arm/boot/dts/imx6q-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
@@ -49,7 +49,7 @@
 	compatible = "zii,imx6q-zii-rdu2", "fsl,imx6q";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index bd658db..8206683 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -48,8 +48,8 @@
 	compatible = "toradex,apalis_imx6q", "fsl,imx6q";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 
 	backlight: backlight {
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index 4c5f513..9332a31 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -43,8 +43,8 @@
 
 / {
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 
 	ir_recv: ir-receiver {
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 52eeeed..6684b37 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -41,8 +41,8 @@
 
 / {
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index e68e7db..bfbf663 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -41,8 +41,8 @@
 
 / {
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 
 	chosen {
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index 6abb66c..f015e2d 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -61,8 +61,8 @@
 		sdhc1 = &usdhc2;
 	};
 
-	memory {
-		reg = <0 0>; /* will be filled by U-Boot */
+	memory at 10000000 {
+		reg = <0x10000000 0>; /* will be filled by U-Boot */
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
index 96ab983..de5b50d 100644
--- a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
@@ -49,7 +49,7 @@
 	compatible = "zii,imx6qp-zii-rdu2", "fsl,imx6qp";
 
 	/* Will be filled by the bootloader */
-	memory {
-		reg = <0 0>;
+	memory at 10000000 {
+		reg = <0x10000000 0>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index 65111f98..f678d18 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -70,8 +70,8 @@
 		stdout-path = &uart1;
 	};
 
-	memory {
-		reg = <0 0>; /* will be filled by U-Boot */
+	memory at 80000000 {
+		reg = <0x80000000 0>; /* will be filled by U-Boot */
 	};
 
 	clocks {
diff --git a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
index cfda666..10ab469 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
@@ -6,7 +6,7 @@
 #include "imx6ull-colibri.dtsi"
 
 / {
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x10000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
index f48291b..3dffbcd 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
@@ -6,7 +6,7 @@
 #include "imx6ull-colibri.dtsi"
 
 / {
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
-- 
2.7.4
