From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 15 Jan 2015 14:51:10 +0100
Subject: [PATCH] ARM: dts: Fix CLK_UART_ISP_SCLK clock assignment in
 exynos4x12.dtsi
Message-ID: <1421329871-18819-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Assign proper FIMC-IS UART gate clock in the device DT node and not
use the SRC_MASK gate. This fixes regression introduced in commit
a37c82a3b3c0910019abfd22a97be1f ("clk: samsung: exynos4: Remove
SRC_MASK_ISP gates").

Without this change exynos4 fimc-is driver fails to probe with an
error log:

[    1.842447] ERROR: could not get clock /camera/fimc-is at 12000000:uart(13)
[    1.848529] exynos4-fimc-is 12000000.fimc-is: failed to get clock: uart
[    1.855275] exynos4-fimc-is: probe of 12000000.fimc-is failed with error -2

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---

Kukjin, could you take this patch into your tree ? I have been applying it
for several kernel releases now to get the Exynos4 FIMC driver even passing
probing.

Thanks,
Sylwester
 arch/arm/boot/dts/exynos4x12.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index 93b7040..86e1800 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -225,7 +225,7 @@
 				 <&clock CLK_DIV_ISP0>,<&clock CLK_DIV_ISP1>,
 				 <&clock CLK_DIV_MCUISP0>,
 				 <&clock CLK_DIV_MCUISP1>,
-				 <&clock CLK_SCLK_UART_ISP>,
+				 <&clock CLK_UART_ISP_SCLK>,
 				 <&clock CLK_ACLK200>, <&clock CLK_DIV_ACLK200>,
 				 <&clock CLK_ACLK400_MCUISP>,
 				 <&clock CLK_DIV_ACLK400_MCUISP>;
--
1.7.9.5
