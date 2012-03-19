From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 19 Mar 2012 09:43:46 +0800
Subject: [PATCH] pxa/hx4700: Add standard UART to hx4700_pin_config[]
In-Reply-To: <1331911475.54244.YahooMailClassic@web29012.mail.ird.yahoo.com>
References: <1331911475.54244.YahooMailClassic@web29012.mail.ird.yahoo.com>
Message-ID: <CAN1soZy0OtAYNrFKRhwOKDtgJaE8fHrWAzwM3xeocvVS75PP=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 11:24 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> Add the two standard UART signals (GPIO46_STUART_RXD, GPIO47_STUART_TXD) to the
> initial mfp config table hx4700_pin_config[] passed to pxa2xx_mfp_config().
> Although pxa2xx_transceiver_mode() can subsequently set these two signals via
> its own call to pxa2xx_mfp_config(), pxa2xx_transceiver_mode() is only present
> when CONFIG_PXA_FICP=y. Hence this patch provides a default mfp config.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
>
> --- a/arch/arm/mach-pxa/hx4700.c ? ? ? ?2012-03-16 15:18:29.636709575 +0000
> +++ b/arch/arm/mach-pxa/hx4700.c ? ? ? ?2012-03-16 15:19:35.401070040 +0000
> @@ -101,6 +101,10 @@ static unsigned long hx4700_pin_config[]
> ? ? ? ?GPIO44_BTUART_CTS,
> ? ? ? ?GPIO45_BTUART_RTS_LPM_LOW,
>
> + ? ? ? /* STUART (IRDA) */
> + ? ? ? GPIO46_STUART_RXD,
> + ? ? ? GPIO47_STUART_TXD,
> +
> ? ? ? ?/* PWM 1 (Backlight) */
> ? ? ? ?GPIO17_PWM1_OUT,
>
Applied. Thanks
