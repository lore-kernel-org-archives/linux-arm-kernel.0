From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:47 +0200
Subject: [PATCH 20/42] ARM: dts: gr-peach: Enable ostm0 and ostm1 timers
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <1126e108a3ad8ae92a0532259e3da4b14072355f.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Enable ostm0 and ostm1 timers to be used as clock source and clockevent
source. The timers provides greater accuracy than the already enabled
mtu2 one.

With these enabled:

clocksource: ostm: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 57352151442 ns
sched_clock: 32 bits at 33MHz, resolution 30ns, wraps every 64440619504ns
ostm: used for clocksource
ostm: used for clock events

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Suggested-by: Chris Brandt <chris.brandt@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-gr-peach.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
index eca14e3801ec..779f724b4531 100644
--- a/arch/arm/boot/dts/r7s72100-gr-peach.dts
+++ b/arch/arm/boot/dts/r7s72100-gr-peach.dts
@@ -104,6 +104,14 @@
 	status = "okay";
 };
 
+&ostm0 {
+	status = "okay";
+};
+
+&ostm1 {
+	status = "okay";
+};
+
 &scif2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&scif2_pins>;
-- 
2.11.0
