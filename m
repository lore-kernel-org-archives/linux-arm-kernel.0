From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  6 Mar 2013 16:29:23 +0100
Subject: [PATCH 1/5] ARM: sunxi: dt: Use clocks property instead of
 clock-frequency for the UARTs
In-Reply-To: <1362583767-13862-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1362583767-13862-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1362583767-13862-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0bbeb3c3 ("of serial port driver - add clk_get_rate() support") made
possible to use directly a clock phandle instead of a raw frequency
specified in the clock frequency attribute, so let's use it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sunxi.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi.dtsi b/arch/arm/boot/dts/sunxi.dtsi
index 8b36abe..791c02a 100644
--- a/arch/arm/boot/dts/sunxi.dtsi
+++ b/arch/arm/boot/dts/sunxi.dtsi
@@ -65,7 +65,7 @@
 			interrupts = <1>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clock-frequency = <24000000>;
+			clocks = <&osc>;
 			status = "disabled";
 		};
 
@@ -75,7 +75,7 @@
 			interrupts = <2>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clock-frequency = <24000000>;
+			clocks = <&osc>;
 			status = "disabled";
 		};
 	};
-- 
1.7.10.4
