From: jon.mason@broadcom.com (Jon Mason)
Date: Wed,  8 Feb 2017 15:45:15 -0500
Subject: [PATCH 1/2] ARM: dts: BCM5301X: Add NAND entries to bcm953012k
In-Reply-To: <1486586716-6781-1-git-send-email-jon.mason@broadcom.com>
References: <1486586716-6781-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1486586716-6781-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the NAND entry in the DTS

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 arch/arm/boot/dts/bcm953012k.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/bcm953012k.dts b/arch/arm/boot/dts/bcm953012k.dts
index ae31a58..cb673c7 100644
--- a/arch/arm/boot/dts/bcm953012k.dts
+++ b/arch/arm/boot/dts/bcm953012k.dts
@@ -52,6 +52,38 @@
 	};
 };
 
+&nand {
+	nandcs at 0 {
+		compatible = "brcm,nandcs";
+		reg = <0>;
+		nand-on-flash-bbt;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+
+		partition at 0 {
+			label = "nboot";
+			reg = <0x00000000 0x00200000>;
+			read-only;
+		};
+		partition at 200000 {
+			label = "nenv";
+			reg = <0x00200000 0x00400000>;
+		};
+		partition at 600000 {
+			label = "nsystem";
+			reg = <0x00600000 0x00a00000>;
+		};
+		partition at 1000000 {
+			label = "nrootfs";
+			reg = <0x01000000 0x07000000>;
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.7.4
