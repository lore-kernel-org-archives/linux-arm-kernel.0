From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 19 Sep 2011 11:26:08 +0200
Subject: [RFC PATCH] ARM: mxc: Select ARCH_HAS_HOLES_MEMORYMODEL
In-Reply-To: <1316132981-1104-1-git-send-email-festevam@gmail.com>
References: <1316132981-1104-1-git-send-email-festevam@gmail.com>
Message-ID: <20110919092608.GJ31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2011 at 09:29:41PM -0300, Fabio Estevam wrote:
> Select ARCH_HAS_HOLES_MEMORYMODELfor ARCH_MXC so that the non-contiguous memory block
> can be handled correctly.
> 
> An example of such system is MX35PDK that has a total of 256MB dividedin 
> two RAM banks:128MB at CS0 and another 128MB at CS1. On MX35 each chip select 
> can address up to 256MB, so this configuration leaves a 128MB 'hole' in the 
> memory map that needs to be handled properly.

Why exactly do we need this? I remember a custom i.MX25 board which also
has a memory hole, but I can't remember adding ARCH_HAS_HOLES_MEMORYMODEL
for it.

Sascha

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5ebc5d9..29bbd1d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -397,6 +397,7 @@ config ARCH_MXC
>  	select CLKSRC_MMIO
>  	select GENERIC_IRQ_CHIP
>  	select HAVE_SCHED_CLOCK
> +	select ARCH_HAS_HOLES_MEMORYMODEL
>  	help
>  	  Support for Freescale MXC/iMX-based family of processors
>  
> -- 
> 1.6.0.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
