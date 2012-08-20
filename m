From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Tue, 21 Aug 2012 02:01:05 +0300
Subject: [PATCH 2/3] ARM: DMA-Mapping: print warning when atomic
 coherent allocation fails
In-Reply-To: <1345459648-24263-3-git-send-email-m.szyprowski@samsung.com>
References: <1345459648-24263-1-git-send-email-m.szyprowski@samsung.com>
 <1345459648-24263-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20120820230058.GA755@harshnoise.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 20, 2012 at 12:47:27PM +0200, Marek Szyprowski wrote:
> @@ -461,6 +461,9 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
>  		bitmap_set(pool->bitmap, pageno, count);
>  		ptr = pool->vaddr + PAGE_SIZE * pageno;
>  		*ret_page = pool->page + pageno;
> +	} else {
> +		pr_err("Atomic coherent pool too small!\n"
> +		       "Please increase it with coherent_pool= kernel parameter!\n");

This should be rate limited, perhaps even printed only once.

A.
