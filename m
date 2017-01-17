From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 10:22:20 -0800
Subject: [PATCH v3 4/8] ARM: dts: armada-xp-linksys-mamba: Utilize new DSA
 binding
In-Reply-To: <20170117182224.32212-1-f.fainelli@gmail.com>
References: <20170117182224.32212-1-f.fainelli@gmail.com>
Message-ID: <20170117182224.32212-5-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net: dsa:
Document new binding"). The legacy binding node is kept included, but is marked
disabled.

Tested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 53 +++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 83ac884c0f8a..42ea8764814c 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -302,6 +302,8 @@
 	};
 
 	dsa {
+		status = "disabled";
+
 		compatible = "marvell,dsa";
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -398,3 +400,54 @@
 		spi-max-frequency = <40000000>;
 	};
 };
+
+&mdio {
+	status = "okay";
+
+	switch at 0 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				label = "lan4";
+			};
+
+			port at 1 {
+				reg = <1>;
+				label = "lan3";
+			};
+
+			port at 2 {
+				reg = <2>;
+				label = "lan2";
+			};
+
+			port at 3 {
+				reg = <3>;
+				label = "lan1";
+			};
+
+			port at 4 {
+				reg = <4>;
+				label = "internet";
+			};
+
+			port at 5 {
+				reg = <5>;
+				label = "cpu";
+				ethernet = <&eth0>;
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+	};
+};
-- 
2.9.3
