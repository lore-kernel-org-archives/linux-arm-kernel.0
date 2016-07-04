From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 04 Jul 2016 11:50:54 -0400
Subject: [PATCH net-next] lpc_eth: remove unused variable
In-Reply-To: <20160704132018.1130907-1-arnd@arndb.de>
References: <20160704132018.1130907-1-arnd@arndb.de>
Message-ID: <1467647454.28674.1.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-07-04 at 15:19 +0200, Arnd Bergmann wrote:
> A cleanup patch removed the only user of a local variable, as
> indicated by a gcc warning.
> 
> drivers/net/ethernet/nxp/lpc_eth.c: In function 'lpc_eth_ioctl':
> drivers/net/ethernet/nxp/lpc_eth.c:1183:24: error: unused variable 'pldat' [-Werror=unused-variable]
> 
> This removes the variable as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: f786f3564c4f ("net: ethernet: lpc_eth: use phydev from struct net_device")
> ---
>  drivers/net/ethernet/nxp/lpc_eth.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/nxp/lpc_eth.c b/drivers/net/ethernet/nxp/lpc_eth.c
> index ad5464fa8ac7..660d113f8b9a 100644
> --- a/drivers/net/ethernet/nxp/lpc_eth.c
> +++ b/drivers/net/ethernet/nxp/lpc_eth.c
> @@ -1180,7 +1180,6 @@ static void lpc_eth_set_multicast_list(struct net_device *ndev)
>  
>  static int lpc_eth_ioctl(struct net_device *ndev, struct ifreq *req, int cmd)
>  {
> -	struct netdata_local *pldat = netdev_priv(ndev);
>  	struct phy_device *phydev = ndev->phydev;
>  
>  	if (!netif_running(ndev))

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
