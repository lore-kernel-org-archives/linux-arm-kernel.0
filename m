From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  3 Apr 2017 11:14:37 +0200
Subject: [PATCH v3 13/20] ARM: dts: sun8i: orangepi-pc-plus: Set EMAC activity
 LEDs to active high
In-Reply-To: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
References: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
Message-ID: <20170403091444.29876-14-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the Orange Pi PC Plus, the polarity of the LEDs on the RJ45 Ethernet
port were changed from active low to active high.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
index 8b93f5c..0380769 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts
@@ -86,3 +86,8 @@
 	/* eMMC is missing pull-ups */
 	bias-pull-up;
 };
+
+&emac {
+	/* LEDs changed to active high on the plus */
+	/delete-property/ allwinner,leds-active-low;
+};
-- 
2.10.2
