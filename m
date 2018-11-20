From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 20 Nov 2018 13:59:43 -0200
Subject: [PATCH 2/4] ARM: dts: imx6ul: Fix memory node duplicaton
In-Reply-To: <1542729585-9330-1-git-send-email-festevam@gmail.com>
References: <1542729585-9330-1-git-send-email-festevam@gmail.com>
Message-ID: <1542729585-9330-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards based on imx6ul have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx6ul.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi        | 1 +
 arch/arm/boot/dts/imx6ul-geam.dts              | 1 +
 arch/arm/boot/dts/imx6ul-isiot.dtsi            | 1 +
 arch/arm/boot/dts/imx6ul-litesom.dtsi          | 1 +
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi          | 1 +
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts       | 1 +
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi            | 1 +
 arch/arm/boot/dts/imx6ul.dtsi                  | 2 --
 arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi | 1 +
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi    | 1 +
 10 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
index 32a0723..8180211 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dtsi
@@ -12,6 +12,7 @@
 	};
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6ul-geam.dts b/arch/arm/boot/dts/imx6ul-geam.dts
index e22ec5b..bc77f26 100644
--- a/arch/arm/boot/dts/imx6ul-geam.dts
+++ b/arch/arm/boot/dts/imx6ul-geam.dts
@@ -15,6 +15,7 @@
 	compatible = "engicam,imx6ul-geam", "fsl,imx6ul";
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x08000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6ul-isiot.dtsi b/arch/arm/boot/dts/imx6ul-isiot.dtsi
index b1fa3f0..213e802 100644
--- a/arch/arm/boot/dts/imx6ul-isiot.dtsi
+++ b/arch/arm/boot/dts/imx6ul-isiot.dtsi
@@ -10,6 +10,7 @@
 
 / {
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6ul-litesom.dtsi b/arch/arm/boot/dts/imx6ul-litesom.dtsi
index 8f775f6..8d68932 100644
--- a/arch/arm/boot/dts/imx6ul-litesom.dtsi
+++ b/arch/arm/boot/dts/imx6ul-litesom.dtsi
@@ -48,6 +48,7 @@
 	compatible = "grinn,imx6ul-litesom", "fsl,imx6ul";
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6ul-opos6ul.dtsi b/arch/arm/boot/dts/imx6ul-opos6ul.dtsi
index a031bee..cf7faf4 100644
--- a/arch/arm/boot/dts/imx6ul-opos6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-opos6ul.dtsi
@@ -49,6 +49,7 @@
 
 / {
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0>; /* will be filled by U-Boot */
 	};
 
diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
index 0c09420f..797262d 100644
--- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
@@ -53,6 +53,7 @@
 
 	/* Will be filled by the bootloader */
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index 02b5ba4..bb6dbfd 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -71,6 +71,7 @@
 	};
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0>; /* will be filled by U-Boot */
 	};
 
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index c71d2d6..99c3663 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -15,10 +15,8 @@
 	 * The decompressor and also some bootloaders rely on a
 	 * pre-existing /chosen node to be available to insert the
 	 * command line and merge other ATAGS info.
-	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec1;
diff --git a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
index 10ab469..fb213be 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi
@@ -7,6 +7,7 @@
 
 / {
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x10000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
index 183193e..038d8c90 100644
--- a/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
+++ b/arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi
@@ -7,6 +7,7 @@
 
 / {
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
 
-- 
2.7.4
