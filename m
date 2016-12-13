From: jon.mason@broadcom.com (Jon Mason)
Date: Tue, 13 Dec 2016 13:13:48 -0500
Subject: [PATCH 4/7] ARM: dts: NSP: Add BCM958625K switch ports
In-Reply-To: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
References: <1481652831-2744-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1481652831-2744-5-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the layout of the switch ports found on the BCM958625K reference
board. The CPU port is hooked up to the AMAC0 Ethernet controller
adapter.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm958625k.dts | 45 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index dc24056..7aa86c7 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -120,6 +120,51 @@
 	};
 };
 
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
+
 &qspi {
 	bspi-sel = <0>;
 	flash: m25p80 at 0 {
-- 
2.7.4
