From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 4 Jun 2013 17:30:13 +0100
Subject: [PATCH v2] ARM: mm: lazy cache flushing on non-mapped pages
In-Reply-To: <1370270680-729-1-git-send-email-ming.lei@canonical.com>
References: <1370270680-729-1-git-send-email-ming.lei@canonical.com>
Message-ID: <20130604163012.GC25090@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 03:44:39PM +0100, Ming Lei wrote:
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index 0d473cc..2ff66eb 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -287,7 +287,7 @@ void flush_dcache_page(struct page *page)
>  	mapping = page_mapping(page);
>  
>  	if (!cache_ops_need_broadcast() &&
> -	    mapping && !mapping_mapped(mapping))
> +	    mapping && !page_mapped(page))
>  		clear_bit(PG_dcache_clean, &page->flags);
>  	else {
>  		__flush_dcache_page(mapping, page);

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
