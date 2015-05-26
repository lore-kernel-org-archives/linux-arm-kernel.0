From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 May 2015 09:44:27 -0500
Subject: [PATCH 16/21] usb: phy: Probe phy devices on demand
In-Reply-To: <1432565608-26036-17-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-17-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150526144427.GA26599@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 04:53:20PM +0200, Tomeu Vizoso wrote:
> When looking up a phy through its DT node, ensure that the corresponding
> device has been registered.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/usb/phy/phy.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/phy/phy.c b/drivers/usb/phy/phy.c
> index d1cd6b5..7084f21 100644
> --- a/drivers/usb/phy/phy.c
> +++ b/drivers/usb/phy/phy.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/of_platform.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
>  
> @@ -192,6 +193,8 @@ struct usb_phy *devm_usb_get_phy_by_phandle(struct device *dev,
>  		goto err0;
>  	}
>  
> +	of_platform_device_ensure(node);
> +
>  	spin_lock_irqsave(&phy_lock, flags);
>  
>  	phy = __of_usb_find_phy(node);
> -- 
> 2.4.1
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150526/6060e029/attachment.sig>
