From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri,  2 Jun 2017 11:11:26 +0200
Subject: [PATCH 4/4DONOTMERGE] ARM: sun8i: bananapi-m3: Enable dwmac-sun8i
In-Reply-To: <20170602091126.14476-1-clabbe.montjoie@gmail.com>
References: <20170602091126.14476-1-clabbe.montjoie@gmail.com>
Message-ID: <20170602091126.14476-4-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i hardware is present on the bananapi m3
It uses an external PHY rtl8211e via RGMII.

This patch create the needed emac and phy nodes.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index bb23904847d5..dcb4fa7e6eff 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -67,6 +67,23 @@
 	};
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii";
+	allwinner,rx-delay-ps = <700>;
+	allwinner,tx-delay-ps = <700>;
+
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-- 
2.13.0
