From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 6 Jul 2016 14:41:41 +0800
Subject: [PATCH 3/3] arm64: dts: berlin4ct: enable all wdt nodes
 unconditionally
In-Reply-To: <1467787301-3728-1-git-send-email-jszhang@marvell.com>
References: <1467787301-3728-1-git-send-email-jszhang@marvell.com>
Message-ID: <1467787301-3728-4-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit f29a72c24ad4 ("watchdog: dw_wdt: Convert to use watchdog
infrastructure"), the dw_wdt driver can support multiple variants, so
unconditionally enable all dw_wdt nodes now.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm64/boot/dts/marvell/berlin4ct.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
index 099ad93..c8e07e0 100644
--- a/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/marvell/berlin4ct.dtsi
@@ -279,7 +279,6 @@
 				reg = <0x4000 0x100>;
 				clocks = <&osc>;
 				interrupts = <1>;
-				status = "disabled";
 			};
 
 			wdt2: watchdog at 5000 {
@@ -287,7 +286,6 @@
 				reg = <0x5000 0x100>;
 				clocks = <&osc>;
 				interrupts = <2>;
-				status = "disabled";
 			};
 
 			sm_gpio0: gpio at 8000 {
-- 
2.8.1
