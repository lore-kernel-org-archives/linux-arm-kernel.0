From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Dec 2014 11:51:09 +0100
Subject: [PATCH 06/12] ARM: imx: add support for MSCM interrupt router
In-Reply-To: <1417565531-4507-7-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
 <1417565531-4507-7-git-send-email-stefan@agner.ch>
Message-ID: <2336832.xq32rHipj9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 01:12:05 Stefan Agner wrote:
> +
> +static int vf610_mscm_domain_xlate(struct irq_domain *d,
> +				struct device_node *controller,
> +				const u32 *intspec, unsigned int intsize,
> +				unsigned long *out_hwirq,
> +				unsigned int *out_type)
> +{
> +#ifdef CONFIG_ARM_GIC
> +	*out_hwirq += 16;
> +#endif
> +	return 0;
> +}

I don't see how the hwirq should in any way depend on whether the
kernel also supports an ARM_GIC. This number should only be meaningful
inside of your irqchip driver.

	Arnd
