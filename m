From: joe@perches.com (Joe Perches)
Date: Mon, 27 Aug 2018 23:55:05 -0700
Subject: [PATCH] ARM: omap: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Message-ID: <b2d9328b9cd48e768ac8062de60a95195b8ffb58.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-08-27 at 20:52 -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
[]
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
[]
> @@ -738,7 +738,7 @@ static int __init _setup_clkctrl_provider(struct device_node *np)
>  	provider->size = size | 0xff;
>  	provider->node = np;
>  
> -	pr_debug("%s: %s: %x...%x [+%x]\n", __func__, np->parent->name,
> +	pr_debug("%pOF: %s: %x...%x [+%x]\n", __func__, np->parent,

Wrong argument order

I didn't look at the rest.
