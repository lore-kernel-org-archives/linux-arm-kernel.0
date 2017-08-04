From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 4 Aug 2017 11:56:03 +0200
Subject: [PATCH] iommu/exynos: prevent building on big-endian kernels
In-Reply-To: <20170728131954.213595-1-arnd@arndb.de>
References: <20170728131954.213595-1-arnd@arndb.de>
Message-ID: <20170804095603.GA17443@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 28, 2017 at 03:19:19PM +0200, Arnd Bergmann wrote:
> Since we print the correct warning, an allmodconfig build is no longer
> clean but always prints it, which defeats compile-testing:
> 
> drivers/iommu/exynos-iommu.c:58:2: error: #warning "revisit driver if we can enable big-endian ptes" [-Werror=cpp]
> 
> This replaces the #warning with a dependency, moving warning text into
> a comment.
> 
> Fixes: 1f59adb1766d ("iommu/exynos: Replace non-existing big-endian Kconfig option")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks.
