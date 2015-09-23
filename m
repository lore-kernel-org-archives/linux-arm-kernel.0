From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 23 Sep 2015 21:37:28 +0200
Subject: [PATCH 2/3] ARM: dts: stih407/410: Tidy up display nodes
In-Reply-To: <1443037049-6167-1-git-send-email-maxime.coquelin@st.com>
References: <1443037049-6167-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1443037049-6167-3-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The display nodes are common to both STiH407 and STiH410, move them to the
family file.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 13 +++++++++++++
 arch/arm/boot/dts/stih407.dtsi        | 13 -------------
 arch/arm/boot/dts/stih410.dtsi        | 13 -------------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 9975e8f..5b454d9 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -152,6 +152,19 @@
 					<ST_IRQ_SYSCFG_DISABLED>;
 		};
 
+		/* Display */
+		vtg_main: sti-vtg-main at 8d02800 {
+			compatible = "st,vtg";
+			reg = <0x8d02800 0x200>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_NONE>;
+		};
+
+		vtg_aux: sti-vtg-aux at 8d00200 {
+			compatible = "st,vtg";
+			reg = <0x8d00200 0x100>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_NONE>;
+		};
+
 		serial at 9830000 {
 			compatible = "st,asc";
 			reg = <0x9830000 0x2c>;
diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 3efa3b2..98c3468 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -10,19 +10,6 @@
 #include "stih407-family.dtsi"
 / {
 	soc {
-		/* Display */
-		vtg_main: sti-vtg-main at 8d02800 {
-			compatible = "st,vtg";
-			reg = <0x8d02800 0x200>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_NONE>;
-		};
-
-		vtg_aux: sti-vtg-aux at 8d00200 {
-			compatible = "st,vtg";
-			reg = <0x8d00200 0x100>;
-			interrupts = <GIC_SPI 109 IRQ_TYPE_NONE>;
-		};
-
 		sti-display-subsystem {
 			compatible = "st,sti-display-subsystem";
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 6f40bc9..23f4a48 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -85,19 +85,6 @@
 			phy-names = "usb";
 		};
 
-		/* Display */
-		vtg_main: sti-vtg-main at 8d02800 {
-			compatible = "st,vtg";
-			reg = <0x8d02800 0x200>;
-			interrupts = <GIC_SPI 108 IRQ_TYPE_NONE>;
-		};
-
-		vtg_aux: sti-vtg-aux at 8d00200 {
-			compatible = "st,vtg";
-			reg = <0x8d00200 0x100>;
-			interrupts = <GIC_SPI 109 IRQ_TYPE_NONE>;
-		};
-
 		sti-display-subsystem {
 			compatible = "st,sti-display-subsystem";
 			#address-cells = <1>;
-- 
1.9.1
