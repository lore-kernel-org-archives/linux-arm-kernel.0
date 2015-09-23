From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 23 Sep 2015 21:37:29 +0200
Subject: [PATCH 3/3] ARM: dts: stih410: Enable USB2.0 and related PHY nodes at
 board level
In-Reply-To: <1443037049-6167-1-git-send-email-maxime.coquelin@st.com>
References: <1443037049-6167-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <1443037049-6167-4-git-send-email-maxime.coquelin@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A borad might not expose the USB2.0 ports, so disable them by default in SoC
file, and enable them in b2120 board.

Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih410-b2120.dts | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/stih410.dtsi      | 12 ++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 16f02c5..8af1e73 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -35,5 +35,29 @@
 			sd-uhs-sdr104;
 			sd-uhs-ddr50;
 		};
+
+		usb2_picophy1: phy2 {
+			status = "okay";
+		};
+
+		usb2_picophy2: phy3 {
+			status = "okay";
+		};
+
+		ohci0: usb at 9a03c00 {
+			status = "okay";
+		};
+
+		ehci0: usb at 9a03e00 {
+			status = "okay";
+		};
+
+		ohci1: usb at 9a83c00 {
+			status = "okay";
+		};
+
+		ehci1: usb at 9a83e00 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index 23f4a48..e3150e3 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -22,6 +22,8 @@
 			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
 				 <&picophyreset STIH407_PICOPHY0_RESET>;
 			reset-names = "global", "port";
+
+			status = "disabled";
 		};
 
 		usb2_picophy2: phy3 {
@@ -31,6 +33,8 @@
 			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
 				 <&picophyreset STIH407_PICOPHY1_RESET>;
 			reset-names = "global", "port";
+
+			status = "disabled";
 		};
 
 		ohci0: usb at 9a03c00 {
@@ -43,6 +47,8 @@
 			reset-names = "power", "softreset";
 			phys = <&usb2_picophy1>;
 			phy-names = "usb";
+
+			status = "disabled";
 		};
 
 		ehci0: usb at 9a03e00 {
@@ -57,6 +63,8 @@
 			reset-names = "power", "softreset";
 			phys = <&usb2_picophy1>;
 			phy-names = "usb";
+
+			status = "disabled";
 		};
 
 		ohci1: usb at 9a83c00 {
@@ -69,6 +77,8 @@
 			reset-names = "power", "softreset";
 			phys = <&usb2_picophy2>;
 			phy-names = "usb";
+
+			status = "disabled";
 		};
 
 		ehci1: usb at 9a83e00 {
@@ -83,6 +93,8 @@
 			reset-names = "power", "softreset";
 			phys = <&usb2_picophy2>;
 			phy-names = "usb";
+
+			status = "disabled";
 		};
 
 		sti-display-subsystem {
-- 
1.9.1
