From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 20 Sep 2014 20:06:30 +0200
Subject: [PATCH 4/5] ARM: mvebu: armada-xp: Use PCIe node aliases
In-Reply-To: <1411236391-422-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1411236391-422-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1411236391-422-5-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armada XP pcie controller and port nodes gained aliases, make use of them.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Rob Herring <robh+dt@kernel.org> 
Cc: Pawel Moll <pawel.moll@arm.com> 
Cc: Mark Rutland <mark.rutland@arm.com> 
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk> 
Cc: Kumar Gala <galak@codeaurora.org> 
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jason Cooper <jason@lakedaemon.net> 
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com> 
Cc: devicetree at vger.kernel.org 
Cc: linux-kernel at vger.kernel.org 
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 30 +++++++----------
 arch/arm/boot/dts/armada-xp-db.dts               | 42 +++++++++---------------
 arch/arm/boot/dts/armada-xp-gp.dts               | 27 +++++----------
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  | 24 ++++++--------
 arch/arm/boot/dts/armada-xp-matrix.dts           | 12 +++----
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 30 +++++++----------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 13 +++-----
 7 files changed, 65 insertions(+), 113 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index 1b2dd3a4000b..88c63ec6f355 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -37,25 +37,6 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
 
-		pcie: pcie-controller {
-			status = "okay";
-
-			/* First mini-PCIe port */
-			pcie00: pcie at 0,0 {
-				status = "okay";
-			};
-
-			/* Second mini-PCIe port */
-			pcie01: pcie at 0,1 {
-				status = "okay";
-			};
-
-			/* Renesas uPD720202 USB 3.0 controller */
-			pcie03: pcie at 0,3 {
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -126,6 +107,17 @@
 	};
 };
 
+&pcie { status = "okay"; };
+
+/* First mini-PCIe port */
+&pcie00 { status = "okay"; };
+
+/* Second mini-PCIe port */
+&pcie01 { status = "okay"; };
+
+/* Renesas uPD720202 USB 3.0 controller */
+&pcie03 { status = "okay"; };
+
 &pinctrl {
 	pinctrl-0 = <&pmx_phy_int>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 3cda0f6e5c37..58c2892783a7 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -71,33 +71,6 @@
 			};
 		};
 
-		pcie: pcie-controller {
-			status = "okay";
-
-			/*
-			 * All 6 slots are physically present as
-			 * standard PCIe slots on the board.
-			 */
-			pcie00: pcie at 0,0 {
-				status = "okay";
-			};
-			pcie01: pcie at 0,1 {
-				status = "okay";
-			};
-			pcie02: pcie at 0,2 {
-				status = "okay";
-			};
-			pcie03: pcie at 0,3 {
-				status = "okay";
-			};
-			pcie20: pcie at 2,0 {
-				status = "okay";
-			};
-			pcie30: pcie at 3,0 {
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -190,3 +163,18 @@
 		};
 	};
 };
+
+/* All 6 slots are physically present as standard PCIe slots on the board. */
+&pcie { status = "okay"; };
+
+&pcie00 { status = "okay"; };
+
+&pcie01 { status = "okay"; };
+
+&pcie02 { status = "okay"; };
+
+&pcie03 { status = "okay"; };
+
+&pcie20 { status = "okay"; };
+
+&pcie30 { status = "okay"; };
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 30435e85ff33..ee92bcf0d4bd 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -81,24 +81,6 @@
 			};
 		};
 
-		pcie: pcie-controller {
-			status = "okay";
-
-			/*
-			 * The 3 slots are physically present as
-			 * standard PCIe slots on the board.
-			 */
-			pcie00: pcie at 0,0 {
-				status = "okay";
-			};
-			pcie20: pcie at 2,0 {
-				status = "okay";
-			};
-			pcie30: pcie at 3,0 {
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -189,3 +171,12 @@
 		};
 	};
 };
+
+/* The 3 slots are physically present as standard PCIe slots on the board. */
+&pcie { status = "okay"; };
+
+&pcie00 { status = "okay"; };
+
+&pcie20 { status = "okay"; };
+
+&pcie30 { status = "okay"; };
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index d7607009ecdc..86be971f8fec 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -34,20 +34,6 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
 			MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
 
-		pcie: pcie-controller {
-			status = "okay";
-
-			/* Quad port sata: Marvell 88SX7042 */
-			pcie00: pcie at 0,0 {
-				status = "okay";
-			};
-
-			/* USB 3.0 xHCI controller: NEC D720200F1 */
-			pcie10: pcie at 1,0 {
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -259,6 +245,16 @@
 	};
 };
 
+&pcie { status = "okay"; };
+
+/* Quad port SATA: Marvell 88SX7042 */
+&pcie00 {
+	status = "okay";
+};
+
+/* USB 3.0 xHCI controller: NEC D720200F1 */
+&pcie10 { status = "okay"; };
+
 &pinctrl {
 	poweroff_pin: poweroff-pin {
 		marvell,pins = "mpp24";
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index 77f9f01a9920..97db958bbf02 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -63,17 +63,13 @@
 				};
 			};
 
-			pcie: pcie-controller {
-				status = "okay";
-
-				pcie00: pcie at 0,0 {
-					status = "okay";
-				};
-			};
-
 			usb at 50000 {
 				status = "okay";
 			};
 		};
 	};
 };
+
+&pcie { status = "okay"; };
+
+&pcie00 { status = "okay"; };
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 98beb572a46c..733e5448298b 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -32,25 +32,6 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
 
-		pcie: pcie-controller {
-			status = "okay";
-
-			/* Connected to first Marvell 88SE9170 SATA controller */
-			pcie00: pcie at 0,0 {
-				status = "okay";
-			};
-
-			/* Connected to second Marvell 88SE9170 SATA controller */
-			pcie01: pcie at 0,1 {
-				status = "okay";
-			};
-
-			/* Connected to Fresco Logic FL1009 USB 3.0 controller */
-			pcie10: pcie at 1,0 {
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -240,6 +221,17 @@
 	};
 };
 
+&pcie { status = "okay"; };
+
+/* Connected to first Marvell 88SE9170 SATA controller */
+&pcie00 { status = "okay"; };
+
+/* Connected to second Marvell 88SE9170 SATA controller */
+&pcie01 { status = "okay"; };
+
+/* Connected to Fresco Logic FL1009 USB 3.0 controller */
+&pcie10 { status = "okay"; };
+
 &pinctrl {
 	poweroff: poweroff {
 		marvell,pins = "mpp42";
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 781818614adc..e0c1331e3236 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -61,14 +61,6 @@
 			};
 		};
 
-		pcie: pcie-controller {
-			status = "okay";
-			/* Internal mini-PCIe connector */
-			pcie00: pcie at 0,0 {
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -182,6 +174,11 @@
 	};
 };
 
+&pcie { status = "okay"; };
+
+/* Internal mini-PCIe connector */
+&pcie00 { status = "okay"; };
+
 &pinctrl {
 	led_pins: led-pins-0 {
 		marvell,pins = "mpp49", "mpp51", "mpp53";
-- 
2.0.0
