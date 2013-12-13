From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:51 +0900
Subject: [PATCH 17/69] ARM: shmobile: marzen: add SDHI support on DTS
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <00bf591c3faae65eb00cc8b1ce7ede08b4ccc067.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index ab4110a..f7578d5 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -68,7 +68,7 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif2_pins &scif4_pins &sdhi0_pins>;
+	pinctrl-0 = <&scif2_pins &scif4_pins>;
 	pinctrl-names = "default";
 
 	lan0_pins: lan0 {
@@ -98,3 +98,12 @@
 		renesas,function = "sdhi0";
 	};
 };
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&fixedregulator3v3>;
+	bus-width = <4>;
+	status = "okay";
+};
-- 
1.8.4
