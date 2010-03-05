From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Mar 2010 12:08:02 -0000
Subject: [PATCH] ARM: Add Versatile Express CA9x4 processor support
In-Reply-To: <git-1267729916-8545dcd13a3ae6450278b076cb024d10d64ee785@rmk-PC>
References: <git-1267729916-61c9b6ab773870de77ff9183b8bb055a03b19671@rmk-PC>
	<git-1267729916-8545dcd13a3ae6450278b076cb024d10d64ee785@rmk-PC>
Message-ID: <002101cabc5c$81fa5440$85eefcc0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

> +/*
> + * Interrupts.  Those in {} are for AMBA devices
> + */
> +#define IRQ_CT_CA9X4_CLCDC	{ 76 }
> +#define IRQ_CT_CA9X4_DMC	{ -1 }
> +#define IRQ_CT_CA9X4_SMC	{ 77, 78 }
> +#define IRQ_CT_CA9X4_TIMER0	80
> +#define IRQ_CT_CA9X4_TIMER1	81
> +#define IRQ_CT_CA9X4_GPIO	{ 82 }

Could you add the PMU interrupts as well please? It saves me
adding them in an extra patch later. I believe they are numbers
92-95.

The only problem with adding the PMU interrupts here is that
they are not visible to kernel/pmu.c, which includes <linux/interrupt.h>.
Adding a conditional #include <mach/ct-ca9x4.h> worked, but it's not
very nice. Would it be possible to include the tile IRQs in the
include/mach/irqs.h?

Thanks,

Will
