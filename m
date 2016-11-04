From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:24 +0100
Subject: [PATCH 25/29] ARM: dts: r8a7779: Remove skeleton.dtsi inclusion
In-Reply-To: <cover.1478252308.git.horms+renesas@verge.net.au>
References: <cover.1478252308.git.horms+renesas@verge.net.au>
Message-ID: <1cfc0c03602b8e876672ba895377f0ba1445a2d8.1478252309.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

As of commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark skeleton.dtsi
as deprecated"), including skeleton.dtsi is deprecated.

This fixes the following warning with W=1:

    Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 9d5b8fa3da8b..3005308a1807 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -9,8 +9,6 @@
  * kind, whether express or implied.
  */
 
-/include/ "skeleton.dtsi"
-
 #include <dt-bindings/clock/r8a7779-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -19,6 +17,8 @@
 / {
 	compatible = "renesas,r8a7779";
 	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	cpus {
 		#address-cells = <1>;
-- 
2.7.0.rc3.207.g0ac5344
