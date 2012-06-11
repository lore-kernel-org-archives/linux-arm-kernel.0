From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Jun 2012 11:47:53 +0800
Subject: [PATCH v7 02/12] ARM: SoC: Add per SoC SMP and CPU hotplug
 operations
In-Reply-To: <1339085369-26073-3-git-send-email-marc.zyngier@arm.com>
References: <1339085369-26073-1-git-send-email-marc.zyngier@arm.com>
 <1339085369-26073-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120611034750.GA2344@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2012 at 05:09:19PM +0100, Marc Zyngier wrote:
> +#ifdef CONFIG_SMP
> +#define soc_smp_init_ops(ops)		.smp_init_ops = &(ops),
> +#define soc_smp_ops(ops)		.smp_ops = &(ops),
> +#ifdef CONFIG_HOTPLUG_SMP

s/CONFIG_HOTPLUG_SMP/CONFIG_HOTPLUG_CPU

> +#define soc_hotplug_ops(prefix)		.hotplug_ops = {	\
> +		.cpu_kill	= prefix##_cpu_kill,		\
> +		.cpu_die	= prefix##_cpu_die,		\
> +		.cpu_disable	= prefix##_cpu_disable,		\
> +	},
> +#else
> +#define soc_hotplug_ops(prefix)		.hotplug_ops = {},
> +#endif
> +extern void soc_smp_ops_register(struct arm_soc_smp_init_ops *,
> +				 struct arm_soc_smp_ops *);
> +#else
> +#define soc_smp_init_ops(ops)		/* empty */
> +#define soc_smp_ops(ops)		/* empty */
> +#define soc_smp_ops_register(a,b)	do {} while(0)
> +#endif

-- 
Regards,
Shawn
