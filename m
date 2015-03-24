From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 25 Mar 2015 00:53:26 +0800
Subject: [PATCH resend v2 1/2] ARM: dts: sun4i: a10-lime: Override and remove
 1008MHz OPP setting
In-Reply-To: <1427216007-9185-1-git-send-email-wens@csie.org>
References: <1427216007-9185-1-git-send-email-wens@csie.org>
Message-ID: <1427216007-9185-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Olimex A10-Lime is known to be unstable when running at 1008MHz.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
index ab7891c43231..75742f8f96f3 100644
--- a/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
+++ b/arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts
@@ -56,6 +56,22 @@
 	model = "Olimex A10-OLinuXino-LIME";
 	compatible = "olimex,a10-olinuxino-lime", "allwinner,sun4i-a10";
 
+	cpus {
+		cpu0: cpu at 0 {
+			/*
+			 * The A10-Lime is known to be unstable
+			 * when running at 1008 MHz
+			 */
+			operating-points = <
+				/* kHz    uV */
+				912000  1350000
+				864000  1300000
+				624000  1250000
+				>;
+			cooling-max-level = <2>;
+		};
+	};
+
 	soc at 01c00000 {
 		emac: ethernet at 01c0b000 {
 			pinctrl-names = "default";
-- 
2.1.4
