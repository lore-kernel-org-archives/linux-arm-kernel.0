From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 17 Jul 2014 11:08:43 +0200
Subject: [PATCH 03/14] ARM: sunxi: sun5i: Enforce max frequency on PLL6
In-Reply-To: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1405588134-2396-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1405588134-2396-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PLL6 out of reset is running at 2.4GHz, which is outside of its operating
boundaries.

Enforce its maximum frequency as set in the datasheet to make sure we stays
within these bounds.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index bf86e65dd167..de89edc5e5b3 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -97,6 +97,7 @@
 			reg = <0x01c20028 0x4>;
 			clocks = <&osc24M>;
 			clock-output-names = "pll6_sata", "pll6_other", "pll6";
+			clock-max-frequency = <1200000000>;
 		};
 
 		/* dummy is 200M */
-- 
2.0.1
