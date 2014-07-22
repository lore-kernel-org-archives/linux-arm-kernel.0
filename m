From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Jul 2014 09:43:31 +0800
Subject: [PATCH 5/6] usb: phy: mxs: Add VF610 USB PHY support
In-Reply-To: <af194168fadd80c26f94da740f1e61ce6603225a.1405702442.git.stefan@agner.ch>
References: <cover.1405702442.git.stefan@agner.ch>
 <af194168fadd80c26f94da740f1e61ce6603225a.1405702442.git.stefan@agner.ch>
Message-ID: <20140722014330.GA10650@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 07:01:41PM +0200, Stefan Agner wrote:
> This adds support for the USB PHY in Vybrid VF610. We assume that
> the disconnection without VBUS is also needed for Vybrid. For all
> other flags, the presumption of innocence applies.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/usb/phy/phy-mxs-usb.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index c42bdf0..207946b 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -125,10 +125,15 @@ static const struct mxs_phy_data imx6sl_phy_data = {
>  		MXS_PHY_NEED_IP_FIX,
>  };
>  
> +static const struct mxs_phy_data vf610_phy_data = {
> +	.flags = MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS,
> +};
> +
>  static const struct of_device_id mxs_phy_dt_ids[] = {
>  	{ .compatible = "fsl,imx6sl-usbphy", .data = &imx6sl_phy_data, },
>  	{ .compatible = "fsl,imx6q-usbphy", .data = &imx6q_phy_data, },
>  	{ .compatible = "fsl,imx23-usbphy", .data = &imx23_phy_data, },
> +	{ .compatible = "fsl,vf610-usbphy", .data = &vf610_phy_data, },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, mxs_phy_dt_ids);
> -- 
> 2.0.1
> 
Acked-by: Peter Chen <peter.chen@freescale.com>

-- 

Best Regards,
Peter Chen
