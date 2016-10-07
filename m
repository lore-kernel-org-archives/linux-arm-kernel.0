From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri,  7 Oct 2016 10:25:53 +0200
Subject: [PATCH v4 06/10] ARM: dts: sun8i: Enable sun8i-emac on the Orange PI
 PC
In-Reply-To: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1475828757-926-7-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun8i-emac hardware is present on the Orange PI PC.
It uses the internal PHY.

This patch create the needed emac node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index daf50b9a6..71717cc 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -54,6 +54,7 @@
 
 	aliases {
 		serial0 = &uart0;
+		ethernet0 = &emac;
 	};
 
 	chosen {
@@ -165,3 +166,10 @@
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
2.7.3
