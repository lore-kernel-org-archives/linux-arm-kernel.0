From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 20 Dec 2013 10:40:01 -0000
Subject: [PATCH v7 07/14] usb: phy-mxs: change description of usb device
 speed
In-Reply-To: <1387525930-27313-8-git-send-email-peter.chen@freescale.com>
References: <1387525930-27313-1-git-send-email-peter.chen@freescale.com>
 <1387525930-27313-8-git-send-email-peter.chen@freescale.com>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B74C0@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Peter Chen
> Sent: 20 December 2013 07:52
> Change "high speed" to "HS"
> Change "non-high speed" to "FS/LS"
> 
> Implementation of notify_suspend and notify_resume will be different
> according to mxs_phy_data->flags.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  drivers/usb/phy/phy-mxs-usb.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> index 0ef930a..489096f 100644
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

Seems you are making these messages even more cryptic.
With all the speeds that USB supports remembering what 'full'
means is hard enough without having a cryptic acronym.

	David
