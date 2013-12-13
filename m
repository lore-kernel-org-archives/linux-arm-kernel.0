From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 22:27:22 -0600
Subject: [PATCH v6 07/15] usb: phy: add notify suspend and resume callback
In-Reply-To: <1386897825-6130-8-git-send-email-peter.chen@freescale.com>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-8-git-send-email-peter.chen@freescale.com>
Message-ID: <20131213042722.GG867@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 09:23:37AM +0800, Peter Chen wrote:
> They are used to notify PHY that the controller enters suspend
> or finishes resume.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  include/linux/usb/phy.h |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
> index 6c0b1c5..a747960 100644
> --- a/include/linux/usb/phy.h
> +++ b/include/linux/usb/phy.h
> @@ -116,6 +116,11 @@ struct usb_phy {
>  			enum usb_device_speed speed);
>  	int	(*notify_disconnect)(struct usb_phy *x,
>  			enum usb_device_speed speed);
> +	int	(*notify_suspend)(struct usb_phy *x,
> +			enum usb_device_speed speed);
> +	int	(*notify_resume)(struct usb_phy *x,
> +			enum usb_device_speed speed);
> +

I still don't think this is necessary. Why don't you just call
usb_phy_set_suspend() directly ? And why do you need the extra speed
argument ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/f7b3cd3a/attachment.sig>
