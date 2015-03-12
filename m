From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 12 Mar 2015 14:37:10 +0100
Subject: [PATCH v2 RESEND 3/4] ARM: dts: exynos5420: add async-bridge clocks to
 disp1 power domain
In-Reply-To: <1426167431-24470-1-git-send-email-a.hajda@samsung.com>
References: <1426167431-24470-1-git-send-email-a.hajda@samsung.com>
Message-ID: <1426167431-24470-4-git-send-email-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FIMD and MIXER IPs in disp1 power domain have async-bridges (to GSCALER),
therefore their clocks should be enabled during power domain switch.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index c0e98cf..55e3887 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -283,9 +283,11 @@
 			 <&clock CLK_MOUT_SW_ACLK300>,
 			 <&clock CLK_MOUT_USER_ACLK300_DISP1>,
 			 <&clock CLK_MOUT_SW_ACLK400>,
-			 <&clock CLK_MOUT_USER_ACLK400_DISP1>;
+			 <&clock CLK_MOUT_USER_ACLK400_DISP1>,
+			 <&clock CLK_FIMD1>, <&clock CLK_MIXER>;
 		clock-names = "oscclk", "pclk0", "clk0",
-			      "pclk1", "clk1", "pclk2", "clk2";
+			      "pclk1", "clk1", "pclk2", "clk2",
+			      "asb0", "asb1";
 	};
 
 	pinctrl_0: pinctrl at 13400000 {
-- 
1.9.1
