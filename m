From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 3 Mar 2015 09:26:20 +0100
Subject: [PATCH] udc: gadget: atmel_usba_udc: depend on COMMON_CLK_AT91
In-Reply-To: <1425368567-5333-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425368567-5333-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150303092620.63e1861d@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Tue,  3 Mar 2015 08:42:47 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Since the addition of the errata handling for at91sam9rl and at91sam9g45, the
> atmel_usba_udc depends on the pmc driver being present. Explicitly set that
> dependency.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  drivers/usb/gadget/udc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> index 9a3a6b00391a..b04206fdba11 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -55,7 +55,7 @@ config USB_LPC32XX
>  
>  config USB_ATMEL_USBA
>  	tristate "Atmel USBA"
> -	depends on AVR32 || ARCH_AT91
> +	depends on AVR32 || ARCH_AT91 && COMMON_CLK_AT91

I guess you should add parenthesis to make it clearer ?

	depends on AVR32 || (ARCH_AT91 && COMMON_CLK_AT91)

And I wonder why you need that. I though this option was selected by all
at91 platforms ?

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
