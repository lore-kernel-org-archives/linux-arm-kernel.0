From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Thu, 11 Oct 2012 05:42:25 +0000
Subject: [PATCH] usb: remove CONFIG_USB_MUSB_HOST etc
In-Reply-To: <1349702227-24875-1-git-send-email-const@MakeLinux.com>
References: <1349702227-24875-1-git-send-email-const@MakeLinux.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3E9CA495@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Mon, Oct 08, 2012 at 18:47:07, Constantine Shulyupin wrote:
> From: Constantine Shulyupin <const@MakeLinux.com>
> 
> Remove USB configuration in arch/arm/mach-davinci/usb.c accordingly 
> CONFIG_USB_MUSB_OTG CONFIG_USB_MUSB_PERIPHERAL CONFIG_USB_MUSB_HOST 
> and set MUSB_OTG configuration by default
> because this configuration options are removed from Kconfig.
> 
> Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
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

Tested it on DM6446-EVM for host mode with MSC thumb drive and gadget 
mode with g-ether. It works.

Acked-by: Manjunathappa, Prakash <prakash.pm@ti.com>

Thanks,
Prakash

> -- 
> 1.7.9.5
> 
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
> 
