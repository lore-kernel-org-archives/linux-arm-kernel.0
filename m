From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 16 Jan 2010 13:18:33 +0530
Subject: [PATCH 1/4] omap: Clean the serial port defines
In-Reply-To: <20100116013510.10065.59461.stgit@baageli.muru.com>
References: <20100116013205.10065.95921.stgit@baageli.muru.com>
	<20100116013510.10065.59461.stgit@baageli.muru.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C06F9005@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the nice cleanup.
<snip>

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Saturday, January 16, 2010 7:05 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org
> Subject: [PATCH 1/4] omap: Clean the serial port defines
> 
> This way we don't have conflicts with the defines
> with compiling in multiple omaps. Set the addresses
> for uarts in struct omap_globals for the early serial
> init code.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap1/include/mach/debug-macro.S |   16 +++++----
>  arch/arm/mach-omap1/serial.c                   |    6 ++-
>  arch/arm/mach-omap2/include/mach/debug-macro.S |   15 ++++----
>  arch/arm/mach-omap2/serial.c                   |   15 ++++++--
>  arch/arm/plat-omap/common.c                    |   18 ++++++++++
>  arch/arm/plat-omap/include/plat/common.h       |    5 +++
>  arch/arm/plat-omap/include/plat/serial.h       |   44 
> +++++++++++++-----------
>  7 files changed, 77 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/include/mach/debug-macro.S 
> b/arch/arm/mach-omap1/include/mach/debug-macro.S
> index aedb746..23e4724 100644
> --- a/arch/arm/mach-omap1/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap1/include/mach/debug-macro.S
> @@ -11,6 +11,10 @@
...

> diff --git a/arch/arm/mach-omap2/serial.c 
> b/arch/arm/mach-omap2/serial.c
> index 837b347..21e51c5 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -74,7 +74,6 @@ static LIST_HEAD(uart_list);

...


> diff --git a/arch/arm/plat-omap/include/plat/common.h 
> b/arch/arm/plat-omap/include/plat/common.h
> index 32c2227..a8fa0d7 100644
> --- a/arch/arm/plat-omap/include/plat/common.h
> +++ b/arch/arm/plat-omap/include/plat/common.h
> @@ -47,6 +47,10 @@ struct omap_globals {
>  	void __iomem	*prm;		/* Power and Reset Management */
>  	void __iomem	*cm;		/* Clock Management */
>  	void __iomem	*cm2;
> +	unsigned long	uart1_phys;
> +	unsigned long	uart2_phys;
> +	unsigned long	uart3_phys;
> +	unsigned long	uart4_phys;
Considering they are register base address, can
these be declared as "void __iomem" instead of "unsigned long"

Regards
Santosh
