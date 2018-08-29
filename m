From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 29 Aug 2018 11:38:09 +0200
Subject: [PATCH 4/5] net: mvneta: enable NETIF_F_RXCSUM by default
In-Reply-To: <20180829162932.6015e89d@xhacker.debian> (Jisheng Zhang's message
 of "Wed, 29 Aug 2018 16:29:32 +0800")
References: <20180829162456.2bd69796@xhacker.debian>
 <20180829162932.6015e89d@xhacker.debian>
Message-ID: <871sahjywu.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,
 
 On mer., ao?t 29 2018, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> The code and HW supports NETIF_F_RXCSUM, so let's enable it by
> default.

Same as the previous one, it should go to net-next and

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 06634d4f9b94..7d98f7828a30 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -4591,7 +4591,8 @@ static int mvneta_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_TSO;
> +	dev->features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM |
> +			NETIF_F_TSO | NETIF_F_RXCSUM;
>  	dev->hw_features |= dev->features;
>  	dev->vlan_features |= dev->features;
>  	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> -- 
> 2.18.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
