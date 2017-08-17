From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 17 Aug 2017 09:51:47 +0200
Subject: [PATCH v2 4/6] ARM: sun8i: orangepi-2: Set phy-is-integrated to the
 internal phy node
In-Reply-To: <20170817075149.16178-1-clabbe.montjoie@gmail.com>
References: <20170817075149.16178-1-clabbe.montjoie@gmail.com>
Message-ID: <20170817075149.16178-5-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the new phy-is-integrated property to the internal PHY node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 17cdeae19c6f..0801c808c5e5 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -131,6 +131,10 @@
 	status = "okay";
 };
 
+&int_mii_phy {
+	phy-is-integrated;
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
-- 
2.13.0
