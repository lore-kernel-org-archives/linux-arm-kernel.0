From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 17 Oct 2009 16:31:19 +0200
Subject: [PATCH v3 1/7] [ARM]: U8500 register definitions
In-Reply-To: <1255300029.21542.405.camel@vinay-desktop>
References: <1255300015.21542.404.camel@vinay-desktop>
	<1255300029.21542.405.camel@vinay-desktop>
Message-ID: <20091017143119.GA14673@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +
> +/* this macro is used in assembly, so no cast */
> +#define IO_ADDRESS(x)	((x) - U8500_IO_PHYSICAL + U8500_IO_VIRTUAL)
> +
> +/* typesafe io address */
> +#define __io_address(n)         __io(IO_ADDRESS(n))
please check your pathes as there is some whitesape in it
> +
> +/*
> + * Base address definitions for U8500 Onchip IPs. All the
> + * peripherals are contained in a single 1 Mbyte region, with
> + * AHB peripherals at the bottom and APB peripherals at the
> + * top of the region. PER stands for PERIPHERAL region which
> + * itself divided into sub regions.
> + */
> +#define U8500_PER3_BASE		0x80000000
> +#define U8500_PER2_BASE		0x80110000
> +#define U8500_PER1_BASE		0x80120000
> +#define U8500_PER4_BASE		0x80150000
> +
> +#define U8500_PER6_BASE		0xa03c0000
> +#define U8500_PER5_BASE		0xa03e0000
> +#define U8500_PER7_BASE		0xa03d0000
It will be nice to keep this named ordered
> +
> +#define U8500_SVA_BASE		0xa0100000
> +#define U8500_SIA_BASE		0xa0200000
> +
> +#define U8500_SGA_BASE		0xa0300000
> +#define U8500_MCDE_BASE		0xa0350000
> +#define U8500_DMA_BASE		0xa0362000
> +
> +#define U8500_SCU_BASE		0xa0410000
> +#define U8500_GIC_CPU_BASE	0xa0410100
> +#define U8500_TWD_BASE		0xa0410600
> +#define U8500_GIC_DIST_BASE	0xa0411000
> +#define U8500_L2CC_BASE		0xa0412000
> +
> +#define U8500_TWD_SIZE		0x100
it will be better to regroup base address by funtionnality intead of PERx_BASE
and keep them ordered
> +
> +/* per7 base addressess */
> +#define U8500_CR_BASE		(U8500_PER7_BASE + 0x8000)
> +#define U8500_MTU0_BASE		(U8500_PER7_BASE + 0xa000)
> +#define U8500_MTU1_BASE		(U8500_PER7_BASE + 0xb000)
> +#define U8500_TZPC0_BASE	(U8500_PER7_BASE + 0xc000)
> +#define U8500_CLKRST7_BASE	(U8500_PER7_BASE + 0xf000)
> +
<snip>
> diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
> new file mode 100644
> index 0000000..69d6dde
> --- /dev/null
> +++ b/arch/arm/mach-ux500/include/mach/irqs.h
> @@ -0,0 +1,71 @@
> +/*
> + *  Copyright (C) 2008 STMicroelectronics
> + *  Copyright (C) 2009 ST-Ericsson.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#ifndef ASM_ARCH_IRQS_H
> +#define ASM_ARCH_IRQS_H
> +
> +#include <mach/hardware.h>
> +
> +#define IRQ_LOCALTIMER                  29
> +#define IRQ_LOCALWDOG                   30
> +
> +/* Shared Peripheral Interrupt */
> +#define IRQ_SPI_START			32
SPI is a few confusing maybe you can replace it by IRQ_SHPI_START or something
else

Best Regards,
J.
