From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 10:00:57 +0200
Subject: [RESEND PATCH 1/2] pinctrl: meson-gxbb: add pins for PWM
In-Reply-To: <1471876860-5620-2-git-send-email-narmstrong@baylibre.com>
References: <1471876860-5620-1-git-send-email-narmstrong@baylibre.com>
 <1471876860-5620-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <45c22d0c-9cfd-b0a0-4499-6b306dfdcdd5@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2016 04:40 PM, Neil Armstrong wrote:
> Add support for PWM pins, for EE and AO domains.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 78 ++++++++++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> index 7eeb053..1c6ffb3 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c

[...]

>  static const char * const gpio_aobus_groups[] = {
>  	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3", "GPIOAO_4",
>  	"GPIOAO_5", "GPIOAO_6", "GPIOAO_7", "GPIOAO_8", "GPIOAO_9",
> @@ -526,6 +578,21 @@ static const char * const i2c_slave_ao_groups[] = {
>  
>  static const char * const remote_input_ao_groups[] = {
>  	"remote_input_ao",
> +

Linus,

Well, I missed my rebase, I'll post a v2 to fix that.

Neil

> +static const char * const pwm_ao_a_3_groups[] = {
> +	"pwm_ao_a_3",
> +};
> +
> +static const char * const pwm_ao_a_6_groups[] = {
> +	"pwm_ao_a_6",
> +};
> +
> +static const char * const pwm_ao_a_12_groups[] = {
> +	"pwm_ao_a_12",
> +};
> +
> +static const char * const pwm_ao_b_groups[] = {
> +	"pwm_ao_b",
>  };
>  
>  static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
> @@ -536,6 +603,13 @@ static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
>  	FUNCTION(uart_b),
>  	FUNCTION(uart_c),
>  	FUNCTION(eth),
> +	FUNCTION(pwm_a_x),
> +	FUNCTION(pwm_a_y),
> +	FUNCTION(pwm_b),
> +	FUNCTION(pwm_d),
> +	FUNCTION(pwm_e),
> +	FUNCTION(pwm_f_x),
> +	FUNCTION(pwm_f_y),
>  };
>  
>  static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
> @@ -545,6 +619,10 @@ static struct meson_pmx_func meson_gxbb_aobus_functions[] = {
>  	FUNCTION(i2c_ao),
>  	FUNCTION(i2c_slave_ao),
>  	FUNCTION(remote_input_ao),
> +	FUNCTION(pwm_ao_a_3),
> +	FUNCTION(pwm_ao_a_6),
> +	FUNCTION(pwm_ao_a_12),
> +	FUNCTION(pwm_ao_b),
>  };
>  
>  static struct meson_bank meson_gxbb_periphs_banks[] = {
> 
