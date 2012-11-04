From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 4 Nov 2012 18:36:41 +0530
Subject: [PATCH v3 10/11] ARM: davinci - migrate to common clock
In-Reply-To: <1351181518-11882-11-git-send-email-m-karicheri2@ti.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-11-git-send-email-m-karicheri2@ti.com>
Message-ID: <50966861.4040500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2012 9:41 PM, Murali Karicheri wrote:
> Currently migrate only DM644x as this is being reviewed. Once all
> platforms are migrated, the Makefile will be cleaned up to remove
> obsoleted files clock.o and psc.o
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  arch/arm/Kconfig               |    1 +
>  arch/arm/mach-davinci/Kconfig  |    2 ++
>  arch/arm/mach-davinci/Makefile |   11 ++++++++++-
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c5f9ae5..4611987 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -967,6 +967,7 @@ config ARCH_DAVINCI
>  	select ARCH_REQUIRE_GPIOLIB
>  	select ZONE_DMA
>  	select HAVE_IDE
> +	select COMMON_CLK
>  	select CLKDEV_LOOKUP
>  	select GENERIC_ALLOCATOR
>  	select GENERIC_IRQ_CHIP

This list has to be sorted. Russell has a patch which fixed this all
across arch/arm/* which got merged for v3.7. This patch does not apply
to v3.7-rc3 anymore due to the same reason.

Thanks,
Sekhar
