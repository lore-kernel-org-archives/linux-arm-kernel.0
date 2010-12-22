From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 22 Dec 2010 14:06:26 -0800
Subject: [PATCH v1] davinci: Add additional JTAG code for AM-1808 and
	OMAP-L138 Rev 2.0 SoCs
In-Reply-To: <1293047363-21353-1-git-send-email-michael.williamson@criticallink.com>
	(Michael Williamson's message of "Wed, 22 Dec 2010 14:49:23 -0500")
References: <1293047363-21353-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <87aajxpin1.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Williamson <michael.williamson@criticallink.com> writes:

> The JTAG variant code for Rev-2.0 silicon of the OMAP-L138 has changed.
> In addition, the variant code for the AM-1808 SoC appears to match
> the Rev-2.0 code for the OMAP-L138.  Add an additional entry to support
> these chips.

Tested on?  

I'm assuming on the Mity platforms, right?

Kevin

> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
> ---
> This is against davinci-linux tree.
> Changes since v0, removed whitespace fixups not related to patch.
>
>  arch/arm/mach-davinci/da850.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
> index 78b5ae2..2d0bba5 100644
> --- a/arch/arm/mach-davinci/da850.c
> +++ b/arch/arm/mach-davinci/da850.c
> @@ -764,6 +764,13 @@ static struct davinci_id da850_ids[] = {
>  		.cpu_id		= DAVINCI_CPU_ID_DA850,
>  		.name		= "da850/omap-l138",
>  	},
> +	{
> +		.variant	= 0x1,
> +		.part_no	= 0xb7d1,
> +		.manufacturer	= 0x017,	/* 0x02f >> 1 */
> +		.cpu_id		= DAVINCI_CPU_ID_DA850,
> +		.name		= "da850/omap-l138/am18xx",
> +	},
>  };
>  
>  static struct davinci_timer_instance da850_timer_instance[4] = {
