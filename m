From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 17 Nov 2014 12:30:34 +0100 (CET)
Subject: [Patch V3 6/9] genirq: Introduce
 msi_domain_{alloc|free}_irqs()
In-Reply-To: <1416222202-28002-7-git-send-email-jiang.liu@linux.intel.com>
References: <1416222202-28002-1-git-send-email-jiang.liu@linux.intel.com>
 <1416222202-28002-7-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1411171230090.3909@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Nov 2014, Jiang Liu wrote:
> +
> +/*
> + * Default structure for MSI interrupt allocation.
> + * Arch may overwrite it by defining msi_alloc_info_t.
> + */
> +struct msi_alloc_info {
> +	struct msi_desc			*desc;
> +	irq_hw_number_t			hwirq;
> +	union {
> +		unsigned long		ul;
> +		void			*ptr;
> +	} scratchpad[NUM_MSI_ALLOC_SCRATCHPAD_REGS];
> +};
> +
> +#ifndef msi_alloc_info_t
> +typedef struct msi_alloc_info msi_alloc_info_t;
> +#endif

Hmm. Do we really need that?

Thanks,

	tglx
