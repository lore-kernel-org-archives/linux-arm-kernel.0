From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 Feb 2012 12:35:03 +0000
Subject: [PATCH 7/7] Minor compiling fix
In-Reply-To: <1329126268-11032-8-git-send-email-bill4carson@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-8-git-send-email-bill4carson@gmail.com>
Message-ID: <201202291235.04113.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 February 2012, Bill Carson wrote:
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -152,9 +152,6 @@ static struct arm_vmregion_head consistent_head = {
>         .vm_end         = CONSISTENT_END,
>  };
>  
> -#ifdef CONFIG_HUGETLB_PAGE
> -#error ARM Coherent DMA allocator does not (yet) support huge TLB
> -#endif

This one needs an explanation, too. What has changed that now allows
dma_alloc_coherent to work with CONFIG_HUGETLB_PAGE set that did not
work before?

In general, please add a description with each patch you send, following
the instructions in Documentation/SubmittingPatches.

	Arnd
