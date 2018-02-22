From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 22 Feb 2018 17:42:29 +0800
Subject: [PATCH v3 1/4] driver: clk: imx: Add CLK_IS_CRITICAL flag for
 busy diviver and busy mux
In-Reply-To: <1517968819-12869-1-git-send-email-ping.bai@nxp.com>
References: <1517968819-12869-1-git-send-email-ping.bai@nxp.com>
Message-ID: <20180222094228.GK3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 10:00:16AM +0800, Bai Ping wrote:
> The busy divider and busy mux is actually used by the system critical clocks,
> so add 'CLK_IS_CRITICAL' to clocks registered with these two type.

Are there any real world issues you have seen with this CLK_IS_CRITICAL
missing from these busy clocks?

> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>

s/diviver/divider in the patch subject.

Shawn

> ---
>  drivers/clk/imx/clk-busy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c
> index 6df3389..9903652 100644
> --- a/drivers/clk/imx/clk-busy.c
> +++ b/drivers/clk/imx/clk-busy.c
> @@ -101,7 +101,7 @@ struct clk *imx_clk_busy_divider(const char *name, const char *parent_name,
>  
>  	init.name = name;
>  	init.ops = &clk_busy_divider_ops;
> -	init.flags = CLK_SET_RATE_PARENT;
> +	init.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL;
>  	init.parent_names = &parent_name;
>  	init.num_parents = 1;
>  
> @@ -175,7 +175,7 @@ struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
>  
>  	init.name = name;
>  	init.ops = &clk_busy_mux_ops;
> -	init.flags = 0;
> +	init.flags = CLK_IS_CRITICAL;
>  	init.parent_names = parent_names;
>  	init.num_parents = num_parents;
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
