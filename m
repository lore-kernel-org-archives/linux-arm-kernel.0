From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 20 May 2015 20:35:47 +0100
Subject: [RFC v1 01/25] ARM, irq: Use irq_desc_get_xxx() to avoid
 redundant lookup of irq_desc
In-Reply-To: <1432116013-25902-2-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
 <1432116013-25902-2-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <20150520193547.GU2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 05:59:49PM +0800, Jiang Liu wrote:
> diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
> index 5cc779c8e9c6..0d0844fa54c2 100644
> --- a/arch/arm/common/sa1111.c
> +++ b/arch/arm/common/sa1111.c
> @@ -200,7 +200,7 @@ static void
>  sa1111_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	unsigned int stat0, stat1, i;
> -	struct sa1111 *sachip = irq_get_handler_data(irq);
> +	struct sa1111 *sachip = irq_desc_get_handler_data(desc);
>  	void __iomem *mapbase = sachip->base + SA1111_INTC;
>  
>  	stat0 = sa1111_readl(mapbase + SA1111_INTSTATCLR0);

For this one only,

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Other maintainers are responsible for the others...

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
