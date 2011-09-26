From: pullip.cho@samsung.com (KyongHo Cho)
Date: Mon, 26 Sep 2011 19:24:14 +0900
Subject: [PATCH 0/4 v2] iommu/exynos: Add IOMMU and Enhance System MMU
	driver for Exynos4
In-Reply-To: <CAHQjnOMCU26ELOpn7h7hcju-s970SSG5E545rPgCpw3_LkkAhA@mail.gmail.com>
References: <CAHQjnOMCU26ELOpn7h7hcju-s970SSG5E545rPgCpw3_LkkAhA@mail.gmail.com>
Message-ID: <CAHQjnOODq2bSzSYA9QT8fZagD5sxwtgVytR7Sv2s09wYao=pVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I am sorry :(

My mailer converted tabs into spaces.

Moreover, git send-email is not available now.

I stopped sending patches after sending "[PATCH 1/4 v2]".

I will submit the complete patches after everything becomes OK.

Sorry for disrupting.

Regards,
Cho KyongHo.

On Mon, Sep 26, 2011 at 7:00 PM, KyongHo Cho <pullip.cho@samsung.com> wrote:
> This is the second try of submitting patches about IOMMU/System MMU
> driver for Exynos4 SoCs with the fixes of the following problems
> pointed by Russell King.:
> ?- Missing unlocking a spinlock in exynos_iommu_attach_dev().
> ?- atomic_t -> int in sysmmu_drvdata.activations
> ?- sysmmu_platdata -> sysmmu_drvdata
> ?- Change in error messages in irq handler
> ?- Removed casting in format of error message
> ?- omap_iommu_ops -> exynos_iommu_ops in the last patch.
>
> First 2 patches enhance System MMU platform device definition:
> ?- Removed System MMU for MDMA0 in LCD block because it is not used.
> ?Use MDMA2 in TOP block.
> ?- Removed System MMU ID. Instead a System MMU is bound to a device that
> ?the System MMU is dedicated during machin initialization. If a device
> ?driver wants to handle System MMU, it must bind its device with System
> ?MMU with sysmmu_set_owner().
> ?- clkdev
> ?- System MMU device driver is removed from arch/arm/plat-s5p to move it
> ?to driver/iommu directory.
> Last 2 patches implements IOMMU API:
> ?- Implements IOMMU API and System MMU driver that is moved from
> ?arch/arm/plat-s5p.
> ?- Implements fault handling that is suggested by Ohad.
> ?- Used bus_set_iommu instead of register_iommu that is suggested by Joerg.
>
> Regards,
> Cho KyongHo.
>
> Diffstats:
>
> arch/arm/mach-exynos4/Kconfig ? ? ? ? ? ? ? | ? ?2 -
> arch/arm/mach-exynos4/clock.c ? ? ? ? ? ? ? | ? 43 +-
> arch/arm/mach-exynos4/dev-sysmmu.c ? ? ? ? ?| ?270 ++------
> arch/arm/mach-exynos4/include/mach/irqs.h ? | ? ?1 -
> arch/arm/mach-exynos4/include/mach/map.h ? ?| ? ?1 -
> arch/arm/mach-exynos4/include/mach/sysmmu.h | ? 85 ++-
> arch/arm/mach-exynos4/mach-armlex4210.c ? ? | ? 24 +-
> arch/arm/mach-exynos4/mach-smdkv310.c ? ? ? | ? 28 +-
> arch/arm/plat-s5p/Kconfig ? ? ? ? ? ? ? ? ? | ? ?8 -
> arch/arm/plat-s5p/Makefile ? ? ? ? ? ? ? ? ?| ? ?1 -
> arch/arm/plat-s5p/include/plat/sysmmu.h ? ? | ? 95 ---
> arch/arm/plat-s5p/sysmmu.c ? ? ? ? ? ? ? ? ?| ?312 ---------
> drivers/iommu/Kconfig ? ? ? ? ? ? ? ? ? ? ? | ? 14 +
> drivers/iommu/Makefile ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
> drivers/iommu/exynos_iommu.c ? ? ? ? ? ? ? ?| ?933 +++++++++++++++++++++++++++
> 15 files changed, 1134 insertions(+), 684 deletions(-)
>
