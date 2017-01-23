From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 23 Jan 2017 11:10:18 -0800
Subject: [PATCH 2/3] pinctrl: meson: meson-gxl: add the pwm_ao_b pin
In-Reply-To: <20170122210528.892-3-martin.blumenstingl@googlemail.com> (Martin
 Blumenstingl's message of "Sun, 22 Jan 2017 22:05:27 +0100")
References: <20170122210528.892-1-martin.blumenstingl@googlemail.com>
 <20170122210528.892-3-martin.blumenstingl@googlemail.com>
Message-ID: <m2sho91tk5.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This adds support for the pwm_ao_b pin. Unfortunately the registers for
> the pwm_ao pins are not documented at all. The source for the pwm_ao_b
> pin from this patch is the Khadas VIM GPL kernel source, which sets bit
> 3 and unsets bits 4 and 31 to enable the PWM LEDs.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/pinctrl/meson/pinctrl-meson-gxl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> index 25694f7094c7..6ff321a7366d 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> @@ -222,6 +222,8 @@ static const unsigned int uart_rts_ao_b_pins[]	= { PIN(GPIOAO_3, 0) };
>  
>  static const unsigned int remote_input_ao_pins[] = {PIN(GPIOAO_7, 0) };
>  
> +static const unsigned int pwm_ao_b_pins[]	= { PIN(GPIOAO_9, 0) };
> +

Hmm, the S905 public data sheet[1] shows this as GPIOAO_13.

>  static struct meson_pmx_group meson_gxl_periphs_groups[] = {
>  	GPIO_GROUP(GPIOZ_0, EE_OFF),
>  	GPIO_GROUP(GPIOZ_1, EE_OFF),
> @@ -418,6 +420,7 @@ static struct meson_pmx_group meson_gxl_aobus_groups[] = {
>  	GROUP(uart_cts_ao_b,	0,	8),
>  	GROUP(uart_rts_ao_b,	0,	7),
>  	GROUP(remote_input_ao,	0,	0),
> +	GROUP(pwm_ao_b,		0,	3),
>  };

but it does show as ao_reg[3].

Kevin

[1] http://dn.odroid.com/S905/DataSheet/S905_Public_Datasheet_V1.1.4.pdf
