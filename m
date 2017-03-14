From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 14 Mar 2017 15:18:45 +0100
Subject: [PATCH v2 09/20] ARM: dts: sun8i: Enable dwmac-sun8i on the Orange PI
 PC
In-Reply-To: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
References: <20170314141856.24560-1-clabbe.montjoie@gmail.com>
Message-ID: <20170314141856.24560-10-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: LABBE Corentin <clabbe.montjoie@gmail.com>

The dwmac-sun8i hardware is present on the Orange PI PC.
It uses the internal PHY.

This patch create the needed emac node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index f148111..746c25a 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -53,6 +53,7 @@
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &emac;
 	};
 
 	chosen {
@@ -184,3 +185,10 @@
 	/* USB VBUS is always on */
 	status = "okay";
 };
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
-- 
2.10.2
