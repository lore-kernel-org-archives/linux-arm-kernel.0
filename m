From: dv@vollmann.ch (Detlef Vollmann)
Date: Mon, 18 Apr 2011 15:50:20 +0200
Subject: [RFC PATCH v2] Consolidate SRAM support
In-Reply-To: <20110418085259.GA26044@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110418085259.GA26044@n2100.arm.linux.org.uk>
Message-ID: <4DAC419C.6000801@vollmann.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/11 10:52, Russell King - ARM Linux wrote:
> This is the second revision of this patch.
Thanks, looks good :-)

Just to minor issues:

> diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
> index ea5ee4d..ddbd20b 100644
> --- a/arch/arm/common/Kconfig
> +++ b/arch/arm/common/Kconfig
> @@ -39,3 +39,7 @@ config SHARP_PARAM
>
>   config SHARP_SCOOP
>   	bool
> +
> +config PV_POOL
> +	bool
Could you add a prompt here, so that this gets selectable on machs
that don't automatically select it?

> diff --git a/arch/arm/mach-davinci/sram.c b/arch/arm/mach-davinci/sram.c
> index db0f778..ebd4d67 100644
> --- a/arch/arm/mach-davinci/sram.c
> +++ b/arch/arm/mach-davinci/sram.c
> @@ -10,40 +10,13 @@
> +struct pv_pool *davinci_pv_pool;
> +EXPORT_SYMBOL_GPL(davinci_pv_pool);
>
>   /*
>    * REVISIT This supports CPU and DMA access to/from SRAM, but it
This comment here doesn't look correct anymore.
Maybe it should be removed completely.

   Detlef
