From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 May 2010 10:21:55 +0100
Subject: [RFC PATCH v2] preliminary support for sparse IRQ
In-Reply-To: <AANLkTikSXcn9nnvaVHAsoDPmLN30E_TjNVdXu1vCOH74@mail.gmail.com>
References: <AANLkTikSXcn9nnvaVHAsoDPmLN30E_TjNVdXu1vCOH74@mail.gmail.com>
Message-ID: <001f01caf7fd$e3d45350$ab7cf9f0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> +#ifdef CONFIG_SPARSE_IRQ
> +int __init arch_probe_nr_irqs(void)
> +{
> +	nr_irqs = arch_nr_irqs ? arch_nr_irqs : NR_IRQS;
> +	return 0;
> +}
> +#endif

Possibly a daft question, but if CONFIG_SPARSE_IRQ is
not set, where does nr_irqs get assigned to?

Other than that, looks good to me.

Cheers,

Will
