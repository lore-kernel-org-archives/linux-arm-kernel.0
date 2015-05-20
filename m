From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 May 2015 17:28:06 +0200 (CEST)
Subject: [RFC v1 15/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
 <1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505201715380.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 May 2015, Jiang Liu wrote:
> -static void locomo_handler(unsigned int irq, struct irq_desc *desc)
> +static void locomo_handler(struct irq_desc *desc)
>  {
>  	struct locomo *lchip = irq_desc_get_chip_data(desc);
> +	unsigned int irq;
>  	int req, i;

That leaves irq unitialized ....

Thanks,

	tglx
