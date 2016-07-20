From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Wed, 20 Jul 2016 10:03:20 +0200
Subject: [PATCH v2 5/5] ARM: dts: sun8i: Enable sun8i-emac on the Orange PI PC
In-Reply-To: <1469001800-11615-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1469001800-11615-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <1469001800-11615-6-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun8i-emac hardware is present on the Orange PI PC.
It uses the internal PHY.

This patch create the needed emac and phy nodes.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index daf50b9a6..b8340f7 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -165,3 +165,14 @@
 	/* USB VBUS is always on */
 	status = "okay";
 };
+
+&emac {
+	phy = <&phy1>;
+	phy-mode = "mii";
+	allwinner,use-internal-phy;
+	allwinner,leds-active-low;
+	status = "okay";
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
-- 
2.7.3
