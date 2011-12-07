From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 07 Dec 2011 15:57:07 +0900
Subject: [PATCH] ARM: SAMSUNG: Use kmemdup rather than duplicating its
 implementation
In-Reply-To: <1321569820.1624.268.camel@localhost.localdomain>
References: <1321569820.1624.268.camel@localhost.localdomain>
Message-ID: <03e001ccb4ad$6f76a490$4e63edb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Meyer wrote:
> 
> The semantic patch that makes this change is available
> in scripts/coccinelle/api/memdup.cocci.
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> 
> diff -u -p a/arch/arm/plat-s3c24xx/dma.c b/arch/arm/plat-s3c24xx/dma.c
> --- a/arch/arm/plat-s3c24xx/dma.c 2011-11-07 19:37:20.736205210 +0100
> +++ b/arch/arm/plat-s3c24xx/dma.c 2011-11-08 11:03:41.719762852 +0100
> @@ -1437,11 +1437,10 @@ int __init s3c24xx_dma_init_map(struct s
>  	size_t map_sz = sizeof(*nmap) * sel->map_size;
>  	int ptr;
> 
> -	nmap = kmalloc(map_sz, GFP_KERNEL);
> +	nmap = kmemdup(sel->map, map_sz, GFP_KERNEL);
>  	if (nmap == NULL)
>  		return -ENOMEM;
> 
> -	memcpy(nmap, sel->map, map_sz);
>  	memcpy(&dma_sel, sel, sizeof(*sel));
> 
>  	dma_sel.map = nmap;

Yes, looks ok to me, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
