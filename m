From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 18 Aug 2011 15:38:18 +0200
Subject: [PATCH 2/7] omap: iommu/iovmm: move to dedicated iommu folder
In-Reply-To: <1313622608-30397-3-git-send-email-ohad@wizery.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
	<1313622608-30397-3-git-send-email-ohad@wizery.com>
Message-ID: <201108181538.18480.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 18 August 2011, Ohad Ben-Cohen wrote:
>  arch/arm/plat-omap/Kconfig                         |   14 --------------
>  arch/arm/plat-omap/Makefile                        |    2 --
>  arch/arm/plat-omap/{ => include/plat}/iopgtable.h  |    0
>  drivers/iommu/Kconfig                              |   18 ++++++++++++++++++
>  drivers/iommu/Makefile                             |    3 +++
>  .../iommu/omap-iommu-debug.c                       |    2 +-
>  .../iommu.c => drivers/iommu/omap-iommu.c          |    2 +-
>  .../iovmm.c => drivers/iommu/omap-iovmm.c          |    2 +-
>  drivers/media/video/Kconfig                        |    2 +-

Do you need the header file to be globally visible?

If not, I think it would be better to move it to the iommu directory along with the
files using it.

	Arnd
