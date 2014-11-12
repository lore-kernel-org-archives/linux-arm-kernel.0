From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 12 Nov 2014 14:34:45 +0100
Subject: [PATCH] net: pxa168_eth: move SET_NETDEV_DEV a bit earlier
In-Reply-To: <1415790527-6494-1-git-send-email-jszhang@marvell.com>
References: <1415790527-6494-1-git-send-email-jszhang@marvell.com>
Message-ID: <20141112133445.GC18559@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On Wed, Nov 12, 2014 at 07:08:47PM +0800, Jisheng Zhang wrote:
> This is to ensure the net_device's dev.parent is set before we used it
> in dma_zalloc_coherent() from init_hash_table().

Applies on top of net-next.

> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

FWIW,

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

> ---
>  drivers/net/ethernet/marvell/pxa168_eth.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/pxa168_eth.c b/drivers/net/ethernet/marvell/pxa168_eth.c
> index 21ddece..38f7cee 100644
> --- a/drivers/net/ethernet/marvell/pxa168_eth.c
> +++ b/drivers/net/ethernet/marvell/pxa168_eth.c
> @@ -1540,8 +1540,8 @@ static int pxa168_eth_probe(struct platform_device *pdev)
>  	if (err)
>  		goto err_free_mdio;
>  
> -	pxa168_init_hw(pep);
>  	SET_NETDEV_DEV(dev, &pdev->dev);
> +	pxa168_init_hw(pep);
>  	err = register_netdev(dev);
>  	if (err)
>  		goto err_mdiobus;
> -- 
> 2.1.3
> 

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
