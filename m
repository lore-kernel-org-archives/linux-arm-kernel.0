From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 20 Mar 2017 16:05:24 +0800
Subject: [PATCH 1/8] soc: imx: gpc: fix gpc clk get error handling
In-Reply-To: <1489990547-1510-2-git-send-email-aisheng.dong@nxp.com>
References: <1489990547-1510-1-git-send-email-aisheng.dong@nxp.com>
 <1489990547-1510-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170320080523.GG3443@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 02:15:40PM +0800, Dong Aisheng wrote:
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 1e9b3b8..c9bfdfd 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -143,7 +143,7 @@ static int imx_pgc_get_clocks(struct device *dev, struct imx_pm_domain *domain)
>  	return 0;
>  
>  clk_err:
> -	for (; i >= 0; i--)
> +	while (i--)
>  		clk_put(domain->clk[i]);

Will clk[0] be put then?

Shawn

>  
>  	return ret;
