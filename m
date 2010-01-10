From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 11 Jan 2010 09:23:31 +1100
Subject: [PATCH] Consolidate clks_register() and similar
In-Reply-To: <20100110172825.GB8639@n2100.arm.linux.org.uk>
References: <20100110172825.GB8639@n2100.arm.linux.org.uk>
Message-ID: <201001110923.31809.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

> --- a/arch/arm/mach-bcmring/core.c
> +++ b/arch/arm/mach-bcmring/core.c
> @@ -142,8 +142,7 @@ void __init bcmring_amba_init(void)
> 
>  	chipcHw_busInterfaceClockEnable(bus_clock);
> 
> -	for (i = 0; i < ARRAY_SIZE(lookups); i++)
> -		clkdev_add(&lookups[i]);
> +	clkdev_add_table(lookups, ARRAY_SIEZ(lookups));

SIEZ -> SIZE.

Also, perhaps a macro to simplify this common usage?

#define clkdev_add_table(clks) __clkdev_add_table(clks, ARRAY_SIZE(clks))

Cheers,


Jeremy
