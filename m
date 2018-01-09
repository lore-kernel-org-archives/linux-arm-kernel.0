From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue,  9 Jan 2018 19:59:21 +0100
Subject: [PATCH] mfd: syscon: Remove unused Exynos PMU headers
Message-ID: <20180109185921.28260-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 5812f0106c44 ("phy: exynos4: Remove duplicated defines of
PHY register defines") and commit 7a66647b25b6 ("phy: exynos: Use one
define for enable bit") all users of syscon Exynos PMU headers (for PHY
drivers) are converted to use different headers so these can be removed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Actually I removed these headers in mentioned commits:
 - https://www.spinics.net/lists/arm-kernel/msg568612.html
 - https://www.spinics.net/lists/arm-kernel/msg568608.html
however this part of patch disappeared when applying...
---
 include/linux/mfd/syscon/exynos4-pmu.h | 21 ---------------------
 include/linux/mfd/syscon/exynos5-pmu.h | 19 -------------------
 2 files changed, 40 deletions(-)
 delete mode 100644 include/linux/mfd/syscon/exynos4-pmu.h
 delete mode 100644 include/linux/mfd/syscon/exynos5-pmu.h

diff --git a/include/linux/mfd/syscon/exynos4-pmu.h b/include/linux/mfd/syscon/exynos4-pmu.h
deleted file mode 100644
index 278b1b1549e9..000000000000
--- a/include/linux/mfd/syscon/exynos4-pmu.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright (C) 2015 Samsung Electronics Co., Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _LINUX_MFD_SYSCON_PMU_EXYNOS4_H_
-#define _LINUX_MFD_SYSCON_PMU_EXYNOS4_H_
-
-/* Exynos4 PMU register definitions */
-
-/* MIPI_PHYn_CONTROL register offset: n = 0..1 */
-#define EXYNOS4_MIPI_PHY_CONTROL(n)	(0x710 + (n) * 4)
-#define EXYNOS4_MIPI_PHY_ENABLE		(1 << 0)
-#define EXYNOS4_MIPI_PHY_SRESETN	(1 << 1)
-#define EXYNOS4_MIPI_PHY_MRESETN	(1 << 2)
-#define EXYNOS4_MIPI_PHY_RESET_MASK	(3 << 1)
-
-#endif /* _LINUX_MFD_SYSCON_PMU_EXYNOS4_H_ */
diff --git a/include/linux/mfd/syscon/exynos5-pmu.h b/include/linux/mfd/syscon/exynos5-pmu.h
deleted file mode 100644
index b4942a32b81d..000000000000
--- a/include/linux/mfd/syscon/exynos5-pmu.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Exynos5 SoC series Power Management Unit (PMU) register offsets
- * and bit definitions.
- *
- * Copyright (C) 2014 Samsung Electronics Co., Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _LINUX_MFD_SYSCON_PMU_EXYNOS5_H_
-#define _LINUX_MFD_SYSCON_PMU_EXYNOS5_H_
-
-#define EXYNOS5_PHY_ENABLE			BIT(0)
-#define EXYNOS5_MIPI_PHY_S_RESETN		BIT(1)
-#define EXYNOS5_MIPI_PHY_M_RESETN		BIT(2)
-
-#endif /* _LINUX_MFD_SYSCON_PMU_EXYNOS5_H_ */
-- 
2.11.0
