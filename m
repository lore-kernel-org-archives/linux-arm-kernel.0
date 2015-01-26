From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 26 Jan 2015 12:08:19 +0100
Subject: [PATCH 3/4] ARM: Alpine: smp support
In-Reply-To: <54c53660.F+mWFCmG+/oPpFS5%tsahee@annapurnalabs.com>
References: <54c53660.F+mWFCmG+/oPpFS5%tsahee@annapurnalabs.com>
Message-ID: <6259906.i1F47ar7ng@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 25 January 2015 20:30:56 Tsahee Zidenberg wrote:

> This patch introduces support for waking up secondary CPU cores on
> Alpine platform.

The actual code looks good, I just have minor comments about the
formatting:

> +
> +	np = of_find_compatible_node(
> +		NULL, NULL, "annapurna-labs,al-cpu-resume");

When wrapping lines, please continue the next line at the point of the
opening braces, like:


	np = of_find_compatible_node(NULL, NULL,
	                             "annapurna-labs,al-cpu-resume");

> +	al_cpu_resume_regs =
> +			(struct al_cpu_resume_regs __iomem *)of_iomap(np, 0);

Or remove a type case when it is not required.

> +int __cpuinit alpine_boot_secondary(unsigned int cpu
> +				, struct task_struct *idle)

As above.

	Arnd
