From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 14 Jun 2017 14:39:22 +0200
Subject: [PATCH 01/23] arm: aspeed: Add clock-names property to timer node
In-Reply-To: <20170614123800.GH2261@mai>
References: <20170614123800.GH2261@mai>
Message-ID: <1497443984-12371-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jeffery <andrew@aj.id.au>

The merging of a number of clocksource drivers into fttmr010 means we
require clock-names to be specified in the Aspeed timer node, else the
clocksource fails to probe and boot hangs.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 1 +
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 8c6bc29..3e74929 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -893,6 +893,7 @@
 				//interrupts = <16 17 18 35 36 37 38 39>;
 				interrupts = <16>;
 				clocks = <&clk_apb>;
+				clock-names = "PCLK";
 			};
 
 			wdt1: wdt at 1e785000 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index a0bea4a..1e6c701 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -1000,6 +1000,7 @@
 				//interrupts = <16 17 18 35 36 37 38 39>;
 				interrupts = <16>;
 				clocks = <&clk_apb>;
+				clock-names = "PCLK";
 			};
 
 
-- 
2.7.4
