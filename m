From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Apr 2016 17:46:27 +0200
Subject: [PATCH 1/3] arm64: dts: marvell: Clean up armada-3720-db
In-Reply-To: <1461771989-15662-1-git-send-email-gregory.clement@free-electrons.com>
References: <1461771989-15662-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1461771989-15662-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas F?rber <afaerber@suse.de>

Instead of duplicating the SoC's node hierarchy, including a bus node
named "internal-regs", reference the actually desired nodes by label,
like Berlin already does. Add labels where necessary.

Drop an inconsistent white line while at it.
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
[gregory.clement at free-electrons.com: drop Fixes tag as it is not a bug fix.]
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 32 ++++++++++----------------
 arch/arm64/boot/dts/marvell/armada-372x.dtsi   |  1 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   |  4 ++--
 3 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 359050154511..86110a6ae330 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -60,27 +60,19 @@
 		device_type = "memory";
 		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
 	};
+};
 
-	soc {
-		internal-regs {
-			/*
-			* Exported on the micro USB connector CON32
-			* through an FTDI
-			*/
-			uart0: serial at 12000 {
-				status = "okay";
-			};
-
-			/* CON31 */
-			usb3 at 58000 {
-				status = "okay";
-			};
+/* CON3 */
+&sata {
+	status = "okay";
+};
 
-			/* CON3 */
-			sata at e0000 {
-			       status = "okay";
-			};
-		};
-	};
+/* Exported on the micro USB connector CON32 through an FTDI */
+&uart0 {
+	status = "okay";
 };
 
+/* CON31 */
+&usb3 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
index f292a00ce97c..5120296596c2 100644
--- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
@@ -59,5 +59,4 @@
 			enable-method = "psci";
 		};
 	};
-
 };
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index ba9df7ff2a72..4328c2408a8a 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -105,14 +105,14 @@
 				status = "disabled";
 			};
 
-			usb3 at 58000 {
+			usb3: usb3 at 58000 {
 				compatible = "generic-xhci";
 				reg = <0x58000 0x4000>;
 				interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
-			sata at e0000 {
+			sata: sata at e0000 {
 				compatible = "marvell,armada-3700-ahci";
 				reg = <0xe0000 0x2000>;
 				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.5.0
