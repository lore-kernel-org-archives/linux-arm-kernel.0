From: balbi@ti.com (Felipe Balbi)
Date: Tue, 5 Feb 2013 11:23:12 +0200
Subject: [PATCH 06/30] usb: phy: nop: use new PHY API to register PHY
In-Reply-To: <1359372631-8180-7-git-send-email-rogerq@ti.com>
References: <1359372631-8180-1-git-send-email-rogerq@ti.com>
 <1359372631-8180-7-git-send-email-rogerq@ti.com>
Message-ID: <20130205092312.GO32118@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 01:30:07PM +0200, Roger Quadros wrote:
> We would need to support multiple PHYs of the same type
> so use the new PHY API usb_add_phy_dev() to register the PHY.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/usb/otg/nop-usb-xceiv.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/usb/otg/nop-usb-xceiv.c b/drivers/usb/otg/nop-usb-xceiv.c
> index 3060ed0..ac027a1 100644
> --- a/drivers/usb/otg/nop-usb-xceiv.c
> +++ b/drivers/usb/otg/nop-usb-xceiv.c
> @@ -197,12 +197,13 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
>  	nop->phy.init		= nop_init;
>  	nop->phy.shutdown	= nop_shutdown;
>  	nop->phy.state		= OTG_STATE_UNDEFINED;
> +	nop->phy.type		= type;
>  
>  	nop->phy.otg->phy		= &nop->phy;
>  	nop->phy.otg->set_host		= nop_set_host;
>  	nop->phy.otg->set_peripheral	= nop_set_peripheral;
>  
> -	err = usb_add_phy(&nop->phy, type);
> +	err = usb_add_phy_dev(&nop->phy);
>  	if (err) {
>  		dev_err(&pdev->dev, "can't register transceiver, err: %d\n",
>  			err);
> -- 
> 1.7.4.1
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130205/0e570eba/attachment-0001.sig>
