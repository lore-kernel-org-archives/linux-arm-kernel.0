From: hjk@linutronix.de (Hans J. Koch)
Date: Mon, 22 Mar 2010 23:28:38 +0100
Subject: [PATCH 05/07] Basic IO mappings for mach-tcc8k
In-Reply-To: <20100322192748.GK2040@bluebox.local>
References: <20100322191900.GF2040@bluebox.local>
	<20100322192748.GK2040@bluebox.local>
Message-ID: <20100322222837.GB2547@local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 22, 2010 at 08:27:49PM +0100, Hans J. Koch wrote:
> Map the IO ranges of TCC8xxx peripherals.
> 
> Signed-off-by: "Hans J. Koch" <hjk@linutronix.de>
> ---
>  arch/arm/mach-tcc8k/Makefile        |    2 +-
>  arch/arm/mach-tcc8k/io.c            |   82 +++++++++++++++++++++++++++++++++++
>  arch/arm/plat-tcc/include/mach/io.h |   53 ++++++++++++++++++++++
>  3 files changed, 136 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-tcc8k/io.c
>  create mode 100644 arch/arm/plat-tcc/include/mach/io.h
> 
> diff --git a/arch/arm/mach-tcc8k/Makefile b/arch/arm/mach-tcc8k/Makefile
> index 5673868..09552e2 100644
> --- a/arch/arm/mach-tcc8k/Makefile
> +++ b/arch/arm/mach-tcc8k/Makefile
> @@ -3,5 +3,5 @@
>  #
>  
>  # Common support
> -obj-y += clock.o irq.o time.o
> +obj-y += clock.o irq.o time.o io.o
>  
> diff --git a/arch/arm/mach-tcc8k/io.c b/arch/arm/mach-tcc8k/io.c
> new file mode 100644
> index 0000000..1187fca
> --- /dev/null
> +++ b/arch/arm/mach-tcc8k/io.c
[...]
> +
> +/*
> + * Maps common IO regions for tcc8k.
> + *
> + */
> +void __init tcc8k_map_common_io(void)
> +{
> +	iotable_init(tcc8k_io_desc, ARRAY_SIZE(tcc8k_io_desc));
> +	local_flush_tlb_all();
> +	flush_cache_all();

Reviewing my own patch...
These last to "flush" lines are probably crap, at least unneeded.
I thought I threw them out, but somehow they crept in again.
Will test and fix.

Hans

> +}
