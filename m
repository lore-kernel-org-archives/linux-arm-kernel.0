From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 06 Dec 2011 18:30:37 +0900
Subject: [PATCH v2 1/3] ARM: EXYNOS: Add USB OHCI device
In-Reply-To: <4EDDDCAB.1000001@linaro.org>
References: <001101ccb3e0$7fe48270$7fad8750$%han@samsung.com>
 <001301ccb3e0$b5fec280$21fc4780$%han@samsung.com>
 <4EDDDCAB.1000001@linaro.org>
Message-ID: <000d01ccb3f9$b6bbc790$243356b0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tushar Behera wrote:
> Subject: Re: [PATCH v2 1/3] ARM: EXYNOS: Add USB OHCI device
> 
> On Tuesday 06 December 2011 12:01 PM, Jingoo Han wrote:
> > This patch adds USB ohci device definition for Exynos SoCs.
> >
> > Signed-off-by: Jingoo Han<jg1.han@samsung.com>
> > ---
> >   arch/arm/mach-exynos/Kconfig              |    5 +++
> >   arch/arm/mach-exynos/Makefile             |    1 +
> >   arch/arm/mach-exynos/dev-ohci.c           |   52 +++++++++++++++++++++++++++++
> >   arch/arm/mach-exynos/include/mach/map.h   |    1 +
> >   arch/arm/mach-exynos/include/mach/ohci.h  |   21 +++++++++++
> 
> In the earlier patchset, platform_device struct for ohci was defined
> within plat-samsung, and ohci.h was located in
> plat-samsung/include/plat. These are still the locations where ehci
> related definitions are located.
> 
> What is the reason for movement of ohci related definitions to mach folder?
I changed the ohci name from ohci-s5p to ohci-exynos, because the ohci-exynos
is used for exynos series such as Exynos4210 & Exynos4x12.
Therefore, it should be located within mach-exynos/include/mach.

Also, If this patchset is accepted, I will move Samsung ehci definitions
to mach-exynos due to the same reason.

Thanks.
> 
> --
> Tushar Behera
