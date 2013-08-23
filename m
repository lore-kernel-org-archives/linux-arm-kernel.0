From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 19:12:21 -0300
Subject: [PATCH v2 8/9] ARM: kirkwood: Update watchdog 'reg' property
In-Reply-To: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377295942-5955-9-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the new DT binding, the 'reg' property requires
two cells, which mean: timer control register and watchdog counter
register respectively.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 9809fc1..6443e12 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -105,7 +105,8 @@
 
 		wdt at 20300 {
 			compatible = "marvell,orion-wdt";
-			reg = <0x20300 0x28>;
+			reg = <0x20300 0x4>, /* Timer control */
+			      <0x20324 0x4>; /* Watchdog counter */
 			clocks = <&gate_clk 7>;
 			status = "okay";
 		};
-- 
1.8.1.5
