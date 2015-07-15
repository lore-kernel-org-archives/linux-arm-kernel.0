From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 15 Jul 2015 17:17:27 +0530
Subject: [PATCH v6 1/4] phy-sun4i-usb: Add missing EXPORT_SYMBOL for
 sun4i_usb_phy_set_squelch_detect
In-Reply-To: <1436366500-12555-2-git-send-email-hdegoede@redhat.com>
References: <1436366500-12555-1-git-send-email-hdegoede@redhat.com>
 <1436366500-12555-2-git-send-email-hdegoede@redhat.com>
Message-ID: <55A6484F.9040302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 08 July 2015 08:11 PM, Hans de Goede wrote:
> sun4i_usb_phy_set_squelch_detect is used by other code, which may be built
> as a module, so it should be exported.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

merged this patch to linux-phy tree.

Cheers
Kishon
> ---
> Changes in v6:
> -New patch in v6 of the sunxi musb support series
> ---
>  drivers/phy/phy-sun4i-usb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> index e17c539..b82aa26 100644
> --- a/drivers/phy/phy-sun4i-usb.c
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -212,6 +212,7 @@ void sun4i_usb_phy_set_squelch_detect(struct phy *_phy, bool enabled)
>  
>  	sun4i_usb_phy_write(phy, PHY_SQUELCH_DETECT, enabled ? 0 : 2, 2);
>  }
> +EXPORT_SYMBOL(sun4i_usb_phy_set_squelch_detect);
>  
>  static struct phy_ops sun4i_usb_phy_ops = {
>  	.init		= sun4i_usb_phy_init,
> 
