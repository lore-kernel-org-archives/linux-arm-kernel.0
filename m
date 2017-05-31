From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Wed, 31 May 2017 09:18:44 +0200
Subject: [PATCH v6 13/21] arm: sun8i: nanopi-neo: Enable dwmac-sun8i
In-Reply-To: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
References: <20170531071852.12422-1-clabbe.montjoie@gmail.com>
Message-ID: <20170531071852.12422-14-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i hardware is present on the NanoPi Neo.
It uses the internal PHY.
This patch create the needed emac node.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
index 8d2cc6e9a03f..78f6c24952dd 100644
--- a/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts
@@ -46,3 +46,10 @@
 	model = "FriendlyARM NanoPi NEO";
 	compatible = "friendlyarm,nanopi-neo", "allwinner,sun8i-h3";
 };
+
+&emac {
+	phy-handle = <&int_mii_phy>;
+	phy-mode = "mii";
+	allwinner,leds-active-low;
+	status = "okay";
+};
-- 
2.13.0
