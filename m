From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 14 Jan 2015 15:04:05 -0800
Subject: [PATCH] ARM: ARM_KERNMEM_PERMS only works with MMU enabled
In-Reply-To: <1976703.4VfV2sWda0@wuerfel>
References: <1976703.4VfV2sWda0@wuerfel>
Message-ID: <54B6F5E5.7060202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/13/2015 6:14 AM, Arnd Bergmann wrote:
> The recently added ARM_KERNMEM_PERMS feature works by manipulating
> the kernel page tables, which obviously requires an MMU. Trying
> to enable this feature when the MMU is disabled results in a lot
> of compile errors in mm/init.c, so let's add a Kconfig dependency
> to avoid that case.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index eaaf196fe4e1..0051cd924fb1 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -1010,6 +1010,7 @@ config ARCH_SUPPORTS_BIG_ENDIAN
>
>   config ARM_KERNMEM_PERMS
>   	bool "Restrict kernel memory permissions"
> +	depends on MMU
>   	help
>   	  If this is set, kernel memory other than kernel text (and rodata)
>   	  will be made non-executable. The tradeoff is that each region is
>
>

Acked-by: Laura Abbott <lauraa@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
