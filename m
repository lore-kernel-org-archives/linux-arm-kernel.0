From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Mar 2011 08:30:52 -0700
Subject: [PATCH 01/10] omap: Use separate init_irq functions to
	avoidcpu_is_omap tests early
In-Reply-To: <c2a9cfa46d997009ffc2c00d608ed7f5@mail.gmail.com>
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
	<20110328222128.4046.70846.stgit@baageli.muru.com>
	<c2a9cfa46d997009ffc2c00d608ed7f5@mail.gmail.com>
Message-ID: <20110329153052.GA4016@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110328 23:09]:
> 
> Above mapping is incorrect. The address space is of just
> 512 bytes. Infact you don't need to ioremap it again.
> Below should be enough.
> 
> diff --git a/arch/arm/mach-omap2/omap4-common.c
> b/arch/arm/mach-omap2/omap4-common.c
> index 9ef8c29..9bddc9e 100644
> --- a/arch/arm/mach-omap2/omap4-common.c
> +++ b/arch/arm/mach-omap2/omap4-common.c
> @@ -41,6 +41,8 @@ void __init gic_init_irq(void)
>  	gic_cpu_base = ioremap(OMAP44XX_GIC_CPU_BASE, SZ_512);
>  	BUG_ON(!gic_cpu_base);
> 
> +	omap_irq_base = gic_cpu_base;
> +
>  	gic_init(0, 29, gic_dist_base_addr, gic_cpu_base);
>  }

Thanks for cathing this.

Tony
