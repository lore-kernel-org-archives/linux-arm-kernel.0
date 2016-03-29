From: patrick@puiterwijk.org (Patrick Uiterwijk)
Date: Tue, 29 Mar 2016 13:56:52 +0000
Subject: [PATCH 1/2] ARM: mvebu: correct the usb node name from usb@ to ehci@
In-Reply-To: <1459259813-5278-1-git-send-email-patrick@puiterwijk.org>
References: <1459259813-5278-1-git-send-email-patrick@puiterwijk.org>
Message-ID: <1459259813-5278-2-git-send-email-patrick@puiterwijk.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to Documentation/devicetree/bindings/usb/ehci-orion.txt,
the Orion Marvell variant of EHCI controllers should have names
ehci at 50000 for example.

Signed-off-by: Patrick Uiterwijk <patrick@puiterwijk.org>
---
 arch/arm/boot/dts/armada-370-db.dts                      | 4 ++--
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts           | 2 +-
 arch/arm/boot/dts/armada-370-mirabox.dts                 | 4 ++--
 arch/arm/boot/dts/armada-370-netgear-rn102.dts           | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts           | 2 +-
 arch/arm/boot/dts/armada-370-rd.dts                      | 4 ++--
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi | 2 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts         | 4 ++--
 arch/arm/boot/dts/armada-370-xp.dtsi                     | 4 ++--
 arch/arm/boot/dts/armada-370.dtsi                        | 4 ++--
 arch/arm/boot/dts/armada-375-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-375.dtsi                        | 4 ++--
 arch/arm/boot/dts/armada-385-linksys.dtsi                | 2 +-
 arch/arm/boot/dts/armada-388-clearfog.dts                | 2 +-
 arch/arm/boot/dts/armada-388-db.dts                      | 2 +-
 arch/arm/boot/dts/armada-388-gp.dts                      | 2 +-
 arch/arm/boot/dts/armada-38x.dtsi                        | 2 +-
 arch/arm/boot/dts/armada-xp-db.dts                       | 6 +++---
 arch/arm/boot/dts/armada-xp-gp.dts                       | 4 ++--
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts          | 4 ++--
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts            | 2 +-
 arch/arm/boot/dts/armada-xp-matrix.dts                   | 2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts           | 2 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts         | 4 ++--
 arch/arm/boot/dts/armada-xp-synology-ds414.dts           | 2 +-
 arch/arm/boot/dts/armada-xp.dtsi                         | 2 +-
 26 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index 2364fc5..4d50030 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -147,11 +147,11 @@
 				broken-cd;
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
-			usb at 51000 {
+			ehci at 51000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
index e2a363b..6695653 100644
--- a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -92,7 +92,7 @@
 				status = "okay";
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index d5e19cd..3fbbc13 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -154,11 +154,11 @@
 				 broken-cd;
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
-			usb at 51000 {
+			ehci at 51000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 39181b3..a368e0e 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -115,7 +115,7 @@
 				phy-mode = "rgmii-id";
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 1156575..99c87ea 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -121,7 +121,7 @@
 				phy-mode = "rgmii-id";
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index fbef730..86f4fa8 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -134,11 +134,11 @@
 				broken-cd;
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
-			usb at 51000 {
+			ehci at 51000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index 1aba08e..344fe32 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -88,7 +88,7 @@
 				};
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index 8ca7a43..f5e8950 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -174,12 +174,12 @@
 			};
 
 			/* rear USB port, near reset button */
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
 			/* rear USB port, near RJ45 port */
-			usb at 51000 {
+			ehci at 51000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index a718866..90a6eba 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -253,14 +253,14 @@
 				reg = <0x22000 0x1000>;
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x50000 0x500>;
 				interrupts = <45>;
 				status = "disabled";
 			};
 
-			usb at 51000 {
+			ehci at 51000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x51000 0x500>;
 				interrupts = <46>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 3b06aa8..47579c4 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -271,11 +271,11 @@
 				status = "disabled";
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				clocks = <&coreclk 0>;
 			};
 
-			usb at 51000 {
+			ehci at 51000 {
 				clocks = <&coreclk 0>;
 			};
 
diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
index cded5f0..d2a19a1 100644
--- a/arch/arm/boot/dts/armada-375-db.dts
+++ b/arch/arm/boot/dts/armada-375-db.dts
@@ -144,7 +144,7 @@
 				};
 			};
 
-			usb at 54000 {
+			ehci at 54000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
index cc952cf..1d61dff 100644
--- a/arch/arm/boot/dts/armada-375.dtsi
+++ b/arch/arm/boot/dts/armada-375.dtsi
@@ -445,7 +445,7 @@
 				reg = <0x21010 0x1c>;
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x50000 0x500>;
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
@@ -455,7 +455,7 @@
 				status = "disabled";
 			};
 
-			usb at 54000 {
+			ehci at 54000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x54000 0x500>;
 				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 3710755..b328d94 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -117,7 +117,7 @@
 			};
 
 			/* USB part of the eSATA/USB 2.0 port */
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-388-clearfog.dts b/arch/arm/boot/dts/armada-388-clearfog.dts
index c60206e..5ea8c67 100644
--- a/arch/arm/boot/dts/armada-388-clearfog.dts
+++ b/arch/arm/boot/dts/armada-388-clearfog.dts
@@ -355,7 +355,7 @@
 				};
 			};
 
-			usb at 58000 {
+			ehci at 58000 {
 				/* CON3, nearest  power. */
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-388-db.dts b/arch/arm/boot/dts/armada-388-db.dts
index ea93ed7..e25bead 100644
--- a/arch/arm/boot/dts/armada-388-db.dts
+++ b/arch/arm/boot/dts/armada-388-db.dts
@@ -105,7 +105,7 @@
 				bm,pool-short = <3>;
 			};
 
-			usb at 58000 {
+			ehci at 58000 {
 				status = "ok";
 			};
 
diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index fd75e5e..cafe2b2 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -140,7 +140,7 @@
 			};
 
 			/* CON4 */
-			usb at 58000 {
+			ehci at 58000 {
 				vcc-supply = <&reg_usb2_0_vbus>;
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 3312be6..7e881c0 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -466,7 +466,7 @@
 				status = "disabled";
 			};
 
-			usb at 58000 {
+			ehci at 58000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x58000 0x500>;
 				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 62422a9..0adc619 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -219,15 +219,15 @@
 				broken-cd;
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
-			usb at 51000 {
+			ehci at 51000 {
 				status = "okay";
 			};
 
-			usb at 52000 {
+			ehci at 52000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 061f423..776de1f 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -223,12 +223,12 @@
 			};
 
 			/* Front-side USB slot */
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
 			/* Back-side USB slot */
-			usb at 51000 {
+			ehci at 51000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 8af463f..42b9000 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -115,11 +115,11 @@
 				phy-mode = "rgmii-id";
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
-			usb at 51000 {
+			ehci at 51000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index b89e6cf..f19f2fe 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -135,7 +135,7 @@
 			};
 
 			/* USB part of the eSATA/USB 2.0 port */
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index 6522b04..dedd100 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -108,7 +108,7 @@
 				};
 			};
 
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 		};
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index d19f44c..2d7160e 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -150,7 +150,7 @@
 			};
 
 			/* Front USB 2.0 port */
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index ed3b889d..586c880 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -220,12 +220,12 @@
 			};
 
 			/* Front side USB 0 */
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
 			/* Front side USB 1 */
-			usb at 51000 {
+			ehci at 51000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index d17dab0..2707a96 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -202,7 +202,7 @@
 			};
 
 			/* Front USB 2.0 port */
-			usb at 50000 {
+			ehci at 50000 {
 				status = "okay";
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 553349c..593682b 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -205,7 +205,7 @@
 				clocks = <&gateclk 19>;
 			};
 
-			usb at 52000 {
+			ehci at 52000 {
 				compatible = "marvell,orion-ehci";
 				reg = <0x52000 0x500>;
 				interrupts = <47>;
-- 
2.7.4
