From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 09 Dec 2013 09:31:28 +0100
Subject: [PATCH v5 08/15] usb: phy-mxs: Add implementation of
 nofity_suspend and notify_resume
In-Reply-To: <1386570664-6713-9-git-send-email-peter.chen@freescale.com>
References: <1386570664-6713-1-git-send-email-peter.chen@freescale.com>
 <1386570664-6713-9-git-send-email-peter.chen@freescale.com>
Message-ID: <52A57FE0.5030009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 07:30 AM, Peter Chen wrote:
> Implementation of notify_suspend and notify_resume will be different
> according to mxs_phy_data->flags.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |   55 ++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index 0ef930a..e3df53f 100644
> --- a/drivers/usb/phy/phy-mxs-usb.c
> +++ b/drivers/usb/phy/phy-mxs-usb.c
> @@ -166,8 +166,8 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
>  static int mxs_phy_on_connect(struct usb_phy *phy,
>  		enum usb_device_speed speed)
>  {
> -	dev_dbg(phy->dev, "%s speed device has connected\n",
> -		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
> +	dev_dbg(phy->dev, "%s device has connected\n",
> +		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");

What about creating a mxs_phy_dbg() function that adds the "HS" "FS/LS"
prefix when printing?

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/13500789/attachment.sig>
