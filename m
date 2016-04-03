From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  3 Apr 2016 04:03:47 +0200
Subject: [PATCH 5/8] ARM: kirkwood: DT: Fixup pcie DT warnings
In-Reply-To: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
References: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
Message-ID: <1459649030-21886-6-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCIe has a range property, so the unit name should contain an address.
Make use of the label to enable individual PCIe busses. Also, fixup
the synology dtsi file which added a label pcie2 rather than using the
existing pcie1 label.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-6192.dtsi               |  2 +-
 arch/arm/boot/dts/kirkwood-6281.dtsi               |  2 +-
 arch/arm/boot/dts/kirkwood-6282.dtsi               |  2 +-
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi           |  2 +-
 arch/arm/boot/dts/kirkwood-b3.dts                  | 19 ++++++++-----------
 arch/arm/boot/dts/kirkwood-db-88f6281.dts          | 14 ++++++--------
 arch/arm/boot/dts/kirkwood-db-88f6282.dts          | 20 +++++++++-----------
 arch/arm/boot/dts/kirkwood-dir665.dts              | 18 ++++++++----------
 arch/arm/boot/dts/kirkwood-ds111.dts               |  2 +-
 arch/arm/boot/dts/kirkwood-ds112.dts               |  6 +++++-
 arch/arm/boot/dts/kirkwood-ds212.dts               |  2 +-
 arch/arm/boot/dts/kirkwood-ds411.dts               |  6 +++++-
 arch/arm/boot/dts/kirkwood-ds411slim.dts           |  2 +-
 arch/arm/boot/dts/kirkwood-iconnect.dts            | 18 ++++++++----------
 arch/arm/boot/dts/kirkwood-km_common.dtsi          | 18 ++++++++----------
 arch/arm/boot/dts/kirkwood-laplug.dts              | 17 ++++++++---------
 arch/arm/boot/dts/kirkwood-linkstation.dtsi        | 17 ++++++++---------
 arch/arm/boot/dts/kirkwood-mplcec4.dts             | 18 ++++++++----------
 arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts     | 18 ++++++++----------
 arch/arm/boot/dts/kirkwood-nas2big.dts             | 18 ++++++++----------
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  | 18 ++++++++----------
 .../boot/dts/kirkwood-netgear_readynas_nv+_v2.dts  | 21 +++++++++------------
 arch/arm/boot/dts/kirkwood-nsa310.dts              | 18 ++++++++----------
 arch/arm/boot/dts/kirkwood-nsa320.dts              | 18 ++++++++----------
 arch/arm/boot/dts/kirkwood-nsa325.dts              | 17 +++++++----------
 arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi      | 18 ++++++++----------
 arch/arm/boot/dts/kirkwood-openrd.dtsi             | 14 ++++----------
 arch/arm/boot/dts/kirkwood-rd88f6192.dts           | 20 +++++++++-----------
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi          | 18 ++++++++----------
 arch/arm/boot/dts/kirkwood-rs212.dts               |  6 +++++-
 arch/arm/boot/dts/kirkwood-synology.dtsi           | 22 ++++++++--------------
 arch/arm/boot/dts/kirkwood-t5325.dts               | 18 ++++++++----------
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          | 12 ++----------
 arch/arm/boot/dts/kirkwood-ts219.dtsi              | 18 ++++++++----------
 arch/arm/boot/dts/kirkwood-ts419-6282.dts          | 15 +++------------
 35 files changed, 207 insertions(+), 267 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-6192.dtsi b/arch/arm/boot/dts/kirkwood-6192.dtsi
index 9e6e9e2691d5..1014a5dd9035 100644
--- a/arch/arm/boot/dts/kirkwood-6192.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6192.dtsi
@@ -1,6 +1,6 @@
 / {
 	mbus {
-		pciec: pcie-controller {
+		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,kirkwood-pcie";
 			status = "disabled";
 			device_type = "pci";
diff --git a/arch/arm/boot/dts/kirkwood-6281.dtsi b/arch/arm/boot/dts/kirkwood-6281.dtsi
index 7dc7d6782e83..fad201551304 100644
--- a/arch/arm/boot/dts/kirkwood-6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6281.dtsi
@@ -1,6 +1,6 @@
 / {
 	mbus {
-		pciec: pcie-controller {
+		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,kirkwood-pcie";
 			status = "disabled";
 			device_type = "pci";
diff --git a/arch/arm/boot/dts/kirkwood-6282.dtsi b/arch/arm/boot/dts/kirkwood-6282.dtsi
index 4680eec990f0..27434c35eb66 100644
--- a/arch/arm/boot/dts/kirkwood-6282.dtsi
+++ b/arch/arm/boot/dts/kirkwood-6282.dtsi
@@ -1,6 +1,6 @@
 / {
 	mbus {
-		pciec: pcie-controller {
+		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,kirkwood-pcie";
 			status = "disabled";
 			device_type = "pci";
diff --git a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
index 9e1f741d74ff..17eb92733310 100644
--- a/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
+++ b/arch/arm/boot/dts/kirkwood-98dx4122.dtsi
@@ -1,6 +1,6 @@
 / {
 	mbus {
-		pciec: pcie-controller {
+		pciec: pcie-controller at 82000000 {
 			compatible = "marvell,kirkwood-pcie";
 			status = "disabled";
 			device_type = "pci";
diff --git a/arch/arm/boot/dts/kirkwood-b3.dts b/arch/arm/boot/dts/kirkwood-b3.dts
index d2936ad3af1d..d091ecb61cd2 100644
--- a/arch/arm/boot/dts/kirkwood-b3.dts
+++ b/arch/arm/boot/dts/kirkwood-b3.dts
@@ -33,17 +33,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			/* Wifi model has Atheros chipset on pcie port */
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pmx_button_power: pmx-button-power {
@@ -199,3 +188,11 @@
 	};
 };
 
+/* Wifi model has Atheros chipset on pcie port */
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6281.dts b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
index c39dd766c75a..aee6f02b1c80 100644
--- a/arch/arm/boot/dts/kirkwood-db-88f6281.dts
+++ b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
@@ -17,14 +17,12 @@
 / {
 	model = "Marvell DB-88F6281-BP Development Board";
 	compatible = "marvell,db-88f6281-bp", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
+&pciec {
+        status = "okay";
+};
 
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
+&pcie0 {
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6282.dts b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
index 701c6b6cdaa2..e8b23e13ec0c 100644
--- a/arch/arm/boot/dts/kirkwood-db-88f6282.dts
+++ b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
@@ -17,18 +17,16 @@
 / {
 	model = "Marvell DB-88F6282-BP Development Board";
 	compatible = "marvell,db-88f6282-bp", "marvell,kirkwood-88f6282", "marvell,kirkwood";
+};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
+&pciec {
+        status = "okay";
+};
 
-			pcie at 1,0 {
-				status = "okay";
-			};
+&pcie0 {
+	status = "okay";
+};
 
-			pcie at 2,0 {
-				status = "okay";
-			};
-		};
-	};
+&pcie1 {
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/kirkwood-dir665.dts b/arch/arm/boot/dts/kirkwood-dir665.dts
index f548363060ea..41acbb6dd6ab 100644
--- a/arch/arm/boot/dts/kirkwood-dir665.dts
+++ b/arch/arm/boot/dts/kirkwood-dir665.dts
@@ -25,16 +25,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pinctrl-0 =< &pmx_led_usb
@@ -276,3 +266,11 @@
 &rtc {
 	status = "disabled";
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ds111.dts b/arch/arm/boot/dts/kirkwood-ds111.dts
index 61f47fbe44d0..a85a4664431b 100644
--- a/arch/arm/boot/dts/kirkwood-ds111.dts
+++ b/arch/arm/boot/dts/kirkwood-ds111.dts
@@ -40,6 +40,6 @@
 	status = "okay";
 };
 
-&pcie2 {
+&pcie1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/kirkwood-ds112.dts b/arch/arm/boot/dts/kirkwood-ds112.dts
index b84af3da8c84..6cef4bdbc01b 100644
--- a/arch/arm/boot/dts/kirkwood-ds112.dts
+++ b/arch/arm/boot/dts/kirkwood-ds112.dts
@@ -44,6 +44,10 @@
 	status = "okay";
 };
 
-&pcie2 {
+&pciec {
+        status = "okay";
+};
+
+&pcie1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/kirkwood-ds212.dts b/arch/arm/boot/dts/kirkwood-ds212.dts
index 99afd462f956..7f32e7abffac 100644
--- a/arch/arm/boot/dts/kirkwood-ds212.dts
+++ b/arch/arm/boot/dts/kirkwood-ds212.dts
@@ -43,6 +43,6 @@
 	status = "okay";
 };
 
-&pcie2 {
+&pcie1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/kirkwood-ds411.dts b/arch/arm/boot/dts/kirkwood-ds411.dts
index 623cd4a37d71..72e58307416d 100644
--- a/arch/arm/boot/dts/kirkwood-ds411.dts
+++ b/arch/arm/boot/dts/kirkwood-ds411.dts
@@ -48,6 +48,10 @@
 	status = "okay";
 };
 
-&pcie2 {
+&pciec {
+        status = "okay";
+};
+
+&pcie1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/kirkwood-ds411slim.dts b/arch/arm/boot/dts/kirkwood-ds411slim.dts
index a0a1fad8b4de..aaaf31b81522 100644
--- a/arch/arm/boot/dts/kirkwood-ds411slim.dts
+++ b/arch/arm/boot/dts/kirkwood-ds411slim.dts
@@ -44,6 +44,6 @@
 	status = "okay";
 };
 
-&pcie2 {
+&pcie1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 674306746dec..d25184ae4af3 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -19,16 +19,6 @@
 		linux,initrd-end   = <0x4800000>;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pmx_button_reset: pmx-button-reset {
@@ -194,3 +184,11 @@
 		phy-handle = <&ethphy0>;
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-km_common.dtsi b/arch/arm/boot/dts/kirkwood-km_common.dtsi
index 8367c772c764..f6096f56046d 100644
--- a/arch/arm/boot/dts/kirkwood-km_common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-km_common.dtsi
@@ -4,16 +4,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pinctrl-0 = < &pmx_i2c_gpio_sda &pmx_i2c_gpio_scl >;
@@ -46,3 +36,11 @@
 	status = "okay";
 	chip-delay = <25>;
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-laplug.dts b/arch/arm/boot/dts/kirkwood-laplug.dts
index c39e17a89f4e..1b0f070c2676 100644
--- a/arch/arm/boot/dts/kirkwood-laplug.dts
+++ b/arch/arm/boot/dts/kirkwood-laplug.dts
@@ -27,15 +27,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		serial at 12000 {
 			status = "okay";
@@ -169,3 +160,11 @@
 		phy-handle = <&ethphy0>;
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-linkstation.dtsi b/arch/arm/boot/dts/kirkwood-linkstation.dtsi
index 69061b6e987b..36c54c9dfa30 100644
--- a/arch/arm/boot/dts/kirkwood-linkstation.dtsi
+++ b/arch/arm/boot/dts/kirkwood-linkstation.dtsi
@@ -49,15 +49,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pmx_power_hdd0: pmx-power-hdd0 {
@@ -200,3 +191,11 @@
 		};
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index f3a991837515..aa413b0bcce2 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -17,16 +17,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pmx_led_health: pmx-led-health {
@@ -215,3 +205,11 @@
 		phy-handle = <&ethphy1>;
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
index 26fb610b2af7..172a38c0b8a9 100644
--- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
+++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
@@ -31,16 +31,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-        };
-
 	ocp at f1000000 {
 		pin-controller at 10000 {
 			pmx_usb_led: pmx-usb-led {
@@ -179,3 +169,11 @@
 		duplex = <1>;
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-nas2big.dts b/arch/arm/boot/dts/kirkwood-nas2big.dts
index 7427ec50b829..f53bcacf6b63 100644
--- a/arch/arm/boot/dts/kirkwood-nas2big.dts
+++ b/arch/arm/boot/dts/kirkwood-nas2big.dts
@@ -28,16 +28,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		rtc at 10300 {
 			/* The on-chip RTC is not powered (no supercap). */
@@ -141,3 +131,11 @@
 		reg = <0x9100000 0x6f00000>;
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index fd733c63bc27..8745484912d2 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -28,16 +28,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pmx_button_power: pmx-button-power {
@@ -251,3 +241,11 @@
 		phy-handle = <&ethphy0>;
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
index b514d643fb6c..a4e97f7f5804 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_nv+_v2.dts
@@ -28,18 +28,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			/* Connected to NEC uPD720200 USB 3.0 controller */
-			pcie at 1,0 {
-				/* Port 0, Lane 0 */
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pmx_button_power: pmx-button-power {
@@ -265,3 +253,12 @@
 		phy-handle = <&ethphy0>;
 	};
 };
+
+/* Connected to NEC uPD720200 USB 3.0 controller */
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 6139df0f376c..0b69ee4934fa 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -15,16 +15,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pinctrl-0 = <&pmx_unknown>;
@@ -138,3 +128,11 @@
 		};
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-nsa320.dts b/arch/arm/boot/dts/kirkwood-nsa320.dts
index 2a935e94f96f..6ab104b4bb42 100644
--- a/arch/arm/boot/dts/kirkwood-nsa320.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa320.dts
@@ -27,16 +27,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pinctrl-names = "default";
@@ -222,3 +212,11 @@
 		phy-handle = <&ethphy0>;
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-nsa325.dts b/arch/arm/boot/dts/kirkwood-nsa325.dts
index bc4ec9332387..36c64816bf7f 100644
--- a/arch/arm/boot/dts/kirkwood-nsa325.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa325.dts
@@ -28,16 +28,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pinctrl-names = "default";
@@ -236,3 +226,10 @@
 	};
 };
 
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
index 5ccc46190079..e09b79ac73fd 100644
--- a/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-nsa3x0-common.dtsi
@@ -4,16 +4,6 @@
 / {
 	model = "ZyXEL NSA310";
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 
@@ -157,3 +147,11 @@
 		reg = <0x5040000 0x2fc0000>;
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-openrd.dtsi b/arch/arm/boot/dts/kirkwood-openrd.dtsi
index 24f1d30970a0..e4ecab112601 100644
--- a/arch/arm/boot/dts/kirkwood-openrd.dtsi
+++ b/arch/arm/boot/dts/kirkwood-openrd.dtsi
@@ -25,16 +25,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pinctrl-0 = <&pmx_select28 &pmx_sdio_cd &pmx_select34>;
@@ -125,3 +115,7 @@
 		reg = <0x0600000 0x1FA00000>;
 	};
 };
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6192.dts b/arch/arm/boot/dts/kirkwood-rd88f6192.dts
index e0b959396ca2..b8af907249fb 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6192.dts
+++ b/arch/arm/boot/dts/kirkwood-rd88f6192.dts
@@ -29,16 +29,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pinctrl-0 = <&pmx_usb_power>;
@@ -108,4 +98,12 @@
         ethernet0-port at 0 {
                 phy-handle = <&ethphy0>;
         };
-};
\ No newline at end of file
+};
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
index 5521426d101b..d5aacf137e40 100644
--- a/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
+++ b/arch/arm/boot/dts/kirkwood-rd88f6281.dtsi
@@ -25,16 +25,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pinctrl-names = "default";
@@ -134,3 +124,11 @@
 		duplex = <1>;
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-rs212.dts b/arch/arm/boot/dts/kirkwood-rs212.dts
index 3b19f1fd4cac..2c722ecd5331 100644
--- a/arch/arm/boot/dts/kirkwood-rs212.dts
+++ b/arch/arm/boot/dts/kirkwood-rs212.dts
@@ -44,6 +44,10 @@
 	status = "okay";
 };
 
-&pcie2 {
+&pciec {
+        status = "okay";
+};
+
+&pcie1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/kirkwood-synology.dtsi b/arch/arm/boot/dts/kirkwood-synology.dtsi
index 04015c174b99..65e9524e852a 100644
--- a/arch/arm/boot/dts/kirkwood-synology.dtsi
+++ b/arch/arm/boot/dts/kirkwood-synology.dtsi
@@ -10,20 +10,6 @@
  */
 
 / {
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-
-			pcie2: pcie at 2,0 {
-				status = "disabled";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pmx_alarmled_12: pmx-alarmled-12 {
@@ -861,3 +847,11 @@
 		phy-handle = <&ethphy1>;
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
index 860c6d778d47..3500f4738fb0 100644
--- a/arch/arm/boot/dts/kirkwood-t5325.dts
+++ b/arch/arm/boot/dts/kirkwood-t5325.dts
@@ -30,16 +30,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 			pinctrl-0 = <&pmx_i2s &pmx_sysrst>;
@@ -229,3 +219,11 @@
 		phy-handle = <&ethphy0>;
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index 1d291f620869..3437bb396844 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -5,16 +5,6 @@
 #include "kirkwood-ts219.dtsi"
 
 / {
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 2,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		pinctrl: pin-controller at 10000 {
 
@@ -63,3 +53,5 @@
 };
 
 &ethphy0 { reg = <0>; };
+
+&pcie1 { status = "okay"; };
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index b3f75382cb06..62e5e2d5c348 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -12,16 +12,6 @@
 		stdout-path = &uart0;
 	};
 
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 1,0 {
-				status = "okay";
-			};
-		};
-	};
-
 	ocp at f1000000 {
 		i2c at 11000 {
 			status = "okay";
@@ -105,3 +95,11 @@
 		phy-handle = <&ethphy0>;
 	};
 };
+
+&pciec {
+        status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/kirkwood-ts419-6282.dts b/arch/arm/boot/dts/kirkwood-ts419-6282.dts
index d7512d4cdced..e3e71f48acc8 100644
--- a/arch/arm/boot/dts/kirkwood-ts419-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts419-6282.dts
@@ -16,17 +16,8 @@
 #include "kirkwood-ts219.dtsi"
 #include "kirkwood-ts419.dtsi"
 
-/ {
-	mbus {
-		pcie-controller {
-			status = "okay";
-
-			pcie at 2,0 {
-				status = "okay";
-			};
-		};
-	};
-};
-
 &ethphy0 { reg = <0>; };
 &ethphy1 { reg = <1>; };
+
+&pciec { status = "okay"; };
+&pcie1 { status = "okay"; };
-- 
2.7.0
