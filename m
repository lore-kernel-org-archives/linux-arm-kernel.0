From: mbenes@suse.cz (Miroslav Benes)
Date: Wed, 18 Jan 2017 13:40:23 +0100 (CET)
Subject: [PATCH 7/7] arm: Add livepatch necessary arch selects into Kconfig
In-Reply-To: <1481043967-15602-8-git-send-email-abelvesa@linux.com>
References: <1481043967-15602-1-git-send-email-abelvesa@linux.com>
 <1481043967-15602-8-git-send-email-abelvesa@linux.com>
Message-ID: <alpine.LSU.2.20.1701181339350.23458@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Dec 2016, Abel Vesa wrote:

> This adds HAVE_LIVEPATCH, MODULES_USE_ELF_RELA and HAVE_LIVEPATCH
> to arm Kconfig.
> 
> Signed-off-by: Abel Vesa <abelvesa@linux.com>
> ---
>  arch/arm/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 186c4c2..f4e9ace 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -50,6 +50,7 @@ config ARM
>  	select HAVE_DMA_API_DEBUG
>  	select HAVE_DMA_CONTIGUOUS if MMU
>  	select HAVE_DYNAMIC_FTRACE if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
> +	select HAVE_DYNAMIC_FTRACE_WITH_REGS
>  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
>  	select HAVE_EXIT_THREAD
>  	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
> @@ -67,6 +68,7 @@ config ARM
>  	select HAVE_KERNEL_XZ
>  	select HAVE_KPROBES if !XIP_KERNEL && !CPU_ENDIAN_BE32 && !CPU_V7M
>  	select HAVE_KRETPROBES if (HAVE_KPROBES)
> +	select HAVE_LIVEPATCH
>  	select HAVE_MEMBLOCK
>  	select HAVE_MOD_ARCH_SPECIFIC
>  	select HAVE_NMI
> @@ -82,6 +84,7 @@ config ARM
>  	select HAVE_VIRT_CPU_ACCOUNTING_GEN
>  	select IRQ_FORCED_THREADING
>  	select MODULES_USE_ELF_REL
> +	select MODULES_USE_ELF_RELA

I wrote it before but I think you cannot have both MODULES_USE_ELF_REL and 
MODULES_USE_ELF_RELA.

Miroslav
