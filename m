From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 23 Aug 2016 17:16:19 +0200
Subject: [PATCH -next] net: phy: xgmiitorgmii: Fix non static symbol
 warning
In-Reply-To: <1471964765-32708-1-git-send-email-weiyj.lk@gmail.com>
References: <1471964765-32708-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <20160823151619.GK20029@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 03:06:05PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>

Hi Wei

No need for the additional From:

git am will use the one in the mail header as the author of the patch,
and it is in the signed-off-by as well.

Thanks
    Andrew

> Fixes the following sparse warning:
> 
> drivers/net/phy/xilinx_gmii2rgmii.c:61:5: warning:
>  symbol 'xgmiitorgmii_probe' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/net/phy/xilinx_gmii2rgmii.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index e7a20ec..2e408b8 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -58,7 +58,7 @@ static int xgmiitorgmii_read_status(struct phy_device *phydev)
>  	return 0;
>  }
>  
> -int xgmiitorgmii_probe(struct mdio_device *mdiodev)
> +static int xgmiitorgmii_probe(struct mdio_device *mdiodev)
>  {
>  	struct device *dev = &mdiodev->dev;
>  	struct device_node *np = dev->of_node, *phy_node;
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
