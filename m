From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 16 Sep 2014 10:45:26 -0700 (PDT)
Subject: [RFC Part2 v1 02/21] genirq: Introduce helper functions to
 support stacked irq_chip
In-Reply-To: <1410444228-3134-3-git-send-email-jiang.liu@linux.intel.com>
References: <1410444228-3134-1-git-send-email-jiang.liu@linux.intel.com>
 <1410444228-3134-3-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.10.1409161044330.4247@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Sep 2014, Jiang Liu wrote:
> +#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
> +void irq_chip_ack_parent(struct irq_data *data)
> +{
> +	data = data->parent_data;
> +	if (data && data->chip && data->chip->irq_ack)
> +		data->chip->irq_ack(data);

Why is this restricted to a single parent level and does not go down
the whole stack?

Thanks,

	tglx
