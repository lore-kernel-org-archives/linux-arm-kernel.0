From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Mon,  9 Oct 2017 10:48:35 +0200
Subject: [PATCH 2/2] ARM: dts: gr-peach: Enable ostm0 and ostm1 timers
In-Reply-To: <1507538915-16566-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1507538915-16566-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1507538915-16566-3-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
---
 arch/arm/boot/dts/r7s72100-gr-peach.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
index 990435c..9e9e890 100644
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
2.7.4
