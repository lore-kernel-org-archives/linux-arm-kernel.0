From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 7 May 2015 17:30:52 +0200 (CEST)
Subject: [PATCH] net: ll_temac: Use one return statement instead of two
In-Reply-To: <b10b8e1e696a09152b9df535a8bd37e6500ac1c7.1431005352.git.michal.simek@xilinx.com>
References: <b10b8e1e696a09152b9df535a8bd37e6500ac1c7.1431005352.git.michal.simek@xilinx.com>
Message-ID: <alpine.DEB.2.10.1505071730090.2462@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 May 2015, Michal Simek wrote:

> From: Michal Simek <monstr@monstr.eu>
>
> Use one return statement instead of two to simplify the code.
> Both are returning the same value.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

The from should be the same as the signed off.  You need From if you want
something different than what is naturally put by your mailer.  But that
doesn't see to be the case.

julia

> ---
>
>  drivers/net/ethernet/xilinx/ll_temac_main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
> index 690a4c36b316..ca640d04fd93 100644
> --- a/drivers/net/ethernet/xilinx/ll_temac_main.c
> +++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
> @@ -688,10 +688,8 @@ static int temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	cur_p = &lp->tx_bd_v[lp->tx_bd_tail];
>
>  	if (temac_check_tx_bd_space(lp, num_frag)) {
> -		if (!netif_queue_stopped(ndev)) {
> +		if (!netif_queue_stopped(ndev))
>  			netif_stop_queue(ndev);
> -			return NETDEV_TX_BUSY;
> -		}
>  		return NETDEV_TX_BUSY;
>  	}
>
> --
> 2.3.5
>
>
