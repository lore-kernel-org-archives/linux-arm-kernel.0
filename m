From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 21 Oct 2016 11:16:10 +0200
Subject: [PATCH 5/5] ARM: dts: sh73a0: Remove skeleton.dtsi inclusion
In-Reply-To: <1477041370-22778-1-git-send-email-geert+renesas@glider.be>
References: <1477041370-22778-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1477041370-22778-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As of commit 9c0da3cc61f1233c ("ARM: dts: explicitly mark skeleton.dtsi
as deprecated"), including skeleton.dtsi is deprecated.

This fixes the following warning with W=1:

    Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 032fe2f14b16998f..e1267590b57570e5 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -8,8 +8,6 @@
  * kind, whether express or implied.
  */
 
-/include/ "skeleton.dtsi"
-
 #include <dt-bindings/clock/sh73a0-clock.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
@@ -17,6 +15,8 @@
 / {
 	compatible = "renesas,sh73a0";
 	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
 
 	cpus {
 		#address-cells = <1>;
-- 
1.9.1
