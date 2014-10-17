From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 17 Oct 2014 12:51:56 +0200
Subject: [PATCH] arm64: mm: use macro instead of if judgement of ZONE_DMA
In-Reply-To: <CAGZxSSRsYYNURnVB1fpGSTMA7WJMdy=Cmt1pj0Q=69ahHEsO1w@mail.gmail.com>
References: <CAGZxSSRsYYNURnVB1fpGSTMA7WJMdy=Cmt1pj0Q=69ahHEsO1w@mail.gmail.com>
Message-ID: <20141017105156.GF29470@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Oct 16, 2014 at 05:19:43PM +0800, Yifan Zhang wrote:
> @@ -82,10 +82,10 @@ static void __init zone_sizes_init(unsigned long
> min, unsigned long max)
> 
>         memset(zone_size, 0, sizeof(zone_size));
> 
> 
> 
>         /* 4GB maximum for 32-bit only capable devices */
> 
> -        if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> 
> -                 max_dma = PFN_DOWN(max_zone_dma_phys());
> 
> -                 zone_size[ZONE_DMA] = max_dma - min;
> 
> -        }
> 
> +#ifdef CONFIG_ZONE_DMA
> 
> +       max_dma = PFN_DOWN(max_zone_dma_phys());
> 
> +       zone_size[ZONE_DMA] = max_dma - min;
> 
> +#endif
Apart from your patch being broken (probably by your MUA or MTA) usually
if (IS_ENABLED(...)) is preferred over #ifdef because it doesn't stand
out over the other program source.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
