From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Thu,  5 Oct 2017 10:58:19 +0200
Subject: [PATCH 2/3] ARM: dts: gr-peach: Enable MTU2 timer pulse unit
In-Reply-To: <1507193900-23801-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1507193900-23801-1-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <1507193900-23801-3-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MTU2 multi-function/multi-channel timer/counter is not enabled for
GR-Peach board. The timer is used as clock event source to schedule
wake-ups, and without this enabled all sleeps not performed through busy
waiting hang the board.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm/boot/dts/r7s72100-gr-peach.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
index 20309ac..ad6a627 100644
--- a/arch/arm/boot/dts/r7s72100-gr-peach.dts
+++ b/arch/arm/boot/dts/r7s72100-gr-peach.dts
@@ -78,6 +78,10 @@
 	clock-frequency = <48000000>;
 };
 
+&mtu2 {
+	status = "okay";
+};
+
 &scif2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&scif2_pins>;
-- 
2.7.4
