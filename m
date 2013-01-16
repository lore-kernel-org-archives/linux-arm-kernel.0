From: tj@kernel.org (Tejun Heo)
Date: Wed, 16 Jan 2013 15:18:57 -0800
Subject: [PATCH v2 1/1] block: blk-merge: don't merge the pages with
 non-contiguous descriptors
In-Reply-To: <1358332355.2384.11.camel@dabdike.int.hansenpartnership.com>
References: <1358265681-25671-1-git-send-email-subhashj@codeaurora.org>
 <1358266794.10591.8.camel@dabdike.int.hansenpartnership.com>
 <50F64AC1.3040304@codeaurora.org>
 <1358332355.2384.11.camel@dabdike.int.hansenpartnership.com>
Message-ID: <20130116231857.GU2668@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 10:32:35AM +0000, James Bottomley wrote:
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 6b2fb87..ab88c5b 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -809,7 +809,7 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
>  			op(vaddr, len, dir);
>  		}
>  		offset = 0;
> -		page++;
> +		page = pfn_to_page(page_to_pfn(page) + 1);

Probably page = nth_page(page, 1) is the better form.

Thanks.

-- 
tejun
