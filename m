From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 28 Jan 2010 00:24:55 +0000
Subject: [PATCH 1/2 RE-SEND] ARM: MM: Add ARM_L1_CACHE_SHIFT_6 for
	handle inside each ARCH Kconfig
In-Reply-To: <1264637603-14967-1-git-send-email-kgene.kim@samsung.com>
References: <1264637603-14967-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100128002455.GM10014@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 09:13:23AM +0900, Kukjin Kim wrote:
> This patch adds ARM_L1_CACHE_SHIFT_6 into arch/arm/Kconfig. Basically,
> ARM L1 cache line size is 32Bytes. Therefore, whenever new ARCH which
> has 64Bytes L1 cache line size is added, have to set ARM_L1_CACHE_SHIFT
> to 6. That is, have to add/modify arch/arm/mm/Kconfig.
> This patch is for handle it in each ARCH such as ARCH_S5PC1XX, and
> ARCH_S5PV210 which is in review.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/Kconfig    |    5 +++++
>  arch/arm/mm/Kconfig |    2 +-
>  2 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a5602ec..c7e98ed 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -161,6 +161,11 @@ config ARCH_MTD_XIP
>  config GENERIC_HARDIRQS_NO__DO_IRQ
>  	def_bool y
>  
> +config ARM_L1_CACHE_SHIFT_6
> +	bool
> +	help
> +	  Setting ARM L1 cache line size to 64 Bytes.
> +
>  if OPROFILE
>  
>  config OPROFILE_ARMV6
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 91617f7..ad0b8d3 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -779,5 +779,5 @@ config CACHE_XSC3L2
>  
>  config ARM_L1_CACHE_SHIFT
>  	int
> -	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
> +	default 6 if ARCH_OMAP3 || ARM_L1_CACHE_SHIFT_6
>  	default 5

A couple of comments:

1) Change ARCH_OMAP3 to use this
2) Could ARM_L1_CACHE_SHIFT_6 go before this, or is there an ordering issue?

> -- 
> 1.6.2.5
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
