From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 4 Nov 2009 22:47:09 +0800
Subject: [PATCH] [ARM] pxa/pxa3xx.c: register U2D clock
In-Reply-To: <1257336880-16011-1-git-send-email-grinberg@compulab.co.il>
References: <1257336880-16011-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <f17812d70911040647l35739ed3hf749112d43b79354@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 4, 2009 at 8:14 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

ISTR U2D is present on pxa310 _only_, if that's the case, might
better put the clock into pxa300.c. Please help double check.

> ---
> ?arch/arm/mach-pxa/pxa3xx.c | ? ?2 ++
> ?1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
> index 09b7b1a..ca536f2 100644
> --- a/arch/arm/mach-pxa/pxa3xx.c
> +++ b/arch/arm/mach-pxa/pxa3xx.c
> @@ -237,6 +237,7 @@ static DEFINE_PXA3_CKEN(pxa3xx_stuart, STUART, 14857000, 1);
> ?static DEFINE_PXA3_CKEN(pxa3xx_i2c, I2C, 32842000, 0);
> ?static DEFINE_PXA3_CKEN(pxa3xx_udc, UDC, 48000000, 5);
> ?static DEFINE_PXA3_CKEN(pxa3xx_usbh, USBH, 48000000, 0);
> +static DEFINE_PXA3_CKEN(pxa3xx_u2d, USB2, 48000000, 0);
> ?static DEFINE_PXA3_CKEN(pxa3xx_keypad, KEYPAD, 32768, 0);
> ?static DEFINE_PXA3_CKEN(pxa3xx_ssp1, SSP1, 13000000, 0);
> ?static DEFINE_PXA3_CKEN(pxa3xx_ssp2, SSP2, 13000000, 0);
> @@ -261,6 +262,7 @@ static struct clk_lookup pxa3xx_clkregs[] = {
> ? ? ? ?INIT_CLKREG(&clk_pxa3xx_i2c, "pxa2xx-i2c.0", NULL),
> ? ? ? ?INIT_CLKREG(&clk_pxa3xx_udc, "pxa27x-udc", NULL),
> ? ? ? ?INIT_CLKREG(&clk_pxa3xx_usbh, "pxa27x-ohci", NULL),
> + ? ? ? INIT_CLKREG(&clk_pxa3xx_u2d, NULL, "U2DCLK"),
> ? ? ? ?INIT_CLKREG(&clk_pxa3xx_keypad, "pxa27x-keypad", NULL),
> ? ? ? ?INIT_CLKREG(&clk_pxa3xx_ssp1, "pxa27x-ssp.0", NULL),
> ? ? ? ?INIT_CLKREG(&clk_pxa3xx_ssp2, "pxa27x-ssp.1", NULL),
> --
> 1.6.0.6
>
>
