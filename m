From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Sep 2012 19:24:38 +0000
Subject: [PATCH v3 08/31] arm64: CPU support
In-Reply-To: <1347035226-18649-9-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-9-git-send-email-catalin.marinas@arm.com>
Message-ID: <201209071924.38430.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 September 2012, Catalin Marinas wrote:
> +
> +#include <asm/cputable.h>
> +
> +extern unsigned long __cpu_setup(void);
> +
> +struct cpu_info __initdata cpu_table[] = {
> +	{
> +		.cpu_id_val	= 0x000f0000,
> +		.cpu_id_mask	= 0x000f0000,
> +		.cpu_name	= "AArch64 Processor",
> +		.cpu_setup	= __cpu_setup,
> +	},
> +	{ /* Empty */ },
> +};

> +#define MAIR(attr, mt)	((attr) << ((mt) * 8))
> +
> +ENTRY(cpu_proc_init)
> +	ret
> +ENDPROC(cpu_proc_init)
> +
> +ENTRY(cpu_proc_fin)
> +	ret
> +ENDPROC(cpu_proc_fin)


These seem to be leftovers from multi-cpu support that can be removed.

	Arnd
