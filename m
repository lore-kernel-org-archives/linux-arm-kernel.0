From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Wed, 10 Jan 2018 09:21:06 +0100
Subject: [PATCH 5/7] ARM: dts: STi: Move usb2_picophyX nodes without reg
 property out of soc
In-Reply-To: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
References: <1515572469-19276-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1515572469-19276-7-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Move usb2_picophyX nodes outside from soc node, this allows to fix
the following warning when compiling dtb with W=1 option :

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/phy2 missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/phy3 missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/phy2 missing or empty reg/ranges property
arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /soc/phy3 missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/phy2 missing or empty reg/ranges property
arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /soc/phy3 missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih410-b2120.dts | 16 +++++++--------
 arch/arm/boot/dts/stih410-b2260.dts | 16 +++++++--------
 arch/arm/boot/dts/stih410.dtsi      | 40 ++++++++++++++++++-------------------
 arch/arm/boot/dts/stih418.dtsi      | 34 +++++++++++++++----------------
 4 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 37a42af..8a03ade 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -28,6 +28,14 @@
 		ethernet0 = &ethernet0;
 	};
 
+	usb2_picophy1: phy2 {
+		status = "okay";
+	};
+
+	usb2_picophy2: phy3 {
+		status = "okay";
+	};
+
 	soc {
 
 		mmc0: sdhci at 9060000 {
@@ -37,14 +45,6 @@
 			sd-uhs-ddr50;
 		};
 
-		usb2_picophy1: phy2 {
-			status = "okay";
-		};
-
-		usb2_picophy2: phy3 {
-			status = "okay";
-		};
-
 		ohci0: usb at 9a03c00 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 69c2abc..a2d1e54 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -57,6 +57,14 @@
 		};
 	};
 
+	usb2_picophy1: phy2 {
+		status = "okay";
+	};
+
+	usb2_picophy2: phy3 {
+		status = "okay";
+	};
+
 	soc {
 		/* Low speed expansion connector */
 		uart0: serial at 9830000 {
@@ -127,14 +135,6 @@
 			status = "okay";
 		};
 
-		usb2_picophy1: phy2 {
-			status = "okay";
-		};
-
-		usb2_picophy2: phy3 {
-			status = "okay";
-		};
-
 		ohci0: usb at 9a03c00 {
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index e4b7e3d..a76fee9 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -15,29 +15,29 @@
 		bdisp0 = &bdisp0;
 	};
 
-	soc {
-		usb2_picophy1: phy2 {
-			compatible = "st,stih407-usb2-phy";
-			#phy-cells = <0>;
-			st,syscfg = <&syscfg_core 0xf8 0xf4>;
-			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
-				 <&picophyreset STIH407_PICOPHY0_RESET>;
-			reset-names = "global", "port";
-
-			status = "disabled";
-		};
+	usb2_picophy1: phy2 {
+		compatible = "st,stih407-usb2-phy";
+		#phy-cells = <0>;
+		st,syscfg = <&syscfg_core 0xf8 0xf4>;
+		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+		 <&picophyreset STIH407_PICOPHY0_RESET>;
+		reset-names = "global", "port";
+
+		status = "disabled";
+	};
 
-		usb2_picophy2: phy3 {
-			compatible = "st,stih407-usb2-phy";
-			#phy-cells = <0>;
-			st,syscfg = <&syscfg_core 0xfc 0xf4>;
-			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
-				 <&picophyreset STIH407_PICOPHY1_RESET>;
-			reset-names = "global", "port";
+	usb2_picophy2: phy3 {
+		compatible = "st,stih407-usb2-phy";
+		#phy-cells = <0>;
+		st,syscfg = <&syscfg_core 0xfc 0xf4>;
+		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+			 <&picophyreset STIH407_PICOPHY1_RESET>;
+		reset-names = "global", "port";
 
-			status = "disabled";
-		};
+		status = "disabled";
+	};
 
+	soc {
 		ohci0: usb at 9a03c00 {
 			compatible = "st,st-ohci-300x";
 			reg = <0x9a03c00 0x100>;
diff --git a/arch/arm/boot/dts/stih418.dtsi b/arch/arm/boot/dts/stih418.dtsi
index e6525ab..b3912a3 100644
--- a/arch/arm/boot/dts/stih418.dtsi
+++ b/arch/arm/boot/dts/stih418.dtsi
@@ -29,25 +29,25 @@
 		};
 	};
 
-	soc {
-		usb2_picophy1: phy2 {
-			compatible = "st,stih407-usb2-phy";
-			#phy-cells = <0>;
-			st,syscfg = <&syscfg_core 0xf8 0xf4>;
-			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
-				 <&picophyreset STIH407_PICOPHY0_RESET>;
-			reset-names = "global", "port";
-		};
+	usb2_picophy1: phy2 {
+		compatible = "st,stih407-usb2-phy";
+		#phy-cells = <0>;
+		st,syscfg = <&syscfg_core 0xf8 0xf4>;
+		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+			 <&picophyreset STIH407_PICOPHY0_RESET>;
+		reset-names = "global", "port";
+	};
 
-		usb2_picophy2: phy3 {
-			compatible = "st,stih407-usb2-phy";
-			#phy-cells = <0>;
-			st,syscfg = <&syscfg_core 0xfc 0xf4>;
-			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
-				 <&picophyreset STIH407_PICOPHY1_RESET>;
-			reset-names = "global", "port";
-		};
+	usb2_picophy2: phy3 {
+		compatible = "st,stih407-usb2-phy";
+		#phy-cells = <0>;
+		st,syscfg = <&syscfg_core 0xfc 0xf4>;
+		resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+			 <&picophyreset STIH407_PICOPHY1_RESET>;
+		reset-names = "global", "port";
+	};
 
+	soc {
 		ohci0: usb at 9a03c00 {
 			compatible = "st,st-ohci-300x";
 			reg = <0x9a03c00 0x100>;
-- 
1.9.1
