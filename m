From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 1 Feb 2016 21:55:07 +0800
Subject: [PATCH 10/15] bus: imx-weim: use of_platform_default_populate()
 to populate default bus
In-Reply-To: <1453868872-26300-11-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-1-git-send-email-wangkefeng.wang@huawei.com>
 <1453868872-26300-11-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <20160201135507.GJ10671@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 12:27:47PM +0800, Kefeng Wang wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
> 
> Cc: Signed-off-by: Huang Shijie <b32955@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  drivers/bus/imx-weim.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> index e98d15e..557a71c 100644
> --- a/drivers/bus/imx-weim.c
> +++ b/drivers/bus/imx-weim.c
> @@ -163,9 +163,8 @@ static int __init weim_parse_dt(struct platform_device *pdev,
>  	}
>  
>  	if (have_child)
> -		ret = of_platform_populate(pdev->dev.of_node,
> -				   of_default_bus_match_table,
> -				   NULL, &pdev->dev);
> +		ret = of_platform_default_populate(pdev->dev.of_node,
> +						   NULL, &pdev->dev);
>  	if (ret)
>  		dev_err(&pdev->dev, "%s fail to create devices.\n",
>  			pdev->dev.of_node->full_name);
> -- 
> 2.6.0.GIT
> 
> 
