From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  3 Mar 2018 19:40:41 -0300
Subject: [PATCH v2 2/5] ARM: dts: vf: Add memory node unit name
In-Reply-To: <1520116844-1145-1-git-send-email-festevam@gmail.com>
References: <1520116844-1145-1-git-send-email-festevam@gmail.com>
Message-ID: <1520116844-1145-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Include memory node unit name in order to fix the following W=1
warnings:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Stefan Agner <stefan@agner.ch>
---
Changes since v1:
- None

 arch/arm/boot/dts/vf500-colibri.dtsi  | 2 +-
 arch/arm/boot/dts/vf610-colibri.dtsi  | 2 +-
 arch/arm/boot/dts/vf610-cosmic.dts    | 2 +-
 arch/arm/boot/dts/vf610-twr.dts       | 2 +-
 arch/arm/boot/dts/vf610-zii-dev.dtsi  | 2 +-
 arch/arm/boot/dts/vf610m4-colibri.dts | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi b/arch/arm/boot/dts/vf500-colibri.dtsi
index 515c4d2f..2e7e3ce 100644
--- a/arch/arm/boot/dts/vf500-colibri.dtsi
+++ b/arch/arm/boot/dts/vf500-colibri.dtsi
@@ -46,7 +46,7 @@
 	model = "Toradex Colibri VF50 COM";
 	compatible = "toradex,vf610-colibri_vf50", "fsl,vf500";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
index 395812c..aeaf99f 100644
--- a/arch/arm/boot/dts/vf610-colibri.dtsi
+++ b/arch/arm/boot/dts/vf610-colibri.dtsi
@@ -46,7 +46,7 @@
 	model = "Toradex Colibri VF61 COM";
 	compatible = "toradex,vf610-colibri_vf61", "fsl,vf610";
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x10000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/vf610-cosmic.dts b/arch/arm/boot/dts/vf610-cosmic.dts
index 5447f25..a3014e8 100644
--- a/arch/arm/boot/dts/vf610-cosmic.dts
+++ b/arch/arm/boot/dts/vf610-cosmic.dts
@@ -19,7 +19,7 @@
 		bootargs = "console=ttyLP1,115200";
 	};
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x10000000>;
 	};
 
diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
index 6f787e67..6be7a82 100644
--- a/arch/arm/boot/dts/vf610-twr.dts
+++ b/arch/arm/boot/dts/vf610-twr.dts
@@ -50,7 +50,7 @@
 		bootargs = "console=ttyLP1,115200";
 	};
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index aadd36d..4890b8a 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -49,7 +49,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory {
+	memory at 80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 
diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
index 7198e8c..2b237ef 100644
--- a/arch/arm/boot/dts/vf610m4-colibri.dts
+++ b/arch/arm/boot/dts/vf610m4-colibri.dts
@@ -54,7 +54,7 @@
 		linux,stdout-path = "&uart2";
 	};
 
-	memory {
+	memory at 8c000000 {
 		reg = <0x8c000000 0x3000000>;
 	};
 };
-- 
2.7.4
