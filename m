From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon,  6 May 2013 17:33:39 +0200
Subject: [PATCH v3 6/7] ARM: kirkwood: add gigabit ethernet and mvmdio device
 tree nodes
In-Reply-To: <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1365071235-11611-1-git-send-email-florian@openwrt.org>
 <1367854420-8006-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1367854420-8006-7-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds mv643xx_eth and mvmdio device tree nodes for DT enabled
Kirkwood boards. Phy nodes are also added with reg property set on a
per-board basis.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Rob Landley <rob@landley.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: David Miller <davem@davemloft.net>
Cc: Florian Fainelli <florian@openwrt.org>
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Simon Guinot <simon.guinot@sequanux.org>
Cc: Jamie Lentin <jm@lentin.co.uk>
Cc: Michael Walle <michael@walle.cc>
Cc: Eric Hutter <hutter.eric@gmail.com>
Cc: Joshua Coombs <josh.coombs@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Simon Baatz <gmbnomis@gmail.com>
Cc: Alan M Butler <alanbutty12@gmail.com>
Cc: Nigel Roberts <nigel@nobiscuit.com>
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>
Cc: Stefan Peter <s.peter@mpl.ch>
Cc: Arnaud Ebalard <arno@natisbad.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: netdev at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-doc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/kirkwood-cloudbox.dts            |   15 ++++++
 arch/arm/boot/dts/kirkwood-dnskw.dtsi              |   15 ++++++
 arch/arm/boot/dts/kirkwood-dockstar.dts            |   15 ++++++
 arch/arm/boot/dts/kirkwood-dreamplug.dts           |   26 ++++++++++
 arch/arm/boot/dts/kirkwood-goflexnet.dts           |   15 ++++++
 .../arm/boot/dts/kirkwood-guruplug-server-plus.dts |   26 ++++++++++
 arch/arm/boot/dts/kirkwood-ib62x0.dts              |   15 ++++++
 arch/arm/boot/dts/kirkwood-iconnect.dts            |   15 ++++++
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts      |   22 ++++++++
 arch/arm/boot/dts/kirkwood-is2.dts                 |    2 +
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts         |   15 ++++++
 arch/arm/boot/dts/kirkwood-lsxl.dtsi               |   26 ++++++++++
 arch/arm/boot/dts/kirkwood-mplcec4.dts             |   25 +++++++++
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |   15 ++++++
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi         |   15 ++++++
 arch/arm/boot/dts/kirkwood-ns2.dts                 |    2 +
 arch/arm/boot/dts/kirkwood-ns2lite.dts             |    2 +
 arch/arm/boot/dts/kirkwood-ns2max.dts              |    2 +
 arch/arm/boot/dts/kirkwood-ns2mini.dts             |    2 +
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts       |   15 ++++++
 arch/arm/boot/dts/kirkwood-topkick.dts             |   15 ++++++
 arch/arm/boot/dts/kirkwood-ts219-6281.dts          |    4 +-
 arch/arm/boot/dts/kirkwood-ts219-6282.dts          |    4 +-
 arch/arm/boot/dts/kirkwood-ts219.dtsi              |   15 ++++++
 arch/arm/boot/dts/kirkwood.dtsi                    |   52 ++++++++++++++++++++
 25 files changed, 373 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/kirkwood-cloudbox.dts
index 5f21d4e..d4f1e89 100644
--- a/arch/arm/boot/dts/kirkwood-cloudbox.dts
+++ b/arch/arm/boot/dts/kirkwood-cloudbox.dts
@@ -87,3 +87,18 @@
 		gpios = <&gpio0 17 0>;
 	};
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <0>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index 6875ac0..b203f07 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -217,3 +217,18 @@
 		};
 	};
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 8 {
+		device_type = "ethernet-phy";
+		reg = <8>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/kirkwood-dockstar.dts
index 0196cf6..1b46882 100644
--- a/arch/arm/boot/dts/kirkwood-dockstar.dts
+++ b/arch/arm/boot/dts/kirkwood-dockstar.dts
@@ -91,3 +91,18 @@
 		};
 	};
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <0>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 289e51d..3ce258b 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -99,3 +99,29 @@
 		};
 	};
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&eth1 { status = "okay"; };
+&egiga1 {
+	status = "okay";
+	phy = <&ethphy1>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <0>;
+	};
+
+	ethphy1: ethernet-phy at 1 {
+		device_type = "ethernet-phy";
+		reg = <1>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/kirkwood-goflexnet.dts
index c3573be..84fe313 100644
--- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
+++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
@@ -170,3 +170,18 @@
 		};
 	};
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <0>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
index 44fd97d..894e658 100644
--- a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
+++ b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
@@ -96,3 +96,29 @@
 		};
 	};
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&eth1 { status = "okay"; };
+&egiga1 {
+	status = "okay";
+	phy = <&ethphy1>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <0>;
+	};
+
+	ethphy1: ethernet-phy at 1 {
+		device_type = "ethernet-phy";
+		reg = <1>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index 5335b1a..7e7845d 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -119,3 +119,18 @@
 
 
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 8 {
+		device_type = "ethernet-phy";
+		reg = <8>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 12ccf74..7991168 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -168,3 +168,18 @@
 		};
 	};
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 11 {
+		device_type = "ethernet-phy";
+		reg = <11>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
index 3694e94..40e85aa 100644
--- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
+++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
@@ -191,3 +191,25 @@
 		};
 	};
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	speed = <1000>;
+	duplex = <1>;
+};
+
+&eth1 { status = "okay"; };
+&egiga1 {
+	status = "okay";
+	phy = <&ethphy1>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy1: ethernet-phy at 11 {
+		device_type = "ethernet-phy";
+		reg = <11>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-is2.dts b/arch/arm/boot/dts/kirkwood-is2.dts
index 0bdce0a..2e5fe72 100644
--- a/arch/arm/boot/dts/kirkwood-is2.dts
+++ b/arch/arm/boot/dts/kirkwood-is2.dts
@@ -28,3 +28,5 @@
 		};
 	};
 };
+
+&ethphy0 { reg = <8>; };
diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
index 5bbd054..fd97497 100644
--- a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
+++ b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
@@ -43,3 +43,18 @@
 		};
 	};
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <0>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 37d45c4..e9d61db 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -201,3 +201,29 @@
 		};
 	};
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&eth1 { status = "okay"; };
+&egiga1 {
+	status = "okay";
+	phy = <&ethphy1>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <0>;
+	};
+
+	ethphy1: ethernet-phy at 8 {
+		device_type = "ethernet-phy";
+		reg = <8>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index 7588241..326cc48 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -182,3 +182,28 @@
 	};
 };
 
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&eth1 { status = "okay"; };
+&egiga1 {
+	status = "okay";
+	phy = <&ethphy1>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 1 {
+		device_type = "ethernet-phy";
+		reg = <1>;
+	};
+
+	ethphy1: ethernet-phy at 2 {
+		device_type = "ethernet-phy";
+		reg = <2>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index 1ca66ab..f3b39f7 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -178,3 +178,18 @@
                 };
         };
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <0>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
index 6affd92..b205832 100644
--- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
@@ -82,3 +82,18 @@
 	};
 
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy {
+		device_type = "ethernet-phy";
+                /* overwrite reg property in board file */
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-ns2.dts b/arch/arm/boot/dts/kirkwood-ns2.dts
index f2d36ecf..8ffd552 100644
--- a/arch/arm/boot/dts/kirkwood-ns2.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2.dts
@@ -28,3 +28,5 @@
 		};
 	};
 };
+
+&ethphy0 { reg = <8>; };
diff --git a/arch/arm/boot/dts/kirkwood-ns2lite.dts b/arch/arm/boot/dts/kirkwood-ns2lite.dts
index b02eb4e..16332f8 100644
--- a/arch/arm/boot/dts/kirkwood-ns2lite.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2lite.dts
@@ -28,3 +28,5 @@
 		};
 	};
 };
+
+&ethphy0 { reg = <0>; };
diff --git a/arch/arm/boot/dts/kirkwood-ns2max.dts b/arch/arm/boot/dts/kirkwood-ns2max.dts
index bcec4d6..68d767d 100644
--- a/arch/arm/boot/dts/kirkwood-ns2max.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2max.dts
@@ -47,3 +47,5 @@
 		};
 	};
 };
+
+&ethphy0 { reg = <8>; };
diff --git a/arch/arm/boot/dts/kirkwood-ns2mini.dts b/arch/arm/boot/dts/kirkwood-ns2mini.dts
index adab1ab..5b1b17b 100644
--- a/arch/arm/boot/dts/kirkwood-ns2mini.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2mini.dts
@@ -48,3 +48,5 @@
 		};
 	};
 };
+
+&ethphy0 { reg = <0>; };
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index d27f724..d8109f9 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -210,3 +210,18 @@
 		};
         };
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <0>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index 66eb45b..dc3bb78 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -201,3 +201,18 @@
 		};
 	};
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy at 0 {
+		device_type = "ethernet-phy";
+		reg = <0>;
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
index 8295c83..0bd67bf 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6281.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
@@ -49,4 +49,6 @@
 			gpios = <&gpio0 16 1>;
 		};
 	};
-};
\ No newline at end of file
+};
+
+&ethphy0 { reg = <8>; };
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index df3f95d..a1bdef6 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -49,4 +49,6 @@
 			gpios = <&gpio1 5 1>;
 		};
 	};
-};
\ No newline at end of file
+};
+
+&ethphy0 { reg = <8>; };
diff --git a/arch/arm/boot/dts/kirkwood-ts219.dtsi b/arch/arm/boot/dts/kirkwood-ts219.dtsi
index 64ea27c..5865dc5 100644
--- a/arch/arm/boot/dts/kirkwood-ts219.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ts219.dtsi
@@ -76,3 +76,18 @@
 		};
 	};
 };
+
+&eth0 { status = "okay"; };
+&egiga0 {
+	status = "okay";
+	phy = <&ethphy0>;
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy0: ethernet-phy {
+		device_type = "ethernet-phy";
+                /* overwrite reg property in board file */
+	};
+};
diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index fada7e6..c01a273 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -202,5 +202,57 @@
 			clocks = <&gate_clk 4>;
 			status = "disabled";
 		};
+
+		mdio: mdio-bus at 72004 {
+			compatible = "marvell,orion-mdio";
+			reg = <0x72004 0x84>;
+			interrupts = <11>;
+			clocks = <&gate_clk 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			/* add phy nodes in board file */
+		};
+
+		eth0: ethernet-controller at 72000 {
+			compatible = "marvell,mv643xx-eth-block";
+			reg = <0x72000 0x4000>;
+			clocks = <&gate_clk 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			tx-csum-limit = <1600>;
+			status = "disabled";
+
+			egiga0: ethernet-port at 0 {
+				compatible = "marvell,mv643xx-eth";
+				device_type = "network";
+				reg = <0>;
+				interrupts = <11>;
+				clocks = <&gate_clk 0>;
+				/* set phy property in board file */
+				status = "disabled";
+			};
+		};
+
+		eth1: ethernet-controller at 76000 {
+			compatible = "marvell,mv643xx-eth-block";
+			reg = <0x76000 0x4000>;
+			clocks = <&gate_clk 19>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			tx-csum-limit = <1600>;
+			status = "disabled";
+
+			egiga1: ethernet-port at 1 {
+				compatible = "marvell,mv643xx-eth";
+				device_type = "network";
+				reg = <1>;
+				interrupts = <15>;
+				clocks = <&gate_clk 19>;
+				/* set phy property in board file */
+				status = "disabled";
+			};
+		};
 	};
 };
-- 
1.7.2.5
