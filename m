From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  8 Jul 2016 11:49:29 -0700
Subject: [PATCH 2/2] ARM: dts: NSP: Add BCM958625HR switch ports
In-Reply-To: <1468003769-26959-1-git-send-email-f.fainelli@gmail.com>
References: <1468003769-26959-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1468003769-26959-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the layout of the switch ports found on the BCM958625HR reference
board. The CPU port is hooked up to the AMAC0 Ethernet controlelr
adapter, so we also enable it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm958625hr.dts | 49 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index 03b8bbeb694f..4239e58cf97f 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -109,3 +109,52 @@
 		groups = "nand_grp";
 	};
 };
+
+&amac0 {
+	status = "okay";
+};
+
+&srab {
+	compatible = "brcm,bcm58625-srab", "brcm,nsp-srab";
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port at 0 {
+			label = "port0";
+			reg = <0>;
+		};
+
+		port at 1 {
+			label = "port1";
+			reg = <1>;
+		};
+
+		port at 2 {
+			label = "port2";
+			reg = <2>;
+		};
+
+		port at 3 {
+			label = "port3";
+			reg = <3>;
+		};
+
+		port at 4 {
+			label = "port4";
+			reg = <4>;
+		};
+
+		port at 5 {
+			ethernet = <&amac0>;
+			label = "cpu";
+			reg = <5>;
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+	};
+};
-- 
2.7.4
