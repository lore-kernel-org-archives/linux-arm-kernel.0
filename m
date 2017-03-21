From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 Mar 2017 11:51:49 +0100
Subject: [PATCH v2 2/5] arm: spear6xx: use node labels in spear600-evb.dts
In-Reply-To: <1490093512-32665-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1490093512-32665-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1490093512-32665-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have introduced node labels in spear600.dtsi, we can use
them for spear600-evb.dts.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/spear600-evb.dts | 156 ++++++++++++++++++-------------------
 1 file changed, 76 insertions(+), 80 deletions(-)

diff --git a/arch/arm/boot/dts/spear600-evb.dts b/arch/arm/boot/dts/spear600-evb.dts
index d865a89..375eb61 100644
--- a/arch/arm/boot/dts/spear600-evb.dts
+++ b/arch/arm/boot/dts/spear600-evb.dts
@@ -22,95 +22,91 @@
 		device_type = "memory";
 		reg = <0 0x10000000>;
 	};
+};
 
-	ahb {
-		clcd at fc200000 {
-			status = "okay";
-		};
+&clcd {
+	status = "okay";
+};
 
-		dma at fc400000 {
-			status = "okay";
-		};
+&dmac {
+	status = "okay";
+};
 
-		ehci at e1800000 {
-			status = "okay";
-		};
+&ehci_usb0 {
+	status = "okay";
+};
 
-		ehci at e2000000 {
-			status = "okay";
-		};
+&ehci_usb1 {
+	status = "okay";
+};
 
-		gmac: ethernet at e0800000 {
-			phy-mode = "gmii";
-			status = "okay";
-		};
+&gmac {
+	phy-mode = "gmii";
+	status = "okay";
+};
 
-		ohci at e1900000 {
-			status = "okay";
-		};
+&ohci_usb0 {
+	status = "okay";
+};
 
-		ohci at e2100000 {
-			status = "okay";
-		};
+&ohci_usb1 {
+	status = "okay";
+};
 
-		smi: flash at fc000000 {
-			status = "okay";
-			clock-rate=<50000000>;
-
-			flash at f8000000 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <0xf8000000 0x800000>;
-				st,smi-fast-mode;
-
-				partition at 0 {
-					label = "xloader";
-					reg = <0x0 0x10000>;
-				};
-				partition at 10000 {
-					label = "u-boot";
-					reg = <0x10000 0x50000>;
-				};
-				partition at 60000 {
-					label = "environment";
-					reg = <0x60000 0x10000>;
-				};
-				partition at 70000 {
-					label = "dtb";
-					reg = <0x70000 0x10000>;
-				};
-				partition at 80000 {
-					label = "linux";
-					reg = <0x80000 0x310000>;
-				};
-				partition at 390000 {
-					label = "rootfs";
-					reg = <0x390000 0x0>;
-				};
-			};
-		};
+&smi {
+	status = "okay";
+	clock-rate=<50000000>;
+
+	flash at f8000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xf8000000 0x800000>;
+		st,smi-fast-mode;
 
-		apb {
-			serial at d0000000 {
-				status = "okay";
-				pinctrl-names = "default";
-				pinctrl-0 = <>;
-			};
-
-			serial at d0080000 {
-				status = "okay";
-				pinctrl-names = "default";
-				pinctrl-0 = <>;
-			};
-
-			rtc at fc900000 {
-			       status = "okay";
-			};
-
-			i2c at d0200000 {
-				clock-frequency = <400000>;
-				status = "okay";
-			};
+		partition at 0 {
+			label = "xloader";
+			reg = <0x0 0x10000>;
+		};
+		partition at 10000 {
+			label = "u-boot";
+			reg = <0x10000 0x50000>;
+		};
+		partition at 60000 {
+			label = "environment";
+			reg = <0x60000 0x10000>;
+		};
+		partition at 70000 {
+			label = "dtb";
+			reg = <0x70000 0x10000>;
+		};
+		partition at 80000 {
+			label = "linux";
+			reg = <0x80000 0x310000>;
+		};
+		partition at 390000 {
+			label = "rootfs";
+			reg = <0x390000 0x0>;
 		};
 	};
 };
+
+&uart0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <>;
+};
+
+&uart1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <>;
+};
+
+&rtc {
+	status = "okay";
+};
+
+&i2c {
+	clock-frequency = <400000>;
+	status = "okay";
+};
-- 
2.7.4
