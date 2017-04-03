From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  3 Apr 2017 11:14:40 +0200
Subject: [PATCH v3 16/20] ARM: dts: sun50i-a64: enable dwmac-sun8i on pine64
In-Reply-To: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
References: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
Message-ID: <20170403091444.29876-17-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i hardware is present on the pine64
It uses an external PHY via RMII.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index c680ed3..6aee3d5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -109,3 +109,19 @@
 &usbphy {
 	status = "okay";
 };
+
+&mdio {
+	ext_rmii_phy1: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rmii_pins>;
+	phy-mode = "rmii";
+	phy-handle = <&ext_rmii_phy1>;
+	status = "okay";
+
+};
-- 
2.10.2
