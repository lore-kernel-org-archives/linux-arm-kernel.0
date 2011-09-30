From: Joerg.Roedel@amd.com (Roedel, Joerg)
Date: Fri, 30 Sep 2011 15:42:43 +0200
Subject: [PATCH v2 2/5] ARM: S5P: Remove system MMU driver from
	arm/plat-s5p
In-Reply-To: <016d01cc7f42$e58a0aa0$b09e1fe0$%kim@samsung.com>
References: <016d01cc7f42$e58a0aa0$b09e1fe0$%kim@samsung.com>
Message-ID: <20110930134243.GR2138@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 03:30:57AM -0400, Kukjin Kim wrote:
> From: KyongHo Cho <pullip.cho@samsung.com>
> 
> Due to Ohad Ben-Cohen gathered IOMMU drivers in drivers/iommu directory,
> System MMU driver is moved to drivers/iommu directory and removed
> from arch/arm/plat-s5p directory.
> 
> Please see
> https://lkml.org/lkml/2011/6/8/69
> 
> Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/plat-s5p/Kconfig               |    8 -
>  arch/arm/plat-s5p/Makefile              |    1 -
>  arch/arm/plat-s5p/include/plat/sysmmu.h |   95 ----------
>  arch/arm/plat-s5p/sysmmu.c              |  312 -------------------------------

You can use 'git mv' to just move the file. This ensures bisectability
of your patches. No need to delete the code in one patch and re-add it
in the next one (which breaks bisectability).

	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo, Andrew Bowd
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
