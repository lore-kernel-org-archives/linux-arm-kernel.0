From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:03:51 +0900
Subject: [PATCH 04/11] ARM: shmobile: bockw: use wp-gpios instead of WP pin
In-Reply-To: <cover.1392276547.git.horms+renesas@verge.net.au>
References: <cover.1392276547.git.horms+renesas@verge.net.au>
Message-ID: <f729dd554e9a04a55950693ea8eca0d3aaa28d22.1392276547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Latest Renesas Chip has some SDHI channels and the WP pin
availability depends on its channel or HW implementation.
Thus, this patch decides new policy whch indicates
WP is disabled as default.
But, we can use wp-gpios property to enable it as
other method.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index bb62c7a..06cda19 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -17,6 +17,7 @@
 /dts-v1/;
 #include "r8a7778.dtsi"
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "bockw";
@@ -84,7 +85,7 @@
 
 	sdhi0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl",
-				  "sdhi0_cd", "sdhi0_wp";
+				  "sdhi0_cd";
 		renesas,function = "sdhi0";
 	};
 
@@ -101,6 +102,7 @@
 	vmmc-supply = <&fixedregulator3v3>;
 	bus-width = <4>;
 	status = "okay";
+	wp-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
 };
 
 &hspi0 {
-- 
1.8.5.2
