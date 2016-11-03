From: jacopo@jmondi.org (Jacopo Mondi)
Date: Thu,  3 Nov 2016 14:42:54 +0100
Subject: [PATCH] ARM: DTS: r8a7794: alt: Fix PCF names for DU
Message-ID: <1478180574-15464-1-git-send-email-jacopo@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the PCF pin groups and function names of DU interface for
r8a7794 ALT board.

The currently specified pin groups and function names prevented PCF and
DU interfaces from being correctly configured:

sh-pfc e6060000.pin-controller: function 'du' not supported
sh-pfc e6060000.pin-controller: invalid function du in map table
sh-pfc e6060000.pin-controller: function 'du' not supported
sh-pfc e6060000.pin-controller: invalid function du in map table
sh-pfc e6060000.pin-controller: function 'du' not supported
sh-pfc e6060000.pin-controller: invalid function du in map table
sh-pfc e6060000.pin-controller: function 'du' not supported
sh-pfc e6060000.pin-controller: invalid function du in map table
rcar-du: probe of feb00000.display failed with error -22

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---

Patch applied against Simon Horman's renesas/master branch.
The PCF pin groups and function renaming was introduced by commit 56ed4bb9 and
DTS for ALT board has never been update accordingly.
Tested displaying frames on VGA interface: the rcar-du driver loads correctly.

 arch/arm/boot/dts/r8a7794-alt.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 8d1b35a..9d65fb3 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -165,8 +165,8 @@
 	pinctrl-names = "default";
 
 	du_pins: du {
-		groups = "du1_rgb666", "du1_sync", "du1_disp", "du1_dotclkout0";
-		function = "du";
+		groups = "du1_rgb666", "du1_sync", "du1_disp", "du1_clk0_out";
+		function = "du1";
 	};
 
 	scif2_pins: scif2 {
-- 
2.7.4
