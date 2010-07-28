From: ben@simtec.co.uk (Ben Dooks)
Date: Wed, 28 Jul 2010 19:13:59 +0100
Subject: [PATCH 3/5] ARM: S5P6440: Add RTC support for S5P6440
In-Reply-To: <1279702814-14929-4-git-send-email-kgene.kim@samsung.com>
References: <1279702814-14929-1-git-send-email-kgene.kim@samsung.com>
	<1279702814-14929-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <4C507367.1000206@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/07/10 10:00, Kukjin Kim wrote:
> From: Atul Dahiya <atul.dahiya@samsung.com>
> 
> This patch adds support RTC driver for Samsung S5P6440.
> 
> Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5p6440/Kconfig            |    2 ++
>  arch/arm/mach-s5p6440/include/mach/map.h |    2 +-
>  arch/arm/mach-s5p6440/mach-smdk6440.c    |    1 +
>  3 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-s5p6440/Kconfig b/arch/arm/mach-s5p6440/Kconfig
> index f066fae..b2d4716 100644
> --- a/arch/arm/mach-s5p6440/Kconfig
> +++ b/arch/arm/mach-s5p6440/Kconfig
> @@ -18,7 +18,9 @@ config MACH_SMDK6440
>  	select CPU_S5P6440
>  	select SAMSUNG_DEV_TS
>  	select SAMSUNG_DEV_ADC
> +	select S3C_DEV_RTC
>  	select S3C_DEV_WDT
> +	select HAVE_S3C_RTC
>  	select HAVE_S3C2410_WATCHDOG
>  	help
>  	  Machine support for the Samsung SMDK6440

I'm considering we shoudl just set HAVE_S3C_RTC for
each SOC, as allowing it to compile isn't going to
end up causing a problem. Adding it to each machine
will end up with large Kconfig entries for each.

-- 
Ben
