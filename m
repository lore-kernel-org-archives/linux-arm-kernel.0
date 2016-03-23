From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 23 Mar 2016 23:24:18 +0100
Subject: [PATCH 1/4] arm64: dts: marvell: Clean up armada-3720-db
In-Reply-To: <1458771861-12392-1-git-send-email-afaerber@suse.de>
References: <1458771861-12392-1-git-send-email-afaerber@suse.de>
Message-ID: <1458771861-12392-2-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of duplicating the SoC's node hierarchy, including a bus node
named "internal-regs", reference the actually desired nodes by label,
like Berlin already does. Add labels where necessary.

Drop an inconsistent white line while at it.

Fixes: adbc3695d9e4 ("arm64: dts: add the Marvell Armada 3700 family and a development board")
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/marvell/armada-3720-db.dts | 35 +++++++++++---------------
 arch/arm64/boot/dts/marvell/armada-372x.dtsi   |  1 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi   |  4 +--
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
index 359050154511..48f97d14b057 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
@@ -60,27 +60,22 @@
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
+/*
+ * Exported on the micro USB connector CON32
+ * through an FTDI
+ */
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
2.6.2
