From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Aug 2011 08:37:48 +0100
Subject: [PATCH 4/6] ARM: highbank: add SMP support
In-Reply-To: <1313526898-19920-5-git-send-email-robherring2@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-5-git-send-email-robherring2@gmail.com>
Message-ID: <20110817073748.GA1006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 03:34:56PM -0500, Rob Herring wrote:
> +int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	gic_raise_softirq(cpumask_of(cpu), 1);

Can this raise IPI0 instead of IPI1 ?

> +void __init smp_init_cpus(void)
> +{
> +	void __iomem *scu_base = a9_base_addr;
> +	unsigned int i, ncores;
> +
> +	ncores = scu_base ? scu_get_core_count(scu_base) : 1;

Is scu_base ever NULL?
