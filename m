From: sergey.senozhatsky.work@gmail.com (Sergey Senozhatsky)
Date: Thu, 25 Oct 2018 14:29:01 +0900
Subject: [PATCH 1/2] mm/zsmalloc.c: check encoded object value overflow
 for PAE
In-Reply-To: <20181025012745.20884-1-rafael.tinoco@linaro.org>
References: <20181025012745.20884-1-rafael.tinoco@linaro.org>
Message-ID: <20181025052901.GA17799@jagdpanzerIV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On (10/24/18 22:27), Rafael David Tinoco wrote:
>  static unsigned long location_to_obj(struct page *page, unsigned int obj_idx)
>  {
> -	unsigned long obj;
> +	unsigned long obj, pfn;
> +
> +	pfn = page_to_pfn(page);
> +
> +	if (unlikely(OBJ_OVERFLOW(pfn)))
> +		BUG();

The trend these days is to have less BUG/BUG_ON-s in the kernel.

	-ss
