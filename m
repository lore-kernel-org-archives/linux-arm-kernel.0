From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 17 Apr 2018 12:17:14 +0800
Subject: [PATCH] ARM: dts: sun8i: h3: Re-enable EMAC on Orange Pi One
Message-ID: <20180417041714.27266-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit f0842bc5637c ("ARM: dts: sun8i: h3: Enable HDMI output on H3
boards"), the hunk that enabled HDMI for the Orange Pi One did not add a

    status = "okay";

line for the HDMI node, inadvertenly using the one for the EMAC. This
resulted in the EMAC now being disabled. Whether this was due to a
rebase error or some other mishap is unknown.

This patch re-enables the EMAC by adding the status line to its node.

Fixes: f0842bc5637c ("ARM: dts: sun8i: h3: Enable HDMI output on H3 boards")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

First fix for 4.17.

---
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
index 3328fe583c9b..232f124ce62c 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-one.dts
@@ -117,6 +117,7 @@
 	phy-handle = <&int_mii_phy>;
 	phy-mode = "mii";
 	allwinner,leds-active-low;
+	status = "okay";
 };
 
 &hdmi {
-- 
2.17.0
