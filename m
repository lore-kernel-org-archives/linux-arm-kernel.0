From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  3 Apr 2017 11:14:41 +0200
Subject: [PATCH v3 17/20] ARM: dts: sun50i-a64: enable dwmac-sun8i on pine64
 plus
In-Reply-To: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
References: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
Message-ID: <20170403091444.29876-18-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i hardware is present on the pine64 plus.
It uses an external PHY rtl8211e via RGMII.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
index 790d14d..dea76c2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-plus.dts
@@ -46,5 +46,20 @@
 	model = "Pine64+";
 	compatible = "pine64,pine64-plus", "allwinner,sun50i-a64";
 
-	/* TODO: Camera, Ethernet PHY, touchscreen, etc. */
+	/* TODO: Camera, touchscreen, etc. */
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	status = "okay";
 };
-- 
2.10.2
