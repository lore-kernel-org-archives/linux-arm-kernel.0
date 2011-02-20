From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 20 Feb 2011 22:37:47 +0100
Subject: [PATCH V4 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <42efee69-aca1-446b-a997-f0063e113877@VA3EHSMHS009.ehs.local>
References: <1298052881-14591-1-git-send-email-john.linn@xilinx.com>
	<1298052881-14591-3-git-send-email-john.linn@xilinx.com>
	<42efee69-aca1-446b-a997-f0063e113877@VA3EHSMHS009.ehs.local>
Message-ID: <201102202237.47327.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 18 February 2011, John Linn wrote:
> +
> +/* IO address mapping macros, nothing special at this time but required */
> +
> +#ifdef __ASSEMBLER__
> +#define IOMEM(x)               (x)
> +#else
> +#define IOMEM(x)               ((void __force __iomem *)(x))
> +#endif
> +
> +#define __io(a)                        __typesafe_io(a)
> +#define __mem_pci(a)           (a)

Are you planning to support PCI or PCMCIA? If so, the __io definition will have to
change so it points to the PIO register window.

> diff --git a/arch/arm/mach-xilinx/include/mach/timex.h b/arch/arm/mach-xilinx/include/mach/timex.h
> new file mode 100644
> index 0000000..4ebc0a6
> --- /dev/null
> +++ b/arch/arm/mach-xilinx/include/mach/timex.h
> +#ifndef __MACH_TIMEX_H__
> +#define __MACH_TIMEX_H__
> +
> +#define PERIPHERAL_CLOCK_RATE  2500000
> +
> +#define CLOCK_TICK_RATE        (PERIPHERAL_CLOCK_RATE / 32)
> +
> +#endif

I thought we were at the point where CLOCK_TICK_RATE is no longer used.
Did the patches not make it in yet?

The rest looks fine to me.

	Arnd
