From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Sep 2011 16:56:43 +0200
Subject: [RFC PATCH v2 3/3] ARM: SoC: convert VExpress/RealView to SoC
	descriptor
In-Reply-To: <1315579616-27388-4-git-send-email-marc.zyngier@arm.com>
References: <1315579616-27388-1-git-send-email-marc.zyngier@arm.com>
	<1315579616-27388-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <201109091656.44068.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 September 2011, Marc Zyngier wrote:
> Convert both Realview and VExpress to use the SoC descriptor to
> provide their SMP and CPU hotplug operation.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Yes, looks good to me.

>  }
> +
> +struct arm_soc_desc realview_soc_desc __initdata = {
> +       .name           = "ARM RealView Platform",
> +#ifdef CONFIG_SMP
> +       .smp_ops        = &realview_soc_smp_ops,
> +#endif
> +};

Do you think we should have a macro for this? Since this is
always the same, we could do something like

#ifdef CONFIG_SMP
#define soc_smp_ops(ops)	.smp_ops = &(ops),
#else
#define soc_smp_ops(ops)	/* empty */
#endif

	Arnd
