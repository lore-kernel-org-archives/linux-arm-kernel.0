From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Feb 2014 09:24:30 -0500
Subject: [PATCH] clk: respect the clock dependencies in of_clk_init
In-Reply-To: <52F4DA40.4090804@elopez.com.ar>
References: <1391554766-11285-1-git-send-email-gregory.clement@free-electrons.com>
 <52F4DA40.4090804@elopez.com.ar>
Message-ID: <20140207142430.GU8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 10:06:08AM -0300, Emilio L?pez wrote:

[snip a great explanation]

Guys, can I get some Tested-by's on this?

thx,

Jason.

> -----8<------
> 
> From ffdb49506e3ce92090c15e1f9b37f4d465097ac1 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>
> Date: Thu, 6 Feb 2014 18:07:07 -0300
> Subject: [PATCH] clk: mvebu: fix name dependency during registration time
> 
> Currently, mvebu_clk_gating_setup has a silly dependency on clock
> registration order just to gather the parent clock name. This is
> completely unnecesary, as it supports using an already provided name
> via the clk_gating_soc_desc structs, and we can therefore solve this
> issue with a 69+/- line patch. But, given that the parent name is
> always "tclk" as default-hardcoded on mvebu_coreclk_setup(), we can
> just default-hardcode it here too and get away with solving this
> problem with a one-liner.
> ---
>  drivers/clk/mvebu/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
> index 25ceccf..6c63b43 100644
> --- a/drivers/clk/mvebu/common.c
> +++ b/drivers/clk/mvebu/common.c
> @@ -121,7 +121,7 @@ void __init mvebu_clk_gating_setup(struct
> device_node *np,
>  	struct clk_gating_ctrl *ctrl;
>  	struct clk *clk;
>  	void __iomem *base;
> -	const char *default_parent = NULL;
> +	const char *default_parent = "tclk";
>  	int n;
> 
>  	base = of_iomap(np, 0);
> -- 
> 1.8.5.3
