From: rjui@broadcom.com (Ray Jui)
Date: Mon, 21 Sep 2015 15:12:48 -0700
Subject: [PATCH v3 7/9] ARM: dts: Enable NAND support on bcm911360_entphn
In-Reply-To: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
References: <1442873570-20947-1-git-send-email-rjui@broadcom.com>
Message-ID: <1442873570-20947-8-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables NAND support on Broadcom Cygnus form factor board
(bcm911360_entphn)

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm911360_entphn.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/bcm911360_entphn.dts b/arch/arm/boot/dts/bcm911360_entphn.dts
index f791a3b..8b3800f 100644
--- a/arch/arm/boot/dts/bcm911360_entphn.dts
+++ b/arch/arm/boot/dts/bcm911360_entphn.dts
@@ -60,3 +60,19 @@
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
