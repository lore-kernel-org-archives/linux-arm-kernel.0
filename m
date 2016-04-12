From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 12 Apr 2016 12:18:21 +0200
Subject: [PATCH V4 3/7] irqchip, GICv3, ITS: Refator ITS DT init code to
 prepare for ACPI.
In-Reply-To: <1459759975-24097-4-git-send-email-tn@semihalf.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
 <1459759975-24097-4-git-send-email-tn@semihalf.com>
Message-ID: <570CCB6D.30706@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04.04.2016 10:52, Tomasz Nowicki wrote:
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index d5d798b..a40ed7d 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -332,7 +332,7 @@ struct rdists {
>   struct irq_domain;
>   struct device_node;

I forgot to add this to avoid compilation warning:
-struct device_node;
+struct fwnode_handle;

>   int its_cpu_init(void);
> -int its_init(struct device_node *node, struct rdists *rdists,
> +int its_init(struct fwnode_handle *handle, struct rdists *rdists,
>   	     struct irq_domain *domain);
>
>   static inline bool gic_enable_sre(void)

Thanks,
Tomasz
