From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 11:49:50 +0100
Subject: [PATCH 04/12] irqchip: nvic: support routable irq domain ops
In-Reply-To: <1417565531-4507-5-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
 <1417565531-4507-5-git-send-email-stefan@agner.ch>
Message-ID: <4576226.8jDcZiCptE@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 01:12:03 Stefan Agner wrote:
> +#ifdef CONFIG_ARM_NVIC
> +extern const struct irq_domain_ops *nvic_routable_irq_domain_ops;
> +static inline void __init register_routable_domain_ops
> +                                       (const struct irq_domain_ops *ops)
> +{
> +               nvic_routable_irq_domain_ops = ops;
> +}
> +#endif /* CONFIG_ARM_NVIC */
> 

As you mentioned, this conflicts with the gic specific declaration.
Why not remove the #ifdef here and rename the function to
nvic_register_routable_domain_ops() ?

If that doesn't work, I guess we need something more generic
and move the routable_irq_domain_ops to some common location.

	Arnd
