From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 21 Apr 2010 14:51:19 +0800
Subject: [PATCH] USB: gadget: pxa2xx: allow -1 for invalid gpio
In-Reply-To: <89D837B3-BCDC-48A4-BBF9-B292AE55D7AB@workware.net.au>
References: <89D837B3-BCDC-48A4-BBF9-B292AE55D7AB@workware.net.au>
Message-ID: <n2mf17812d71004202351w6a2edf79h53ff830733710687@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 2:30 PM, Steve Bennett <steveb@workware.net.au> wrote:
> gpio must be int, not u16, otherwise -1 isn't recognised
> by gpio_is_valid().
>
> Signed-off-by: Steve Bennett <steveb@workware.net.au>

Ack.

And better submit a patch as well for pxa2xx_udc.c to allow -1 as no GPIO.

> ---
> ?arch/arm/include/asm/mach/udc_pxa2xx.h | ? ?4 ++--
> ?1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/mach/udc_pxa2xx.h b/arch/arm/include/asm/mach/udc_pxa2xx.h
> index f3eabf1..833306e 100644
> --- a/arch/arm/include/asm/mach/udc_pxa2xx.h
> +++ b/arch/arm/include/asm/mach/udc_pxa2xx.h
> @@ -21,8 +21,8 @@ struct pxa2xx_udc_mach_info {
> ? ? ? ? * here. ?Note that sometimes the signals go through inverters...
> ? ? ? ? */
> ? ? ? ?bool ? ?gpio_vbus_inverted;
> - ? ? ? u16 ? ? gpio_vbus; ? ? ? ? ? ? ? ? ? ? ?/* high == vbus present */
> + ? ? ? int ? ? gpio_vbus; ? ? ? ? ? ? ? ? ? ? ?/* high == vbus present */
> ? ? ? ?bool ? ?gpio_pullup_inverted;
> - ? ? ? u16 ? ? gpio_pullup; ? ? ? ? ? ? ? ? ? ?/* high == pullup activated */
> + ? ? ? int ? ? gpio_pullup; ? ? ? ? ? ? ? ? ? ?/* high == pullup activated */
> ?};
>
>
>
> --
> ?Web: Embedded Web Framework - http://uweb.workware.net.au/
> WorkWare Systems Pty Ltd
> W: www.workware.net.au ? ? ?P: 0434 921 300
> E: steveb at workware.net.au ? F: 07 3102 9221
>
>
>
>
>
