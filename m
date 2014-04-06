From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Sun,  6 Apr 2014 18:32:18 +0200
Subject: [PATCH] arm/igep0020: fix IGEPv2 boot
Message-ID: <1396801938-24788-1-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Booting Linux 3.14 compiled with omap2plus_defconfig on IGEPv2 board
currrently results in the same issue as reported here:

https://www.mail-archive.com/linux-media at vger.kernel.org/msg69556.html

The following change avoids this.

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/boot/dts/omap3-igep.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
index c1700932..c15c3ef 100644
--- a/arch/arm/boot/dts/omap3-igep.dtsi
+++ b/arch/arm/boot/dts/omap3-igep.dtsi
@@ -207,6 +207,10 @@
        pinctrl-0 = <&uart3_pins>;
 };
 
+&uart4 {
+       status = "disabled";
+};
+
 &twl_gpio {
 	ti,use-leds;
 };
-- 
1.7.10.4
