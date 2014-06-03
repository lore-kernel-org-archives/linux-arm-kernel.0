From: mina86@mina86.com (Michal Nazarewicz)
Date: Tue, 03 Jun 2014 09:00:48 +0200
Subject: [RFC PATCH 2/3] DMA,
 CMA: use general CMA reserved area management framework
In-Reply-To: <1401757919-30018-3-git-send-email-iamjoonsoo.kim@lge.com>
References: <1401757919-30018-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1401757919-30018-3-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <xa1twqcyjx3z.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03 2014, Joonsoo Kim wrote:
> Now, we have general CMA reserved area management framework,
> so use it for future maintainabilty. There is no functional change.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> diff --git a/include/linux/dma-contiguous.h b/include/linux/dma-contiguous.h
> index dfb1dc9..ecb85ac 100644
> --- a/include/linux/dma-contiguous.h
> +++ b/include/linux/dma-contiguous.h
> @@ -53,9 +53,10 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <linux/device.h>
> +

Why is this suddenly required?

>  struct cma;
>  struct page;
> -struct device;
>  
>  #ifdef CONFIG_DMA_CMA

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
