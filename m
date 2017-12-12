From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Tue, 12 Dec 2017 14:31:10 -0700
Subject: [PATCH] ARM: exynos_defconfig - enable CONFIG_EXYNOS_IOMMU
Message-ID: <20171212213110.20893-1-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EXYNOS_IOMMU is disabled in exynos_defconfig since it is known to cause
boot failures on Exynos Chrome-books. The recommendation is for IOMMU to
be enabled manually on systems as needed.

A recent exynos_drm change added a warning message when EXYNOS_IOMMU is
disabled. It is necessary to enable it to avoid the warning messages.
A few initial tests have shown that enabling EXYNOS_IOMMU might be safe
on Exynos Chrome-books.

Enable CONFIG_EXYNOS_IOMMU in exynos_defconfig.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index f1d7834..0ccd5eb 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -281,6 +281,7 @@ CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
+CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_MAX14577=y
 CONFIG_EXTCON_MAX77693=y
-- 
2.7.4
