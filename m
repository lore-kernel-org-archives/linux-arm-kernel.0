From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 12 Mar 2012 10:38:38 -0600
Subject: [PATCH RESEND v3 1/2] GPIO: LPC32xx: Fix missing bit selection
 mask
In-Reply-To: <1330984871-411-1-git-send-email-stigge@antcom.de>
References: <1330984871-411-1-git-send-email-stigge@antcom.de>
Message-ID: <20120312163838.AABCC3E07B0@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  5 Mar 2012 23:01:10 +0100, Roland Stigge <stigge@antcom.de> wrote:
> Add missing mask to pin bit selection in gpio-lpc32xx.c
> (#define GPIO3_PIN_IN_SEL)
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied, thx.

g.

> 
> ---
>  drivers/gpio/gpio-lpc32xx.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-2.6.orig/drivers/gpio/gpio-lpc32xx.c
> +++ linux-2.6/drivers/gpio/gpio-lpc32xx.c
> @@ -59,7 +59,7 @@
>  #define GPO3_PIN_TO_BIT(x)			(1 << (x))
>  #define GPIO012_PIN_IN_SEL(x, y)		(((x) >> (y)) & 1)
>  #define GPIO3_PIN_IN_SHIFT(x)			((x) == 5 ? 24 : 10 + (x))
> -#define GPIO3_PIN_IN_SEL(x, y)			((x) >> GPIO3_PIN_IN_SHIFT(y))
> +#define GPIO3_PIN_IN_SEL(x, y)			(((x) >> GPIO3_PIN_IN_SHIFT(y)) & 1)
>  #define GPIO3_PIN5_IN_SEL(x)			(((x) >> 24) & 1)
>  #define GPI3_PIN_IN_SEL(x, y)			(((x) >> (y)) & 1)
>  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
