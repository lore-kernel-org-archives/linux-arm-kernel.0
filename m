From: davem@davemloft.net (David Miller)
Date: Mon, 05 May 2014 15:40:04 -0400 (EDT)
Subject: [PATCH 1/7] net: mv643xx_eth: Simplify mv643xx_eth_adjust_link()
In-Reply-To: <1399141622-30654-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1399141622-30654-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1399141622-30654-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140505.154004.1134814253503467382.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date: Sat,  3 May 2014 15:26:56 -0300

> Currently, mv643xx_eth_adjust_link() is only used to call mv643xx_adjust_pscr().
> This commit renames the latter to the former, and therefore removes the extra
> and useless function.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  drivers/net/ethernet/marvell/mv643xx_eth.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index b7b8d74..1e63c63 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -1010,8 +1010,10 @@ static void txq_set_fixed_prio_mode(struct tx_queue *txq)
>  
>  
>  /* mii management interface *************************************************/
> -static void mv643xx_adjust_pscr(struct mv643xx_eth_private *mp)
> +static void mv643xx_eth_adjust_link(struct net_device *dev)
>  {
> +	struct mv643xx_eth_private *mp = netdev_priv(dev);
> +
>  	u32 pscr = rdlp(mp, PORT_SERIAL_CONTROL);
>  	u32 autoneg_disable = FORCE_LINK_PASS |
>  	             DISABLE_AUTO_NEG_SPEED_GMII |

Please do not add empty lines in the middle of the function local variable declarations.
