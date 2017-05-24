From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed, 24 May 2017 10:53:20 +0200
Subject: [PATCH 3/5] pinctrl: meson-gxbb: Add CEC pins
In-Reply-To: <1495614042-2676-4-git-send-email-narmstrong@baylibre.com>
References: <1495614042-2676-1-git-send-email-narmstrong@baylibre.com>
 <1495614042-2676-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495616000.14589.10.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-05-24 at 10:20 +0200, Neil Armstrong wrote:
> Add the AO and EE domain CEC pins for the Amlogic Meson GXBB SoCs.

The patch is correct but a slightly longer blurb would have been nice :)

Here AO and EE are not referring to the GPIO controller like they usually do in
our patches to pinctrl.
They refer to the 2 different CEC controllers, located in each power domain and
both connected to AO GPIO controller (same pin actually)

Not sure if this worth a resent though.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
> ?drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 10 ++++++++++
> ?1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> index 3ccb0f4f..b44314a 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
> @@ -295,6 +295,9 @@
> ?static const unsigned int spdif_out_ao_6_pins[]	= { PIN(GPIOAO_6, 0)
> };
> ?static const unsigned int spdif_out_ao_13_pins[] = { PIN(GPIOAO_13, 0) };
> ?
> +static const unsigned int ao_cec_pins[]??????????= { PIN(GPIOAO_12, 0) };
> +static const unsigned int ee_cec_pins[]??????????= { PIN(GPIOAO_12, 0) };
> +
> ?static struct meson_pmx_group meson_gxbb_periphs_groups[] = {
> ?	GPIO_GROUP(GPIOZ_0, EE_OFF),
> ?	GPIO_GROUP(GPIOZ_1, EE_OFF),
> @@ -560,6 +563,8 @@
> ?	GROUP(i2s_out_ch45_ao,	1,	1),
> ?	GROUP(spdif_out_ao_6,	0,	16),
> ?	GROUP(spdif_out_ao_13,	0,	4),
> +	GROUP(ao_cec,???????????0,??????15),
> +	GROUP(ee_cec,???????????0,??????14),
> ?};
> ?
> ?static const char * const gpio_periphs_groups[] = {
> @@ -752,6 +757,10 @@
> ?	"spdif_out_ao_6", "spdif_out_ao_13",
> ?};
> ?
> +static const char * const cec_ao_groups[] = {
> +	"ao_cec", "ee_cec",
> +};
> +
> ?static struct meson_pmx_func meson_gxbb_periphs_functions[] = {
> ?	FUNCTION(gpio_periphs),
> ?	FUNCTION(emmc),
> @@ -793,6 +802,7 @@
> ?	FUNCTION(pwm_ao_b),
> ?	FUNCTION(i2s_out_ao),
> ?	FUNCTION(spdif_out_ao),
> +	FUNCTION(cec_ao),
> ?};
> ?
> ?static struct meson_bank meson_gxbb_periphs_banks[] = {
