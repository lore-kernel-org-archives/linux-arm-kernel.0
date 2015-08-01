From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Sat, 1 Aug 2015 15:54:27 +0530
Subject: [PATCH 1/3] phy-sun4i-usb: Add missing EXPORT_SYMBOL for
 sun4i_usb_phy_set_squelch_detect
In-Reply-To: <1438329702-10365-2-git-send-email-hdegoede@redhat.com>
References: <1438329702-10365-1-git-send-email-hdegoede@redhat.com>
 <1438329702-10365-2-git-send-email-hdegoede@redhat.com>
Message-ID: <55BC9E5B.7010201@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 31 July 2015 01:31 PM, Hans de Goede wrote:
> sun4i_usb_phy_set_squelch_detect is used by other code, which may be built
> as a module, so it should be exported.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v6:
> -New patch in v6 of the sunxi musb support series
> ---
>  drivers/phy/phy-sun4i-usb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> index 5138843..d514a9b 100644
> --- a/drivers/phy/phy-sun4i-usb.c
> +++ b/drivers/phy/phy-sun4i-usb.c
> @@ -347,6 +347,7 @@ void sun4i_usb_phy_set_squelch_detect(struct phy *_phy, bool enabled)
>  
>  	sun4i_usb_phy_write(phy, PHY_SQUELCH_DETECT, enabled ? 0 : 2, 2);
>  }
> +EXPORT_SYMBOL(sun4i_usb_phy_set_squelch_detect);

changed it to EXPORT_SYMBOL_GPL and merged it.

Thanks
Kishon
