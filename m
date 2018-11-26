From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Nov 2018 00:21:34 -0800
Subject: [PATCH 5/5] arch: simplify several early memory allocations
In-Reply-To: <1543182277-8819-6-git-send-email-rppt@linux.ibm.com>
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
 <1543182277-8819-6-git-send-email-rppt@linux.ibm.com>
Message-ID: <20181126082134.GA10530@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
>  {
> -	void *ptr = __va(memblock_phys_alloc(sz, align));
> -	memset(ptr, 0, sz);
> -	return ptr;
> +	return memblock_alloc(sz, align);
>  }

What is the point of keeping this wrapper?

>  static void __init *early_alloc(unsigned long sz)
>  {
> -	void *ptr = __va(memblock_phys_alloc(sz, sz));
> -	memset(ptr, 0, sz);
> -	return ptr;
> +	return memblock_alloc(sz, sz);
>  }

Same here.
