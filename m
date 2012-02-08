From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Feb 2012 08:47:16 +0000
Subject: [PATCH] ARM: EXYNOS: Configure ARM_NR_BANKS for EXYNOS SoC
In-Reply-To: <003201cce600$81c8f100$855ad300$%kim@samsung.com>
References: <003201cce600$81c8f100$855ad300$%kim@samsung.com>
Message-ID: <20120208084716.GG889@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 10:25:13AM +0900, Boojin Kim wrote:
> This patch increases the number of bank for EXYNOS4 and EXYNOS5
> to support bigger than 2GB memory on it.
> 
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> ---
>  arch/arm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f9d7c47..d646810 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1134,7 +1134,7 @@ source arch/arm/mm/Kconfig
> 
>  config ARM_NR_BANKS
>  	int
> -	default 16 if ARCH_EP93XX
> +	default 16 if ARCH_EP93XX || ARCH_EXYNOS4 || ARCH_EXYNOS5

ARCH_EXYNOS ?
