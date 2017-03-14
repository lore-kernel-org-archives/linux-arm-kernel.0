From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 14 Mar 2017 15:18:54 +0100
Subject: [PATCH v2 18/20] ARM: dts: sun50i-a64: enable dwmac-sun8i on the
 BananaPi M64
In-Reply-To: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
References: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
Message-ID: <20170314141856.24560-19-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i  hardware is present on the BananaPi M64.
It uses an external PHY rtl8211e via RGMII.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index 6872135..347c262 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -77,6 +77,20 @@
 	bias-pull-up;
 };
 
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
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
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-- 
2.10.2
