From: prabhakar.lad@ti.com (Prabhakar Lad)
Date: Mon, 20 Aug 2012 16:59:57 +0530
Subject: [PATCH] ARM: relax conditions required for enabling Contiguous
 Memory Allocator
In-Reply-To: <1345443372-3824-1-git-send-email-m.szyprowski@samsung.com>
References: <1345443372-3824-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <50321FB5.90507@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Thanks for the patch.

On Monday 20 August 2012 11:46 AM, Marek Szyprowski wrote:
> Contiguous Memory Allocator requires only paging and MMU enabled not
> particular CPU architectures, so there is no need for strict dependency
> on CPU type. This enables to use CMA on some older ARM v5 systems which
> also might need large contiguous blocks for the multimedia processing hw
> modules.
> 
> Reported-by: Prabhakar Lad <prabhakar.csengg@gmail.com>

  Reported-by: Prabhakar Lad <prabhakar.lad@ti.com>
  Tested-by: Prabhakar Lad <prabhakar.lad@ti.com>

Thx,
--Prabhakar

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e91c7cd..6ef75e2 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -6,7 +6,7 @@ config ARM
>  	select HAVE_DMA_API_DEBUG
>  	select HAVE_IDE if PCI || ISA || PCMCIA
>  	select HAVE_DMA_ATTRS
> -	select HAVE_DMA_CONTIGUOUS if (CPU_V6 || CPU_V6K || CPU_V7)
> +	select HAVE_DMA_CONTIGUOUS if MMU
>  	select HAVE_MEMBLOCK
>  	select RTC_LIB
>  	select SYS_SUPPORTS_APM_EMULATION
> 
