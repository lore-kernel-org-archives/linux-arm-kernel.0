From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 28 Jan 2010 00:26:07 +0000
Subject: [PATCH 2/2] ARM: S5PC1XX: Add ARM_L1_CACHE_SHIFT_6 in ARCH_S5PC1XX
In-Reply-To: <1264637609-15001-1-git-send-email-kgene.kim@samsung.com>
References: <1264637609-15001-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100128002607.GN10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 09:13:29AM +0900, Kukjin Kim wrote:
> This patch add ARM_L1_CACHE_SHIFT_6 in ARCH_S5PC1XX.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/Kconfig    |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index c7e98ed..4e7d72e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -651,6 +651,7 @@ config ARCH_S5PC1XX
>  	select GENERIC_GPIO
>  	select HAVE_CLK
>  	select CPU_V7
> +	select ARM_L1_CACHE_SHIFT_6
>  	help
>  	  Samsung S5PC1XX series based systems

You'll need to merge this with the previous patch, otherwise you have
a functionaltiy breakage in between that patch and this. Kconfig will
override the .config and thus re-write the cache-shift configuration

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
