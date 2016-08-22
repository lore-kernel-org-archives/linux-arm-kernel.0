From: kedare06@gmail.com (Kedari Appana)
Date: Mon, 22 Aug 2016 19:40:41 +0530
Subject: [PATCH -next v2] net: phy: Add missing of_node_put() in
 xgmiitorgmii_probe()
In-Reply-To: <1471819575-13389-1-git-send-email-weiyj.lk@gmail.com>
References: <1471706815-27723-1-git-send-email-weiyj.lk@gmail.com>
 <1471819575-13389-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <CANdmM3POSz9GmoFEr7jRD23m2gR7K2pK3oU6E5wyTKcUpWO8LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ,


On Mon, Aug 22, 2016 at 4:16 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> This node pointer is returned by of_parse_phandle() with
> refcount incremented in this function. of_node_put() on it
> before exitting this function.
>
> This is detected by Coccinelle semantic patch.
>
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>

Reviewed-by: Kedareswara rao Appana <appanad@xilinx.com>

Thanks,
Kedar.

> ---
> v1 -> v2: release it unconditionally as Andrew and David's suggestion
> ---
>  drivers/net/phy/xilinx_gmii2rgmii.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/phy/xilinx_gmii2rgmii.c b/drivers/net/phy/xilinx_gmii2rgmii.c
> index cad6e19..73b50f3 100644
> --- a/drivers/net/phy/xilinx_gmii2rgmii.c
> +++ b/drivers/net/phy/xilinx_gmii2rgmii.c
> @@ -73,6 +73,7 @@ int xgmiitorgmii_probe(struct mdio_device *mdiodev)
>         }
>
>         priv->phy_dev = of_phy_find_device(phy_node);
> +       of_node_put(phy_node);
>         if (!priv->phy_dev) {
>                 dev_info(dev, "Couldn't find phydev\n");
>                 return -EPROBE_DEFER;
>
