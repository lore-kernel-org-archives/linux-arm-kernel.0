From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:29 +0200
Subject: [PATCH 02/42] ARM: dts: gr-peach: Enable MTU2 timer pulse unit
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <62cea6d2c6758d6a9513ecf3c70498623d5bf1d2.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

MTU2 multi-function/multi-channel timer/counter is not enabled for
GR-Peach board. The timer is used as clock event source to schedule
wake-ups, and without this enabled all sleeps not performed through busy
waiting hang the board.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100-gr-peach.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
index a1c5e8823d2b..9661d43f5236 100644
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
2.11.0
