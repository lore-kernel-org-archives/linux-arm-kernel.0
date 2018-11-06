From: festevam@gmail.com (Fabio Estevam)
Date: Tue,  6 Nov 2018 13:40:47 -0200
Subject: [PATCH 3/3] ARM: dts: imx7: Fix memory node duplicaton
In-Reply-To: <1541518847-5640-1-git-send-email-festevam@gmail.com>
References: <1541518847-5640-1-git-send-email-festevam@gmail.com>
Message-ID: <1541518847-5640-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards based on imx7 have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx7s.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts   | 3 ++-
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi | 1 +
 arch/arm/boot/dts/imx7d-colibri.dtsi      | 1 +
 arch/arm/boot/dts/imx7d-nitrogen7.dts     | 1 +
 arch/arm/boot/dts/imx7d-pico.dtsi         | 1 +
 arch/arm/boot/dts/imx7d-sdb.dts           | 1 +
 arch/arm/boot/dts/imx7s-colibri.dtsi      | 1 +
 arch/arm/boot/dts/imx7s-warp.dts          | 1 +
 arch/arm/boot/dts/imx7s.dtsi              | 2 --
 9 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 8bf365d..e615674 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -19,6 +19,7 @@
 	compatible = "compulab,cl-som-imx7", "fsl,imx7d";
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB - minimal configuration */
 	};
 
@@ -284,4 +285,4 @@
 			MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x14 /* OTG PWREN */
 		>;
 	};
-};
\ No newline at end of file
+};
diff --git a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
index 04d24ee..898f4b8 100644
--- a/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri-emmc.dtsi
@@ -8,6 +8,7 @@
 
 / {
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/imx7d-colibri.dtsi
index d9f8fb6..e2e327f 100644
--- a/arch/arm/boot/dts/imx7d-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7d-colibri.dtsi
@@ -45,6 +45,7 @@
 
 / {
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index d8aac4a..4fb7e84 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -12,6 +12,7 @@
 	compatible = "boundary,imx7d-nitrogen7", "fsl,imx7d";
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x40000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx7d-pico.dtsi b/arch/arm/boot/dts/imx7d-pico.dtsi
index 21973eb..4846df0 100644
--- a/arch/arm/boot/dts/imx7d-pico.dtsi
+++ b/arch/arm/boot/dts/imx7d-pico.dtsi
@@ -49,6 +49,7 @@
 	compatible = "technexion,imx7d-pico", "fsl,imx7d";
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index f1bafda..b1b613b 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -15,6 +15,7 @@
 	};
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x80000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx7s-colibri.dtsi b/arch/arm/boot/dts/imx7s-colibri.dtsi
index fe8344c..1fb1ec5 100644
--- a/arch/arm/boot/dts/imx7s-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7s-colibri.dtsi
@@ -45,6 +45,7 @@
 
 / {
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x10000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index f7ba2c0..23431fa 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -14,6 +14,7 @@
 	compatible = "warp,imx7s-warp", "fsl,imx7s";
 
 	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index aa8df7d..477901c 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -17,10 +17,8 @@
 	 * The decompressor and also some bootloaders rely on a
 	 * pre-existing /chosen node to be available to insert the
 	 * command line and merge other ATAGS info.
-	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; };
 
 	aliases {
 		gpio0 = &gpio1;
-- 
2.7.4
