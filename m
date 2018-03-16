From: aisheng.dong@nxp.com (A.s. Dong)
Date: Fri, 16 Mar 2018 06:26:41 +0000
Subject: [PATCH v5 1/4] clk: imx: Add CLK_IS_CRITICAL flag for busy
 divider and busy mux
In-Reply-To: <1520846957-22348-1-git-send-email-ping.bai@nxp.com>
References: <1520846957-22348-1-git-send-email-ping.bai@nxp.com>
Message-ID: <AM3PR04MB3060671D694BAE450C5FC4A80D70@AM3PR04MB306.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Jacky Bai
> Sent: Monday, March 12, 2018 5:29 PM
> To: sboyd at kernel.org; robh+dt at kernel.org; shawnguo at kernel.org;
> kernel at pengutronix.de
> Cc: Fabio Estevam <fabio.estevam@nxp.com>; linux-clk at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> A.s. Dong <aisheng.dong@nxp.com>; jacky.baip at gmail.com
> Subject: [PATCH v5 1/4] clk: imx: Add CLK_IS_CRITICAL flag for busy divider
> and busy mux
> 
> The busy divider and busy mux is actually used by the system critical clocks,
> so add 'CLK_IS_CRITICAL' to clocks registered with these two type.
> 

We probably could fine tune clk_init_on for other platforms later.
So:
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> ---
>  change from V3->v4:
>  - fix a typo in commit log
>  change from v4->v5:
>  - optimize the commit subject
> ---
>  drivers/clk/imx/clk-busy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-busy.c b/drivers/clk/imx/clk-busy.c index
> 6df3389..9903652 100644
> --- a/drivers/clk/imx/clk-busy.c
> +++ b/drivers/clk/imx/clk-busy.c
> @@ -101,7 +101,7 @@ struct clk *imx_clk_busy_divider(const char *name,
> const char *parent_name,
> 
>  	init.name = name;
>  	init.ops = &clk_busy_divider_ops;
> -	init.flags = CLK_SET_RATE_PARENT;
> +	init.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL;
>  	init.parent_names = &parent_name;
>  	init.num_parents = 1;
> 
> @@ -175,7 +175,7 @@ struct clk *imx_clk_busy_mux(const char *name, void
> __iomem *reg, u8 shift,
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
