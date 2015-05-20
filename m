From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 May 2015 17:40:11 +0200 (CEST)
Subject: [RFC v1 25/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <1432116013-25902-26-git-send-email-jiang.liu@linux.intel.com>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
 <1432116013-25902-26-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505201737510.4225@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 May 2015, Jiang Liu wrote:
>  /* Chained IRQ handler for IPU error interrupt */
> -static void ipu_irq_err(unsigned int irq, struct irq_desc *desc)
> +static void ipu_irq_err(struct irq_desc *desc)
>  {
> +	unsigned int irq = irq_desc_to_irq(desc);

Why initializing? It's overwritten in the loop.

>  /* Chained IRQ handler for IPU function interrupt */
> -static void ipu_irq_fn(unsigned int irq, struct irq_desc *desc)
> +static void ipu_irq_fn(struct irq_desc *desc)
>  {
> +	unsigned int irq = irq_desc_to_irq(desc);

Ditto.

Thanks,

	tglx
