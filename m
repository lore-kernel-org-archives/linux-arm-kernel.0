From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 9 Oct 2015 16:24:20 +0200 (CEST)
Subject: [PATCH 01/16] irqdomain: Use an accessor for the of_node field
In-Reply-To: <1444152989-31726-2-git-send-email-marc.zyngier@arm.com>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
 <1444152989-31726-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.11.1510091623090.6097@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Oct 2015, Marc Zyngier wrote:
> index d3ca792..f644fdb 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -161,6 +161,11 @@ enum {
>  	IRQ_DOMAIN_FLAG_NONCORE		= (1 << 16),
>  };
>  
> +static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
> +{
> +	return d->of_node;
> +}
> +

Can you please make that a seperate patch, which I can expedite to
Linus? That way we can fix stuff which shows up in next as well.

Thanks,

	tglx
