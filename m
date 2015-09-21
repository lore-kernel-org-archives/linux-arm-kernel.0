From: rjui@broadcom.com (Ray Jui)
Date: Mon, 21 Sep 2015 15:12:47 -0700
Subject: [PATCH v3 6/9] ARM: dts: Enable various peripherals on bcm958305k
In-Reply-To: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
References: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442873570-20947-7-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables various peripherals on Broadcom Cygnus wireless audio
board (bcm958305k). These peripherals include I2C, PCIe, and NAND

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm958305k.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958305k.dts b/arch/arm/boot/dts/bcm958305k.dts
index af11a8e..9863a19 100644
--- a/arch/arm/boot/dts/bcm958305k.dts
+++ b/arch/arm/boot/dts/bcm958305k.dts
@@ -44,6 +44,38 @@
 	};
 };
 
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&pcie0 {
+	status = "okay";
+};
+
+&pcie1 {
+	status = "okay";
+};
+
 &uart3 {
 	status = "okay";
 };
+
+&nand {
+	nandcs at 1 {
+		compatible = "brcm,nandcs";
+		reg = <0>;
+		nand-on-flash-bbt;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		nand-ecc-strength = <24>;
+		nand-ecc-step-size = <1024>;
+
+		brcm,nand-oob-sector-size = <27>;
+	};
+};
-- 
1.9.1
