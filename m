From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Thu,  3 Mar 2016 06:41:43 -0500
Subject: [PATCH 3/3] ARM: dts: enable pinctrl for Broadcom NS2 SoC
In-Reply-To: <1457005303-26829-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1457005303-26829-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <1457005303-26829-4-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the pinctrl support for Broadcom NS2 SoC

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/ns2-svk.dts | 9 +++++++++
 arch/arm64/boot/dts/broadcom/ns2.dtsi    | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/ns2-svk.dts b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
index 6bb3d4d..d1c8ccc 100644
--- a/arch/arm64/boot/dts/broadcom/ns2-svk.dts
+++ b/arch/arm64/boot/dts/broadcom/ns2-svk.dts
@@ -75,3 +75,12 @@
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
index a510d3a..a3b267c 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -234,6 +234,13 @@
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
