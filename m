From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Tue, 17 Mar 2015 19:31:24 +0100
Subject: [PATCH] ARM: vexpress: Add unified-cache Device Tree property
Message-ID: <1426617084-1583-1-git-send-email-r.schwebel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this propergy, we get this boot warning:

"L2C: device tree omits to specify unified cache"

Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
---
 arch/arm/boot/dts/vexpress-v2p-ca9.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index 23662b5..a411274 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -170,6 +170,7 @@
 		compatible = "arm,pl310-cache";
 		reg = <0x1e00a000 0x1000>;
 		interrupts = <0 43 4>;
+		cache-unified;
 		cache-level = <2>;
 		arm,data-latency = <1 1 1>;
 		arm,tag-latency = <1 1 1>;
-- 
2.1.4
