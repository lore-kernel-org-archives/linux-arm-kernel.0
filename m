From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 22 Aug 2013 11:41:56 -0300
Subject: [PATCH 5/7] ARM: kirkwood: Update watchdog 'reg' property
In-Reply-To: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377182518-12554-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1377182518-12554-6-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the new DT binding, the 'reg' property requires
three cells, which mean: timer control register, watchdog counter
register, and rstout register, respectively.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood.dtsi b/arch/arm/boot/dts/kirkwood.dtsi
index 9809fc1..5fba37b 100644
--- a/arch/arm/boot/dts/kirkwood.dtsi
+++ b/arch/arm/boot/dts/kirkwood.dtsi
@@ -105,7 +105,9 @@
 
 		wdt at 20300 {
 			compatible = "marvell,orion-wdt";
-			reg = <0x20300 0x28>;
+			reg = <0x20300 0x4>, /* Timer control */
+			      <0x20324 0x4>, /* Watchdog counter */
+			      <0x20108 0x4>; /* RSTOUT */
 			clocks = <&gate_clk 7>;
 			status = "okay";
 		};
-- 
1.8.1.5
