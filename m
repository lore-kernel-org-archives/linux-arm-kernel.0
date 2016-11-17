From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:04:59 +0100
Subject: [PATCH v3 10/19] ARM: dts: armada-xp: Fixup pcie DT warnings
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-11-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIe has a range property, so the unit name should contain an address.
Take the opportunity to use the node label instead of the full name.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 44 ++++++++--------
 arch/arm/boot/dts/armada-xp-db.dts               | 66 ++++++++++++------------
 arch/arm/boot/dts/armada-xp-gp.dts               | 42 +++++++--------
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  | 31 ++++++-----
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts    | 44 ++++++++--------
 arch/arm/boot/dts/armada-xp-matrix.dts           | 18 +++----
 arch/arm/boot/dts/armada-xp-mv78230.dtsi         |  2 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi         |  2 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi         |  2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 44 ++++++++--------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 18 +++----
 arch/arm/boot/dts/armada-xp-synology-ds414.dts   | 45 ++++++++--------
 12 files changed, 179 insertions(+), 179 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index 7038c8625ac5..d12b06bf0d60 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -73,28 +73,6 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/* First mini-PCIe port */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			/* Second mini-PCIe port */
-			pcie at 2,0 {
-				/* Port 0, Lane 1 */
-				status = "okay";
-			};
-
-			/* Renesas uPD720202 USB 3.0 controller */
-			pcie at 3,0 {
-				/* Port 0, Lane 3 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			/* UART0 */
 			serial at 12000 {
@@ -153,6 +131,28 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+
+	/* First mini-PCIe port */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+
+	/* Second mini-PCIe port */
+	pcie at 2,0 {
+		/* Port 0, Lane 1 */
+		status = "okay";
+	};
+
+	/* Renesas uPD720202 USB 3.0 controller */
+	pcie at 3,0 {
+		/* Port 0, Lane 3 */
+		status = "okay";
+	};
+};
+
 &pinctrl {
 	pinctrl-0 = <&phy_int_pin>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 486caf887da4..607ce1f2ddd6 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -80,39 +80,6 @@
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0 0xf1200000 0x100000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/*
-			 * All 6 slots are physically present as
-			 * standard PCIe slots on the board.
-			 */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-			pcie at 2,0 {
-				/* Port 0, Lane 1 */
-				status = "okay";
-			};
-			pcie at 3,0 {
-				/* Port 0, Lane 2 */
-				status = "okay";
-			};
-			pcie at 4,0 {
-				/* Port 0, Lane 3 */
-				status = "okay";
-			};
-			pcie at 9,0 {
-				/* Port 2, Lane 0 */
-				status = "okay";
-			};
-			pcie at 10,0 {
-				/* Port 3, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -244,6 +211,39 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+
+	/*
+	 * All 6 slots are physically present as
+	 * standard PCIe slots on the board.
+	 */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+	pcie at 2,0 {
+		/* Port 0, Lane 1 */
+		status = "okay";
+	};
+	pcie at 3,0 {
+		/* Port 0, Lane 2 */
+		status = "okay";
+	};
+	pcie at 4,0 {
+		/* Port 0, Lane 3 */
+		status = "okay";
+	};
+	pcie at 9,0 {
+		/* Port 2, Lane 0 */
+		status = "okay";
+	};
+	pcie at 10,0 {
+		/* Port 3, Lane 0 */
+		status = "okay";
+	};
+};
+
 &bm_bppi {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 65d960defff3..015b8ab722a5 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -99,27 +99,6 @@
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0 0xf1200000 0x100000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/*
-			 * The 3 slots are physically present as
-			 * standard PCIe slots on the board.
-			 */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-			pcie at 9,0 {
-				/* Port 2, Lane 0 */
-				status = "okay";
-			};
-			pcie at 10,0 {
-				/* Port 3, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -229,6 +208,27 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+
+	/*
+	 * The 3 slots are physically present as
+	 * standard PCIe slots on the board.
+	 */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+	pcie at 9,0 {
+		/* Port 2, Lane 0 */
+		status = "okay";
+	};
+	pcie at 10,0 {
+		/* Port 3, Lane 0 */
+		status = "okay";
+	};
+};
+
 &bm_bppi {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 0a6a43692620..1dce74d9b616 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -68,22 +68,6 @@
 			MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/* Quad port sata: Marvell 88SX7042 */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			/* USB 3.0 xHCI controller: NEC D720200F1 */
-			pcie at 5,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -285,6 +269,21 @@
 		gpios = <&gpio0 24 GPIO_ACTIVE_HIGH>;
 	};
 };
+&pciec {
+	status = "okay";
+
+	/* Quad port sata: Marvell 88SX7042 */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+
+	/* USB 3.0 xHCI controller: NEC D720200F1 */
+	pcie at 5,0 {
+		/* Port 1, Lane 0 */
+		status = "okay";
+	};
+};
 
 &mdio {
 	phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 076f27f22c3b..488a047481d4 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -73,28 +73,6 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/* Etron EJ168 USB 3.0 controller */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			/* First mini-PCIe port */
-			pcie at 2,0 {
-				/* Port 0, Lane 1 */
-				status = "okay";
-			};
-
-			/* Second mini-PCIe port */
-			pcie at 3,0 {
-				/* Port 0, Lane 3 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 
 			rtc at 10300 {
@@ -369,6 +347,28 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+
+	/* Etron EJ168 USB 3.0 controller */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+
+	/* First mini-PCIe port */
+	pcie at 2,0 {
+		/* Port 0, Lane 1 */
+		status = "okay";
+	};
+
+	/* Second mini-PCIe port */
+	pcie at 3,0 {
+		/* Port 0, Lane 3 */
+		status = "okay";
+	};
+};
+
 &pinctrl {
 
 	keys_pin: keys-pin {
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index e1509f4c5114..8b5a4e79d26b 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -71,15 +71,6 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			serial at 12000 {
 				status = "okay";
@@ -114,3 +105,12 @@
 		};
 	};
 };
+
+&pciec {
+	status = "okay";
+
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+};
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index ebf79d6de1a1..05c164b5786d 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -86,7 +86,7 @@
 		 * configured as x4 or quad x1 lanes. One unit is
 		 * x1 only.
 		 */
-		pciec: pcie-controller {
+		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,armada-xp-pcie";
 			status = "disabled";
 			device_type = "pci";
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 34e78a568460..07894b0d3e59 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -87,7 +87,7 @@
 		 * configured as x4 or quad x1 lanes. One unit is
 		 * x4 only.
 		 */
-		pciec: pcie-controller {
+		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,armada-xp-pcie";
 			status = "disabled";
 			device_type = "pci";
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 5148827ed934..775bee53ce86 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -104,7 +104,7 @@
 		 * configured as x4 or quad x1 lanes. Two units are
 		 * x4/x1.
 		 */
-		pciec: pcie-controller {
+		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,armada-xp-pcie";
 			status = "disabled";
 			device_type = "pci";
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index c4685cb86f06..5aaaf0fb2330 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -67,28 +67,6 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/* Connected to first Marvell 88SE9170 SATA controller */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			/* Connected to second Marvell 88SE9170 SATA controller */
-			pcie at 2,0 {
-				/* Port 0, Lane 1 */
-				status = "okay";
-			};
-
-			/* Connected to Fresco Logic FL1009 USB 3.0 controller */
-			pcie at 5,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 
 			/* RTC is provided by Intersil ISL12057 I2C RTC chip */
@@ -290,6 +268,28 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+
+	/* Connected to first Marvell 88SE9170 SATA controller */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+
+	/* Connected to second Marvell 88SE9170 SATA controller */
+	pcie at 2,0 {
+		/* Port 0, Lane 1 */
+		status = "okay";
+	};
+
+	/* Connected to Fresco Logic FL1009 USB 3.0 controller */
+	pcie at 5,0 {
+		/* Port 1, Lane 0 */
+		status = "okay";
+	};
+};
+
 &mdio {
 	phy0: ethernet-phy at 0 { /* Marvell 88E1318 */
 		reg = <0>;
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 7cd2d74e0161..e40f3314b699 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -70,15 +70,6 @@
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0 0xd1200000 0x100000>;
 
-		pcie-controller {
-			status = "okay";
-			/* Internal mini-PCIe connector */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 			rtc at 10300 {
 				/* No crystal connected to the internal RTC */
@@ -222,6 +213,15 @@
 	status = "okay";
 };
 
+&pciec {
+	status = "okay";
+	/* Internal mini-PCIe connector */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+};
+
 &mdio {
 	phy0: ethernet-phy at 0 {
 		reg = <0>;
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index 189ec7f4667c..d5630a7b4b18 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -81,28 +81,6 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		pcie-controller {
-			status = "okay";
-
-			/*
-			 * Connected to Marvell 88SX7042 SATA-II controller
-			 * handling the four disks.
-			 */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-
-			/*
-			 * Connected to EtronTech EJ168A XHCI controller
-			 * providing the two rear USB 3.0 ports.
-			 */
-			pcie at 5,0 {
-				/* Port 1, Lane 0 */
-				status = "okay";
-			};
-		};
-
 		internal-regs {
 
 			/* RTC is provided by Seiko S-35390A below */
@@ -230,6 +208,29 @@
 	};
 };
 
+&pciec {
+	status = "okay";
+
+	/*
+	 * Connected to Marvell 88SX7042 SATA-II controller
+	 * handling the four disks.
+	 */
+	pcie at 1,0 {
+		/* Port 0, Lane 0 */
+		status = "okay";
+	};
+
+	/*
+	 * Connected to EtronTech EJ168A XHCI controller
+	 * providing the two rear USB 3.0 ports.
+	 */
+	pcie at 5,0 {
+		/* Port 1, Lane 0 */
+		status = "okay";
+	};
+};
+
+
 &mdio {
 	phy0: ethernet-phy at 0 { /* Marvell 88E1512 */
 		reg = <0>;
-- 
2.10.2
