From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 10:22:17 -0800
Subject: [PATCH v3 1/8] ARM: dts: armada-370-rd: Utilize new DSA binding
In-Reply-To: <20170117182224.32212-1-f.fainelli@gmail.com>
References: <20170117182224.32212-1-f.fainelli@gmail.com>
Message-ID: <20170117182224.32212-2-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Utilize the new DSA binding, introduced with commit 8c5ad1d6179d ("net: dsa:
Document new binding"). The legacy binding node is kept included, but is marked
disabled.

Tested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/armada-370-rd.dts | 44 +++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index c3fd6e49212f..ade956cbd41a 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -173,6 +173,8 @@
 	};
 
 	dsa {
+		status = "disabled";
+
 		compatible = "marvell,dsa";
 		#address-cells = <2>;
 		#size-cells = <0>;
@@ -235,6 +237,48 @@
 	phy0: ethernet-phy at 0 {
 		reg = <0>;
 	};
+
+	switch: switch at 10 {
+		compatible = "marvell,mv88e6085";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x10>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				label = "lan0";
+			};
+
+			port at 1 {
+			       reg = <1>;
+			       label = "lan1";
+			};
+
+			port at 2 {
+			       reg = <2>;
+			       label = "lan2";
+			};
+
+			port at 3 {
+			       reg = <3>;
+			       label = "lan3";
+			};
+
+			port at 5 {
+				reg = <5>;
+				label = "cpu";
+				ethernet = <&eth1>;
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+	};
 };
 
 
-- 
2.9.3
