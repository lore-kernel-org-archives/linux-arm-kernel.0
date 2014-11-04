From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 4 Nov 2014 15:04:21 +0800
Subject: [PATCH v5 4/6] ARM: mediatek: Add sysirq interrupt polarity
 support
In-Reply-To: <1414576824-16143-5-git-send-email-yingjoe.chen@mediatek.com>
References: <1414576824-16143-1-git-send-email-yingjoe.chen@mediatek.com>
 <1414576824-16143-5-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1415084661.31861.5.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-10-29 at 18:00 +0800, Yingjoe Chen wrote:
> diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
> new file mode 100644
> index 0000000..4403bcf
> --- /dev/null
> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> +static int mtk_sysirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				   unsigned int nr_irqs, void *arg)
> +{
> +	int i, ret;
> +	irq_hw_number_t hwirq;
> +	struct of_phandle_args *irq_data = arg;
> +
> +	if (irq_data->args_count < 3)
> +		return -EINVAL;
> +
> +	hwirq = irq_data->args[1];
> +	for (i = 0; i < nr_irqs; i++)
> +		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> +					      &mtk_sysirq_chip,
> +					      domain->host_data);
> +
> +	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
> +}

(answering my own patch)
The ret is not used in this function. I'll remove it in next version.

Besides this, is there anything that should be changed in this series?

Joe.C
