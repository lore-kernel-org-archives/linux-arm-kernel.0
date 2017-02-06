From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 6 Feb 2017 13:17:00 +0100
Subject: [PATCH] iommu: mtk: remove bogus 'select' statements
In-Reply-To: <20170202142921.3467470-1-arnd@arndb.de>
References: <20170202142921.3467470-1-arnd@arndb.de>
Message-ID: <20170206121700.GC25981@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 03:29:03PM +0100, Arnd Bergmann wrote:
> The mediatek IOMMU driver enables some drivers that it does not directly
> rely on, and that causes a warning for build testing:
> 
> warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_VDECSYS which has unmet direct dependencies (COMMON_CLK && COMMON_CLK_MT2701)
> warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_IMGSYS which has unmet direct dependencies (COMMON_CLK && COMMON_CLK_MT2701)
> warning: (MTK_IOMMU_V1) selects COMMON_CLK_MT2701_MMSYS which has unmet direct dependencies (COMMON_CLK && COMMON_CLK_MT2701)
> 
> This removes the select statements.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
