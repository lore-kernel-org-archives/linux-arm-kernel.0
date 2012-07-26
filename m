From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Jul 2012 11:24:49 +0000
Subject: [PATCH 2/8 v2] ARM: EXYNOS5: Add machine data for USB 2.0
In-Reply-To: <1342866729-30460-3-git-send-email-gautam.vivek@samsung.com>
References: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
 <1342866729-30460-3-git-send-email-gautam.vivek@samsung.com>
Message-ID: <201207261124.50141.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 July 2012, Vivek Gautam wrote:
> From: Ajay Kumar <ajaykumar.rs@samsung.com>
> 
> This patch adds address mapping of USB 2.0 PHY for exynos5
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  arch/arm/mach-exynos/common.c           |    5 +++++
>  arch/arm/mach-exynos/include/mach/map.h |    2 ++
>  2 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 4eb39cd..92d5e61 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -275,6 +275,11 @@ static struct map_desc exynos5_iodesc[] __initdata = {
>                 .pfn            = __phys_to_pfn(EXYNOS5_PA_GIC_DIST),
>                 .length         = SZ_4K,
>                 .type           = MT_DEVICE,
> +       }, {
> +               .virtual        = (unsigned long)S3C_VA_USB_HSPHY,
> +               .pfn            = __phys_to_pfn(EXYNOS5_PA_USB_PHY),
> +               .length         = SZ_4K,
> +               .type           = MT_DEVICE,
>         },
>  };

Can you pleae explain why this is done in the changelog?

We try hard to do such mappings from the device driver instead,
so I'm surprised that this is necessary fo rthe USB phy.

	Arnd
