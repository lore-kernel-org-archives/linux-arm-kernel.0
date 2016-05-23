From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 23 May 2016 11:30:06 +0200
Subject: [PATCH 0/3] Exynos IOMMU: improve clock management
Message-ID: <1463995809-26862-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series improves clock management in Exynos IOMMU driver, so
the driver will be ready for potential deferred probe caused by
not-yet-available clocks. Such case doesn't happen with current kernel,
but it may happen with the planned rework on clocks and power domain
code.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Marek Szyprowski (3):
  iommu/exynos: Return proper errors from getting clocks
  iommu/exynos: Fix master clock management for inactive SYSMMU
  iommu/exynos: Prepare clocks when needed, not in driver probe

 drivers/iommu/exynos-iommu.c | 95 ++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 53 deletions(-)

-- 
1.9.2
