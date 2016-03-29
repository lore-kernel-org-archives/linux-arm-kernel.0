From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Tue, 29 Mar 2016 11:22:12 -0400
Subject: [PATCH RESEND 2/2] ARM: dts: enable pinctrl for Broadcom NS2 SoC
In-Reply-To: <1459264932-27884-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1459264932-27884-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <1459264932-27884-3-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the pinctrl support for Broadcom NS2 SoC

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 9 +++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index ce0ab84..2c98d76 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -87,3 +87,12 @@
 		#size-cells = <1>;
 	};
 };
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&nand_sel>;
+	nand_sel: nand_sel {
+		function = "nand";
+		groups = "nand_grp";
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 6f81c9d..e263ade3 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -308,6 +308,13 @@
 					     "chimp", "port", "sdio";
 		};
 
+		pinctrl: pinctrl at 6501d130 {
+			compatible = "brcm,ns2-pinmux";
+			reg = <0x6501d130 0x08>,
+			      <0x660a0028 0x04>,
+			      <0x660009b0 0x40>;
+		};
+
 		crmu: crmu at 65024000 {
 			compatible = "syscon";
 			reg = <0x65024000 0x100>;
-- 
2.1.0
