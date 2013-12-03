From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  3 Dec 2013 20:51:44 +0100
Subject: [PATCH 1/2] ARM: DT: Kirkwood: Use symbolic names from input.h
Message-ID: <1386100305-31280-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the numeric key value with a symbolic name from
<bt-bindings/input/input.h>

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-cloudbox.dts                | 2 +-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi                  | 6 +++---
 arch/arm/boot/dts/kirkwood-ib62x0.dts                  | 4 ++--
 arch/arm/boot/dts/kirkwood-iconnect.dts                | 4 ++--
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts          | 6 +++---
 arch/arm/boot/dts/kirkwood-lsxl.dtsi                   | 6 +++---
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts         | 4 ++--
 arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 6 +++---
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi             | 2 +-
 arch/arm/boot/dts/kirkwood-nsa310.dts                  | 6 +++---
 arch/arm/boot/dts/kirkwood-nsa310a.dts                 | 6 +++---
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts           | 2 +-
 arch/arm/boot/dts/kirkwood-openblocks_a7.dts           | 2 +-
 arch/arm/boot/dts/kirkwood-ts219-6281.dts              | 4 ++--
 arch/arm/boot/dts/kirkwood-ts219-6282.dts              | 4 ++--
 arch/arm/boot/dts/kirkwood.dtsi                        | 1 +
 16 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/kirkwood-cloudbox.dts
index 142b9cd3b454..17123f25e2db 100644
--- a/arch/arm/boot/dts/kirkwood-cloudbox.dts
+++ b/arch/arm/boot/dts/kirkwood-cloudbox.dts
@@ -66,7 +66,7 @@
 
 		button at 1 {
 			label = "Power push button";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			gpios = <&gpio0 16 1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index aefa375a550d..1d680d11f629 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -15,17 +15,17 @@
 
 		button at 1 {
 			label = "Power button";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 2 1>;
 		};
 		button at 2 {
 			label = "USB unmount button";
-			linux,code = <161>;
+			linux,code = <KEY_EJECTCD>;
 			gpios = <&gpio1 15 1>;
 		};
 		button at 3 {
 			label = "Reset button";
-			linux,code = <0x198>;
+			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 16 1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index c5fb02f7ebc3..1d69cad81021 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -63,12 +63,12 @@
 
 		button at 1 {
 			label = "USB Copy";
-			linux,code = <133>;
+			linux,code = <KEY_COPY>;
 			gpios = <&gpio0 29 1>;
 		};
 		button at 2 {
 			label = "Reset";
-			linux,code = <0x198>;
+			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 28 1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 4a62b206f680..d69123f71ebb 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -137,13 +137,13 @@
 
 		button at 1 {
 			label = "OTB Button";
-			linux,code = <133>;
+			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 3 1>;
 			debounce-interval = <100>;
 		};
 		button at 2 {
 			label = "Reset";
-			linux,code = <0x198>;
+			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 12 1>;
 			debounce-interval = <100>;
 		};
diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
index d15395d671ed..01534da7b25e 100644
--- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
+++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
@@ -154,17 +154,17 @@
 
 		Power {
 			label = "Power Button";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			gpios = <&gpio0 14 1>;
 		};
 		Reset {
 			label = "Reset Button";
-			linux,code = <0x198>;
+			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 12 1>;
 		};
 		OTB {
 			label = "OTB Button";
-			linux,code = <133>;
+			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 3 1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 4e8f9e42c592..1abfa0dd700b 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -108,18 +108,18 @@
 
 		button at 1 {
 			label = "Function Button";
-			linux,code = <357>;
+			linux,code = <KEY_OPTION>;
 			gpios = <&gpio1 9 1>;
 		};
 		button at 2 {
 			label = "Power-on Switch";
-			linux,code = <0>;
+			linux,code = <KEY_RESERVED>;
 			linux,input-type = <5>;
 			gpios = <&gpio1 10 1>;
 		};
 		button at 3 {
 			label = "Power-auto Switch";
-			linux,code = <1>;
+			linux,code = <KEY_ESC>;
 			linux,input-type = <5>;
 			gpios = <&gpio1 11 1>;
 		};
diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
index 6317e1d088b3..ade432466c85 100644
--- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
@@ -113,12 +113,12 @@
 
 		button at 1 {
 			label = "SWR Button";
-			linux,code = <0x198>; /* KEY_RESTART */
+			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 15 1>;
 		};
 		button at 2 {
 			label = "WPS Button";
-			linux,code = <0x211>; /* KEY_WPS_BUTTON */
+			linux,code = <KEY_WPS_BUTTON>;
 			gpios = <&gpio1 14 1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index e6a102cf424c..c35f917ac438 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -143,17 +143,17 @@
 
 		button at 1 {
 			label = "Power Button";
-			linux,code = <116>;     /* KEY_POWER */
+			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 15 1>;
 		};
 		button at 2 {
 			label = "Reset Button";
-			linux,code = <0x198>;   /* KEY_RESTART */
+			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 13 1>;
 		};
 		button at 3 {
 			label = "Backup Button";
-			linux,code = <133>;     /* KEY_COPY */
+			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 13 1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
index 2fcb82e20828..3101aecdcc0a 100644
--- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
@@ -64,7 +64,7 @@
 
 		button at 1 {
 			label = "Power push button";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 0 0>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index b5418bcaecce..c45a26ce8b57 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -119,17 +119,17 @@
 
 		button at 1 {
 			label = "Power Button";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 14 0>;
 		};
 		button at 2 {
 			label = "Copy Button";
-			linux,code = <133>;
+			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 5 1>;
 		};
 		button at 3 {
 			label = "Reset Button";
-			linux,code = <0x198>;
+			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 4 1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-nsa310a.dts b/arch/arm/boot/dts/kirkwood-nsa310a.dts
index ab0212b0e6f5..874df7d26c7c 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310a.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310a.dts
@@ -107,17 +107,17 @@
 
 		button at 1 {
 			label = "Power Button";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 14 0>;
 		};
 		button at 2 {
 			label = "Copy Button";
-			linux,code = <133>;
+			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 5 1>;
 		};
 		button at 3 {
 			label = "Reset Button";
-			linux,code = <0x198>;
+			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 4 1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index f0e3d213604c..6c171e067b59 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -124,7 +124,7 @@
 
 		button at 1 {
 			label = "Init Button";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 6 0>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
index 851fb2a60f20..c97bad46c29c 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
@@ -149,7 +149,7 @@
 
 		button at 1 {
 			label = "Init Button";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 			gpios = <&gpio1 6 0>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
index f755bc1dc604..89f7094117f4 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6281.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
@@ -41,12 +41,12 @@
 
 		button at 1 {
 			label = "USB Copy";
-			linux,code = <133>;
+			linux,code = <KEY_COPY>;
 			gpios = <&gpio0 15 1>;
 		};
 		button at 2 {
 			label = "Reset";
-			linux,code = <0x198>;
+			linux,code = <KEY_RESTART>;
 			gpios = <&gpio0 16 1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index 345562f75891..6976afb56605 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -51,12 +51,12 @@
 
 		button at 1 {
 			label = "USB Copy";
-			linux,code = <133>;
+			linux,code = <KEY_COPY>;
 			gpios = <&gpio1 11 1>;
 		};
 		button at 2 {
 			label = "Reset";
-			linux,code = <0x198>;
+			linux,code = <KEY_RESTART>;
 			gpios = <&gpio1 5 1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 8b73c80f1dad..477c0b5553e8 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -1,4 +1,5 @@
 /include/ "skeleton.dtsi"
+#include <dt-bindings/input/input.h>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
-- 
1.8.5
