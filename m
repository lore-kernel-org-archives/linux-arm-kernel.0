From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 23 Nov 2013 19:44:26 -0800
Subject: [PATCH] CMA: Fix the phys_addr_t print types
In-Reply-To: <1385264221-29952-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385264221-29952-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131124034426.GB3873@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 23, 2013 at 10:37:01PM -0500, Santosh Shilimkar wrote:
> @@ -250,8 +249,8 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>  	*res_cma = cma;
>  	cma_area_count++;
>  
> -	pr_info("CMA: reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
> -		(unsigned long)base);
> +	pr_info("CMA: reserved %ld MiB at %pa\n", (unsigned long)size / SZ_1M,
> +		&base);

Why is this pr_info() at all?  That's just noise, please move it to
pr_debug().

thanks,

greg k-h
