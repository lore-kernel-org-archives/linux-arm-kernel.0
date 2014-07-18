From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 Jul 2014 08:57:13 -0500
Subject: [PATCH 8/9] usb: phy: am335x: call
 usb_gen_phy_init()/usb_gen_phy_shutdown() in am335x_init()/am335x_shutdown()
In-Reply-To: <1405675890-8802-9-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-5-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-6-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-7-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-8-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-9-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140718135713.GH24914@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jul 18, 2014 at 11:31:29AM +0200, Lothar Wa?mann wrote:
> This patch makes it possible to use the musb driver with HW that
> requires external regulators or clocks.

can you provide an example of such HW ? Are you not using the internal
PHYs ?

> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
> ---
>  drivers/usb/phy/phy-am335x.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/phy/phy-am335x.c b/drivers/usb/phy/phy-am335x.c
> index 6522fa7..de25674 100644
> --- a/drivers/usb/phy/phy-am335x.c
> +++ b/drivers/usb/phy/phy-am335x.c
> @@ -22,6 +22,7 @@ static int am335x_init(struct usb_phy *phy)
>  {
>  	struct am335x_phy *am_phy = dev_get_drvdata(phy->dev);
>  
> +	usb_gen_phy_init(phy);
>  	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, true);
>  	return 0;
>  }
> @@ -31,6 +32,7 @@ static void am335x_shutdown(struct usb_phy *phy)
>  	struct am335x_phy *am_phy = dev_get_drvdata(phy->dev);
>  
>  	phy_ctrl_power(am_phy->phy_ctrl, am_phy->id, false);
> +	usb_gen_phy_shutdown(phy);
>  }
>  
>  static int am335x_phy_probe(struct platform_device *pdev)
> -- 
> 1.7.10.4
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140718/abf62d5c/attachment.sig>
