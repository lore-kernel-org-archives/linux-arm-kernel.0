From: jon.mason@broadcom.com (Jon Mason)
Date: Wed,  3 Aug 2016 14:38:57 -0400
Subject: [PATCH 02/11] ARM: dts: NSP: Enable SATA and add i2c devices on XMC
In-Reply-To: <1470249546-12440-1-git-send-email-jon.mason@broadcom.com>
References: <1470249546-12440-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1470249546-12440-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable SATA on bcm958625xmc and add the i2c devices present.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm958525xmc.dts | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index d257e83..a337f2d 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -47,6 +47,24 @@
 	};
 };
 
+&i2c0 {
+	temperature-sensor at 4c {
+		compatible = "adi,adt7461a";
+		reg = <0x4c>;
+	};
+
+	eeprom at 52 {
+		compatible = "atmel,24c02";
+		reg = <0x52>;
+		pagesize = <16>;
+	};
+
+	rtc at 68 {
+		compatible = "st,m41t81";
+		reg = <0x68>;
+	};
+};
+
 &nand {
 	nandcs at 0 {
 		compatible = "brcm,nandcs";
@@ -85,7 +103,7 @@
 	};
 };
 
-/* XHCI, SATA, MMC, and Ethernet support needed to be complete */
+/* XHCI, MMC, and Ethernet support needed to be complete */
 
 &uart0 {
 	status = "okay";
@@ -99,6 +117,18 @@
 	status = "okay";
 };
 
+&sata_phy0 {
+	status = "okay";
+};
+
+&sata_phy1 {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
 &pinctrl {
 	pinctrl-names = "default";
 	pinctrl-0 = <&nand_sel>;
-- 
2.7.4
