From: ykaneko0929@gmail.com (Yoshihiro Kaneko)
Date: Tue, 29 May 2018 16:01:02 +0900
Subject: [PATCH v2] arm64: dts: renesas: r8a77965: Add Watchdog Timer
 controller node using RCLK Watchdog Timer
Message-ID: <1527577262-8754-1-git-send-email-ykaneko0929@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

Add a device node for the Watchdog Timer (WDT) controller on the Renesas
R-Car M3-N (R8A77965) SoC.

Based on a similar patch of the R8A7796 device tree
by Geert Uytterhoeven <geert+renesas@glider.be>.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

This patch is based on the devel branch of Simon Horman's renesas tree.

v2 [Yoshihiro Kaneko]
- add tags
* As suggested by Geert Uytterhoeven
- fix the summary prefix of the subject
- fix the notation of the name of SoC

 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 486aeca..fb7100f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -139,8 +139,13 @@
 		ranges;
 
 		wdt0: watchdog at e6020000 {
+			compatible = "renesas,r8a77965-wdt",
+				     "renesas,rcar-gen3-wdt";
 			reg = <0 0xe6020000 0 0x0c>;
-			/* placeholder */
+			clocks = <&cpg CPG_MOD 402>;
+			power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
+			resets = <&cpg 402>;
+			status = "disabled";
 		};
 
 		gpio0: gpio at e6050000 {
-- 
1.9.1
