From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Fri, 05 Oct 2012 18:56:30 +0530
Subject: [PATCH] ARM: EXYNOS5: Remove wrongly placed usb2.0 PHY_CFG definition
 from PMU_REG
Message-ID: <1349443590-29901-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EXYNOS5_USB_CFG macro should actually point to USB20PHY_CFG
system register (base addr + 0x230). It's wrongly placed in regs-pmu.
Actual register at offset 0x230 in PMU is SEQ_TRANSITION4.

Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
---
 arch/arm/mach-exynos/include/mach/regs-pmu.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/include/mach/regs-pmu.h b/arch/arm/mach-exynos/include/mach/regs-pmu.h
index d4e392b..70b2795 100644
--- a/arch/arm/mach-exynos/include/mach/regs-pmu.h
+++ b/arch/arm/mach-exynos/include/mach/regs-pmu.h
@@ -230,8 +230,6 @@
 
 /* For EXYNOS5 */
 
-#define EXYNOS5_USB_CFG						S5P_PMUREG(0x0230)
-
 #define EXYNOS5_AUTO_WDTRESET_DISABLE				S5P_PMUREG(0x0408)
 #define EXYNOS5_MASK_WDTRESET_REQUEST				S5P_PMUREG(0x040C)
 
-- 
1.7.6.5
