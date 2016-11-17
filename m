From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:05:00 +0100
Subject: [PATCH v3 11/19] ARM: dts: armada-370: Fixup pcie DT warnings
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-12-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIe has a ranges property, so the unit name should contain an address.
Take the opportunity to use the node label instead of the full name.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts                | 37 +++++++++++-----------
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts     | 28 ++++++++--------
 arch/arm/boot/dts/armada-370-mirabox.dts           | 32 +++++++++----------
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     | 32 +++++++++----------
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     | 32 +++++++++----------
 arch/arm/boot/dts/armada-370-rd.dts                | 32 +++++++++----------
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts  | 14 ++++----
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi | 19 +++++------
 .../dts/armada-370-seagate-personal-cloud.dtsi     | 18 +++++------
 arch/arm/boot/dts/armada-370.dtsi                  |  2 +-
 10 files changed, 124 insertions(+), 122 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index d26115085ea1..f3adc187c6a5 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -170,24 +170,6 @@
 				};
 			};
 		};
-
-		pcie-controller {
-			status = "okay";
-			/*
-			 * The two PCIe units are accessible through
-			 * both standard PCIe slots and mini-PCIe
-			 * slots on the board.
-			 */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			pcie at 2,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
-		};
 	};
 
 	sound {
@@ -248,6 +230,25 @@
 		compatible = "linux,spdif-dir";
 	};
 };
+
+&pciec {
+	status = "okay";
+	/*
+	 * The two PCIe units are accessible through
+	 * both standard PCIe slots and mini-PCIe
+	 * slots on the board.
+	 */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+
+	pcie at 2,0 {
+		/* Port 1, Lane 0 */
+		status = "okay";
+	};
+};
+
 &mdio {
 	pinctrl-0 = <&mdio_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
index e2a363b1dd8a..9e499eeede4b 100644
--- a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -72,20 +72,6 @@
 			MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			pcie at 2,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			sata at a0000 {
 				nr-ports = <2>;
@@ -262,6 +248,20 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+
+	pcie at 2,0 {
+		/* Port 1, Lane 0 */
+		status = "okay";
+	};
+};
+
 &pinctrl {
 	sata_l_white_pin: sata-l-white-pin {
 		marvell,pins = "mpp57";
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 3e1ef56b6319..c4dded0cd0c1 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -64,22 +64,6 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/* Internal mini-PCIe connector */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			/* Connected on the PCB to a USB 3.0 XHCI controller */
-			pcie at 2,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -186,6 +170,22 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+
+	/* Internal mini-PCIe connector */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+
+	/* Connected on the PCB to a USB 3.0 XHCI controller */
+	pcie at 2,0 {
+		/* Port 1, Lane 0 */
+		status = "okay";
+	};
+};
+
 &mdio {
 	pinctrl-0 = <&mdio_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index a6409853db6d..99b9d73ebbaf 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -66,22 +66,6 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/* Connected to Marvell 88SE9170 SATA controller */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			/* Connected to FL1009 USB 3.0 controller */
-			pcie at 2,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 
 			/* RTC is provided by Intersil ISL12057 I2C RTC chip */
@@ -252,6 +236,22 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+
+	/* Connected to Marvell 88SE9170 SATA controller */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+
+	/* Connected to FL1009 USB 3.0 controller */
+	pcie at 2,0 {
+		/* Port 1, Lane 0 */
+		status = "okay";
+	};
+};
+
 &mdio {
 	pinctrl-0 = <&mdio_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index fd5f1d9a434a..b5dd30178725 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -66,22 +66,6 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/* Connected to FL1009 USB 3.0 controller */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			/* Connected to Marvell 88SE9215 SATA controller */
-			pcie at 2,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 
 			/* RTC is provided by Intersil ISL12057 I2C RTC chip */
@@ -270,6 +254,22 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+
+	/* Connected to FL1009 USB 3.0 controller */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+
+	/* Connected to Marvell 88SE9215 SATA controller */
+	pcie at 2,0 {
+		/* Port 1, Lane 0 */
+		status = "okay";
+	};
+};
+
 &mdio {
 	pinctrl-0 = <&mdio_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 621add7e12d5..29722b9f288e 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -77,22 +77,6 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/* Internal mini-PCIe connector */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			/* Internal mini-PCIe connector */
-			pcie at 2,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -229,6 +213,22 @@
 	 };
 };
 
+&pciec {
+	status = "okay";
+
+	/* Internal mini-PCIe connector */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+
+	/* Internal mini-PCIe connector */
+	pcie at 2,0 {
+		/* Port 1, Lane 0 */
+		status = "okay";
+	};
+};
+
 &mdio {
 	pinctrl-0 = <&mdio_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
index 82ce5ec6467b..eb6af53b4954 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
@@ -28,13 +28,6 @@
 	compatible = "seagate,dart-4", "marvell,armada370", "marvell,armada-370-xp";
 
 	soc {
-		pcie-controller {
-			/* SATA AHCI controller 88SE9170 */
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			ethernet at 74000 {
 				status = "okay";
@@ -126,6 +119,13 @@
 	};
 };
 
+&pciec {
+	/* SATA AHCI controller 88SE9170 */
+	pcie at 1,0 {
+		status = "okay";
+	};
+};
+
 &mdio {
 	phy1: ethernet-phy at 1 {
 		reg = <1>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index 724a47908e3f..9b582c47f10c 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -32,15 +32,6 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/* USB 3.0 bridge ASM1042A */
-			pcie at 2,0 {
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -199,6 +190,16 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+
+	/* USB 3.0 bridge ASM1042A */
+	pcie at 2,0 {
+		status = "okay";
+	};
+};
+
+
 &mdio {
 	pinctrl-0 = <&mdio_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index fb52a34f0a35..bb678a45ac8e 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -33,15 +33,6 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/* USB 3.0 Bridge ASM1042A */
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			coherency-fabric at 20200 {
 				broken-idle;
@@ -134,6 +125,15 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+
+	/* USB 3.0 Bridge ASM1042A */
+	pcie at 1,0 {
+		status = "okay";
+	};
+};
+
 &mdio {
 	pinctrl-0 = <&mdio_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 7ba3e609a5ae..59b9abf5b46f 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -74,7 +74,7 @@
 			reg = <MBUS_ID(0x01, 0xe0) 0 0x100000>;
 		};
 
-		pciec: pcie-controller {
+		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,armada-370-pcie";
 			status = "disabled";
 			device_type = "pci";
-- 
2.10.2
