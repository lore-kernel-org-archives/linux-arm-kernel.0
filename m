From: b20788@freescale.com (Anson Huang)
Date: Thu, 19 Dec 2013 12:25:34 -0500
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Add power key support
Message-ID: <1387473934-10188-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for imx6qdl-sabresd board's power
key, the key is named "SW1" on board, press it can wake up
system from suspend.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index e75e11b..85e3487 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -47,6 +47,13 @@
 	gpio-keys {
 		compatible = "gpio-keys";
 
+		power {
+			label = "Power Button";
+			gpios = <&gpio3 29 0>;
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+
 		volume-up {
 			label = "Volume Up";
 			gpios = <&gpio1 4 0>;
@@ -182,6 +189,7 @@
 				MX6QDL_PAD_ENET_TXD1__GPIO1_IO29 0x80000000
 				MX6QDL_PAD_EIM_D22__GPIO3_IO22  0x80000000
 				MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25 0x80000000
+				MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x80000000
 			>;
 		};
 	};
-- 
1.7.9.5
