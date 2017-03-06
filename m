From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 06 Mar 2017 15:42:37 +0100
Subject: [PATCH 1/2] pinctrl: meson: gxl: add the missing PWM pin
 definitions
In-Reply-To: <20170304212318.27076-2-martin.blumenstingl@googlemail.com>
References: <20170304212318.27076-1-martin.blumenstingl@googlemail.com>
 <20170304212318.27076-2-martin.blumenstingl@googlemail.com>
Message-ID: <1488811357.2420.18.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-03-04 at 22:23 +0100, Martin Blumenstingl wrote:
> This adds support for the missing PWM pins on Meson GXL SoCs, namely:
> - PWM_A
> - PWM_B
> - PWM_C
> - PWM_F (GPIOX_7 and GPIOCLK_1 can be selected as output)
> - PWM_AO_A (GPIOAO_3 and GPIOAO_8 can be selected as output)
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.co
> m>
> ---
> ?drivers/pinctrl/meson/pinctrl-meson-gxl.c | 64
> +++++++++++++++++++++++++++++++
> ?1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> index 4ab94a85e306..91dfc498780b 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
> @@ -195,8 +195,19 @@ static const unsigned int eth_txd1_pins[]	
> = { PIN(GPIOZ_11, EE_OFF) };
> ?static const unsigned int eth_txd2_pins[]	= { PIN(GPIOZ_12,
> EE_OFF) };
> ?static const unsigned int eth_txd3_pins[]	= { PIN(GPIOZ_13,
> EE_OFF) };
> ?
> +static const unsigned int pwm_a_pins[]		= {
> PIN(GPIOX_6, EE_OFF) };
> +
> +static const unsigned int pwm_b_pins[]		= {
> PIN(GPIODV_29, EE_OFF) };
> +
> +static const unsigned int pwm_c_pins[]		= {
> PIN(GPIOZ_15, EE_OFF) };
> +
> +static const unsigned int pwm_d_pins[]		= {
> PIN(GPIODV_28, EE_OFF) };
> +
> ?static const unsigned int pwm_e_pins[]		= {
> PIN(GPIOX_16, EE_OFF) };
> ?
> +static const unsigned int pwm_f_clk_pins[]	= { PIN(GPIOCLK_1,
> EE_OFF) };
> +static const unsigned int pwm_f_x_pins[]	= { PIN(GPIOX_7,
> EE_OFF) };
> +
> ?static const unsigned int hdmi_hpd_pins[]	= { PIN(GPIOH_0,
> EE_OFF) };
> ?static const unsigned int hdmi_sda_pins[]	= { PIN(GPIOH_1,
> EE_OFF) };
> ?static const unsigned int hdmi_scl_pins[]	= { PIN(GPIOH_2,
> EE_OFF) };
> @@ -225,6 +236,9 @@ static const unsigned int uart_rts_ao_b_pins[]	
> = { PIN(GPIOAO_3, 0) };
> ?
> ?static const unsigned int remote_input_ao_pins[] = {PIN(GPIOAO_7, 0)
> };
> ?
> +static const unsigned int pwm_ao_a_3_pins[]	= { PIN(GPIOAO_3,
> 0) };
> +static const unsigned int pwm_ao_a_8_pins[]	= { PIN(GPIOAO_8,
> 0) };
> +
> ?static const unsigned int pwm_ao_b_pins[]	= { PIN(GPIOAO_9,
> 0) };
> ?
> ?static struct meson_pmx_group meson_gxl_periphs_groups[] = {
> @@ -350,7 +364,9 @@ static struct meson_pmx_group
> meson_gxl_periphs_groups[] = {
> ?	GROUP(uart_rts_a,	5,	16),
> ?	GROUP(uart_tx_c,	5,	13),
> ?	GROUP(uart_rx_c,	5,	12),
> +	GROUP(pwm_a,		5,	25),
> ?	GROUP(pwm_e,		5,	15),
> +	GROUP(pwm_f_x,		5,	14),
> ?
> ?	/* Bank Z */
> ?	GROUP(eth_mdio,		4,	22),
> @@ -367,6 +383,7 @@ static struct meson_pmx_group
> meson_gxl_periphs_groups[] = {
> ?	GROUP(eth_txd1,		4,	12),
> ?	GROUP(eth_txd2,		4,	11),
> ?	GROUP(eth_txd3,		4,	10),
> +	GROUP(pwm_c,		3,	20),
> ?
> ?	/* Bank H */
> ?	GROUP(hdmi_hpd,		6,	31),
> @@ -382,6 +399,8 @@ static struct meson_pmx_group
> meson_gxl_periphs_groups[] = {
> ?	GROUP(i2c_sda_b,	1,	12),
> ?	GROUP(i2c_sck_c,	1,	11),
> ?	GROUP(i2c_sda_c,	1,	10),
> +	GROUP(pwm_b,		2,	11),
> +	GROUP(pwm_d,		2,	12),
> ?
> ?	/* Bank BOOT */
> ?	GROUP(emmc_nand_d07,	7,	31),
> @@ -404,6 +423,9 @@ static struct meson_pmx_group
> meson_gxl_periphs_groups[] = {
> ?	GROUP(sdcard_d2,	6,	0),
> ?	GROUP(sdcard_cmd,	6,	2),
> ?	GROUP(sdcard_clk,	6,	3),
> +
> +	/* Bank CLK */
> +	GROUP(pwm_f_clk,	8,	30),
> ?};
> ?
> ?static struct meson_pmx_group meson_gxl_aobus_groups[] = {
> @@ -428,6 +450,8 @@ static struct meson_pmx_group
> meson_gxl_aobus_groups[] = {
> ?	GROUP(uart_cts_ao_b,	0,	8),
> ?	GROUP(uart_rts_ao_b,	0,	7),
> ?	GROUP(remote_input_ao,	0,	0),
> +	GROUP(pwm_ao_a_3,	0,	22),
> +	GROUP(pwm_ao_a_8,	0,	17),
> ?	GROUP(pwm_ao_b,		0,	3),
> ?};
> ?
> @@ -513,10 +537,34 @@ static const char * const eth_groups[] = {
> ?	"eth_txd0", "eth_txd1", "eth_txd2", "eth_txd3",
> ?};
> ?
> +static const char * const pwm_a_groups[] = {
> +	"pwm_a",
> +};
> +
> +static const char * const pwm_b_groups[] = {
> +	"pwm_b",
> +};
> +
> +static const char * const pwm_c_groups[] = {
> +	"pwm_c",
> +};
> +
> +static const char * const pwm_d_groups[] = {
> +	"pwm_d",
> +};
> +
> ?static const char * const pwm_e_groups[] = {
> ?	"pwm_e",
> ?};
> ?
> +static const char * const pwm_f_clk_groups[] = {
> +	"pwm_f_clk",
> +};
> +
> +static const char * const pwm_f_x_groups[] = {
> +	"pwm_f_x",
> +};
> +
> ?static const char * const hdmi_hpd_groups[] = {
> ?	"hdmi_hpd",
> ?};
> @@ -542,6 +590,14 @@ static const char * const
> remote_input_ao_groups[] = {
> ?	"remote_input_ao",
> ?};
> ?
> +static const char * const pwm_ao_a_3_groups[] = {
> +	"pwm_ao_a_3",
> +};
> +
> +static const char * const pwm_ao_a_8_groups[] = {
> +	"pwm_ao_a_8",
> +};
> +
> ?static const char * const pwm_ao_b_groups[] = {
> ?	"pwm_ao_b",
> ?};
> @@ -559,7 +615,13 @@ static struct meson_pmx_func
> meson_gxl_periphs_functions[] = {
> ?	FUNCTION(i2c_b),
> ?	FUNCTION(i2c_c),
> ?	FUNCTION(eth),
> +	FUNCTION(pwm_a),
> +	FUNCTION(pwm_b),
> +	FUNCTION(pwm_c),
> +	FUNCTION(pwm_d),
> ?	FUNCTION(pwm_e),
> +	FUNCTION(pwm_f_clk),
> +	FUNCTION(pwm_f_x),

I wonder if having function named "pwm_f_clk" really makes sense ?
Shouldn't it be just "pwm_f" ? This is real function, isn't it ?
The actual pin used will be provided in the dt. Here, I suppose we
could have this:

+static const char * const pwm_f_groups[] = {
+	"pwm_f_x", "pwm_f_clk",
+};

Has far as I can see, on meson arch, the function does not carry much
information anyway, except for prints.

To be clear, I'm not questioning this change in particular. It looks
good, and follows what has been done in the past on meson. I know we
have been this a lot already, but I'm questioning whether we should
continue to do so ?

I asking because I also have a lot case like this coming up on audio
for gxl and gxbb, where the same function can use different pins.

Of course, I'd be happy to provide such change on top of martin patch.

> ?	FUNCTION(hdmi_hpd),
> ?	FUNCTION(hdmi_i2c),
> ?};
> @@ -569,6 +631,8 @@ static struct meson_pmx_func
> meson_gxl_aobus_functions[] = {
> ?	FUNCTION(uart_ao),
> ?	FUNCTION(uart_ao_b),
> ?	FUNCTION(remote_input_ao),
> +	FUNCTION(pwm_ao_a_3),
> +	FUNCTION(pwm_ao_a_8),

Same here

> ?	FUNCTION(pwm_ao_b),
> ?};
> ?
