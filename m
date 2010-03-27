From: hjk@linutronix.de (Hans J. Koch)
Date: Sat, 27 Mar 2010 19:42:13 +0100
Subject: [PATCH 5/7 v3] Basic IO mappings for mach-tcc8k
In-Reply-To: <20100327180643.GM2035@bluebox.local>
References: <20100327175658.GH2035@bluebox.local>
	<20100327180643.GM2035@bluebox.local>
Message-ID: <20100327184212.GA2559@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 27, 2010 at 07:06:43PM +0100, Hans J. Koch wrote:
> Map the IO ranges of TCC8xxx peripherals.
> 
> Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
> ---
> +
> +#if 0
> +/*
> + * ----------------------------------------------------------------------------
> + * I/O mapping
> + * ----------------------------------------------------------------------------
> + */
> +
> +#define PCIO_BASE	0
> +
> +/* Address Map of Internal Peripherials (Base 0x80000000) */
> +#define IO_PHYS_A			0x80000000
> +#define IO_OFFSET_A			0x70000000 /* Virtual IO = 0xF0000000 */
> +#define IO_SIZE_A			0x100000
> +#define IO_VIRT_A			(IO_PHYS + IO_OFFSET)
> +#define IO_ADDRESS_A(pa)	((pa) + IO_OFFSET)
> +#define IO_P2V_A(pa)		((pa) + IO_OFFSET)
> +#define IO_V2P_A(va)		((va) - IO_OFFSET)
> +
> +/* Address Map of Internal Peripherials (Base 0x90000000) */
> +#define IO_PHYS_B			0x90000000
> +#define IO_OFFSET_B			0x61000000 /* Virtual IO = 0xF1000000 */
> +#define IO_SIZE_B			0x100000
> +#define IO_VIRT_B			(IO_PHYS + IO_OFFSET)
> +#define IO_ADDRESS_B(pa)	((pa) + IO_OFFSET)
> +#define IO_P2V_B(pa)		((pa) + IO_OFFSET)
> +#define IO_V2P_B(va)		((va) - IO_OFFSET)
> +#endif
> +
> +#endif

Dammit. I #if 0'ed these for a compile test and forgot to remove these lines
later. Will fix in the next version.

Thanks,
Hans
