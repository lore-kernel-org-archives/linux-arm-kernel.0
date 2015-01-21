From: liquid.acid@gmx.net (Tobias Jakobi)
Date: Thu, 22 Jan 2015 00:37:28 +0100
Subject: [PATCH v4 00/18] Exynos SYSMMU (IOMMU) integration with
 DT and DMA-mapping subsystem
In-Reply-To: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
References: <1421399592-7482-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <54C03838.4080008@gmx.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

just some warnings I encountered when compiling this today:
drivers/iommu/exynos-iommu.c: In function ?exynos_iommu_of_setup?:
drivers/iommu/exynos-iommu.c:1177:2: warning: passing argument 2 of
?of_iommu_set_ops? discards ?const? qualifier from pointer target type
[enabled by default]
  of_iommu_set_ops(np, &exynos_iommu_ops);
  ^
In file included from drivers/iommu/exynos-iommu.c:23:0:
include/linux/of_iommu.h:34:6: note: expected ?struct iommu_ops *? but
argument is of type ?const struct iommu_ops *?
 void of_iommu_set_ops(struct device_node *np, struct iommu_ops *ops);
      ^


I guess the 'const' should be dropped from exynos_iommu_ops, even though
I wonder why of_iommu_set_ops wants a non-const pointer (can/does it
modify the struct later on?).

With best wishes,
Tobias
