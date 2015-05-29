From: tony@atomide.com (Tony Lindgren)
Date: Fri, 29 May 2015 10:21:52 -0700
Subject: [PATCH] ARM: dts: Remove L3 compatible value for dm816x
Message-ID: <1432920112-21539-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The interconnects on dm816x are like on omap4, so we should use
l3-noc instead of l3-smx. But as the related SoC specific
l3_target_data is still missing from omap_l3_noc let's just
remove the entry for now.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Reported-by: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 289806a..3c99cfa 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -58,7 +58,7 @@
 	 * the whole bus hierarchy.
 	 */
 	ocp {
-		compatible = "ti,omap3-l3-smx", "simple-bus";
+		compatible = "simple-bus";
 		reg = <0x44000000 0x10000>;
 		interrupts = <9 10>;
 		#address-cells = <1>;
-- 
2.1.4
