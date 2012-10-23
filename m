From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 23 Oct 2012 18:04:53 +0530
Subject: [PATCH] usb: remove CONFIG_USB_MUSB_HOST etc
In-Reply-To: <1349702227-24875-1-git-send-email-const@MakeLinux.com>
References: <1349702227-24875-1-git-send-email-const@MakeLinux.com>
Message-ID: <50868EED.7050909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/8/2012 6:47 PM, Constantine Shulyupin wrote:
> From: Constantine Shulyupin <const@MakeLinux.com>
> 
> Remove USB configuration in arch/arm/mach-davinci/usb.c accordingly 
> CONFIG_USB_MUSB_OTG CONFIG_USB_MUSB_PERIPHERAL CONFIG_USB_MUSB_HOST 
> and set MUSB_OTG configuration by default
> because this configuration options are removed from Kconfig.
> 
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>

Queuing this patch for v3.8. Since the config options are removed there
is no use having code which refers to them. The patch has been tested on
DM644x and DM365 in both host and gadget mode (I will add this
information to commit text while committing). Without this patch .mode
seems to be defaulting to MUSB_UNDEFINED which I think is definitely wrong.

Thanks,
Sekhar

>  
> ---
>  arch/arm/mach-davinci/usb.c |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/arm/mach-davinci/usb.c b/arch/arm/mach-davinci/usb.c
> index f77b953..34509ff 100644
> --- a/arch/arm/mach-davinci/usb.c
> +++ b/arch/arm/mach-davinci/usb.c
> @@ -42,14 +42,8 @@ static struct musb_hdrc_config musb_config = {
>  };
>  
>  static struct musb_hdrc_platform_data usb_data = {
> -#if defined(CONFIG_USB_MUSB_OTG)
>  	/* OTG requires a Mini-AB connector */
>  	.mode           = MUSB_OTG,
> -#elif defined(CONFIG_USB_MUSB_PERIPHERAL)
> -	.mode           = MUSB_PERIPHERAL,
> -#elif defined(CONFIG_USB_MUSB_HOST)
> -	.mode           = MUSB_HOST,
> -#endif
>  	.clock		= "usb",
>  	.config		= &musb_config,
>  };
> 
