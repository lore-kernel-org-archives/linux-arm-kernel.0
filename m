From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 12 Mar 2014 11:31:20 +0100
Subject: [PATCH 2/5] pinctrl: pfc: r8a7790: add mux data for IIC(B) cores
In-Reply-To: <1394573078-20767-3-git-send-email-wsa@the-dreams.de>
References: <1394573078-20767-1-git-send-email-wsa@the-dreams.de>
 <1394573078-20767-3-git-send-email-wsa@the-dreams.de>
Message-ID: <1487701.LOG4G2YIn1@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Thank you for the patch.

On Tuesday 11 March 2014 22:24:35 Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 118 +++++++++++++++++++++++++++++++-
>  1 file changed, 116 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index bd21022cf9bf..857d5c3d2fa8
> 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> @@ -782,8 +782,8 @@ enum {
>  	USB1_PWEN_MARK, AUDIO_CLKOUT_D_MARK, USB1_OVC_MARK,
>  	TCLK1_B_MARK,
> 
> -	I2C0_SCL_MARK, I2C0_SDA_MARK,
> -	I2C3_SCL_MARK, I2C3_SDA_MARK,
> +	IIC0_SCL_MARK, IIC0_SDA_MARK, I2C0_SCL_MARK, I2C0_SDA_MARK,
> +	IIC3_SCL_MARK, IIC3_SDA_MARK, I2C3_SCL_MARK, I2C3_SDA_MARK,
>  	PINMUX_MARK_END,
>  };
> 
> @@ -1723,9 +1723,13 @@ static const u16 pinmux_data[] = {
>  	PINMUX_IPSR_DATA(IP16_7, USB1_OVC),
>  	PINMUX_IPSR_MODSEL_DATA(IP16_7, TCLK1_B, SEL_TMU1_1),
> 
> +	PINMUX_DATA(IIC0_SCL_MARK, FN_SEL_IIC0_0),
> +	PINMUX_DATA(IIC0_SDA_MARK, FN_SEL_IIC0_0),
>  	PINMUX_DATA(I2C0_SCL_MARK, FN_SEL_IIC0_1),
>  	PINMUX_DATA(I2C0_SDA_MARK, FN_SEL_IIC0_1),
> 
> +	PINMUX_DATA(IIC3_SCL_MARK, FN_SEL_IICDVFS_0),
> +	PINMUX_DATA(IIC3_SDA_MARK, FN_SEL_IICDVFS_0),
>  	PINMUX_DATA(I2C3_SCL_MARK, FN_SEL_IICDVFS_1),
>  	PINMUX_DATA(I2C3_SDA_MARK, FN_SEL_IICDVFS_1),
>  };
> @@ -2134,6 +2138,80 @@ static const unsigned int i2c3_pins[] = {
>  static const unsigned int i2c3_mux[] = {
>  	I2C3_SCL_MARK, I2C3_SDA_MARK,
>  };
> +/* - I2C4
> ------------------------------------------------------------------- */

What about calling the groups iic0-iic3 to match the names from the datasheet 
?

The rest of the patch looks good to me.

> +static const unsigned int i2c4_pins[] = {
> +	/* SCL, SDA */
> +	PIN_A_NUMBER('G', 15), PIN_A_NUMBER('F', 15),
> +};
> +static const unsigned int i2c4_mux[] = {
> +	IIC0_SCL_MARK, IIC0_SDA_MARK,
> +};
> +/* - I2C5
> ------------------------------------------------------------------- */
> +static const unsigned int i2c5_pins[] = {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(1, 16), RCAR_GP_PIN(1, 17),
> +};
> +static const unsigned int i2c5_mux[] = {
> +	IIC1_SCL_MARK, IIC1_SDA_MARK,
> +};
> +static const unsigned int i2c5_b_pins[] = {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(3, 6), RCAR_GP_PIN(3, 7),
> +};
> +static const unsigned int i2c5_b_mux[] = {
> +	IIC1_SCL_B_MARK, IIC1_SDA_B_MARK,
> +};
> +static const unsigned int i2c5_c_pins[] = {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(4, 30), RCAR_GP_PIN(4, 27),
> +};
> +static const unsigned int i2c5_c_mux[] = {
> +	IIC1_SCL_C_MARK, IIC1_SDA_C_MARK,
> +};
> +/* - I2C6
> ------------------------------------------------------------------- */
> +static const unsigned int i2c6_pins[] = {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(5, 5), RCAR_GP_PIN(5, 6),
> +};
> +static const unsigned int i2c6_mux[] = {
> +	IIC2_SCL_MARK, IIC2_SDA_MARK,
> +};
> +static const unsigned int i2c6_b_pins[] = {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(4, 0), RCAR_GP_PIN(4, 1),
> +};
> +static const unsigned int i2c6_b_mux[] = {
> +	IIC2_SCL_B_MARK, IIC2_SDA_B_MARK,
> +};
> +static const unsigned int i2c6_c_pins[] = {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(0, 6), RCAR_GP_PIN(0, 7),
> +};
> +static const unsigned int i2c6_c_mux[] = {
> +	IIC2_SCL_C_MARK, IIC2_SDA_C_MARK,
> +};
> +static const unsigned int i2c6_d_pins[] = {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(3, 14), RCAR_GP_PIN(3, 15),
> +};
> +static const unsigned int i2c6_d_mux[] = {
> +	IIC2_SCL_D_MARK, IIC2_SDA_D_MARK,
> +};
> +static const unsigned int i2c6_e_pins[] = {
> +	/* SCL, SDA */
> +	RCAR_GP_PIN(2, 18), RCAR_GP_PIN(2, 19),
> +};
> +static const unsigned int i2c6_e_mux[] = {
> +	IIC2_SCL_E_MARK, IIC2_SDA_E_MARK,
> +};
> +/* - I2C7
> ------------------------------------------------------------------- */
> +static const unsigned int i2c7_pins[] = {
> +/* SCL, SDA */
> +	PIN_A_NUMBER('J', 15), PIN_A_NUMBER('H', 15),
> +};
> +static const unsigned int i2c7_mux[] = {
> +	IIC3_SCL_MARK, IIC3_SDA_MARK,
> +};
>  /* - INTC
> ------------------------------------------------------------------- */
> static const unsigned int intc_irq0_pins[] = {
>  	/* IRQ */
> @@ -3650,6 +3728,16 @@ static const struct sh_pfc_pin_group pinmux_groups[]
> = { SH_PFC_PIN_GROUP(i2c2_d),
>  	SH_PFC_PIN_GROUP(i2c2_e),
>  	SH_PFC_PIN_GROUP(i2c3),
> +	SH_PFC_PIN_GROUP(i2c4),
> +	SH_PFC_PIN_GROUP(i2c5),
> +	SH_PFC_PIN_GROUP(i2c5_b),
> +	SH_PFC_PIN_GROUP(i2c5_c),
> +	SH_PFC_PIN_GROUP(i2c6),
> +	SH_PFC_PIN_GROUP(i2c6_b),
> +	SH_PFC_PIN_GROUP(i2c6_c),
> +	SH_PFC_PIN_GROUP(i2c6_d),
> +	SH_PFC_PIN_GROUP(i2c6_e),
> +	SH_PFC_PIN_GROUP(i2c7),
>  	SH_PFC_PIN_GROUP(intc_irq0),
>  	SH_PFC_PIN_GROUP(intc_irq1),
>  	SH_PFC_PIN_GROUP(intc_irq2),
> @@ -3932,6 +4020,28 @@ static const char * const i2c3_groups[] = {
>  	"i2c3",
>  };
> 
> +static const char * const i2c4_groups[] = {
> +	"i2c4",
> +};
> +
> +static const char * const i2c5_groups[] = {
> +	"i2c5",
> +	"i2c5_b",
> +	"i2c5_c",
> +};
> +
> +static const char * const i2c6_groups[] = {
> +	"i2c6",
> +	"i2c6_b",
> +	"i2c6_c",
> +	"i2c6_d",
> +	"i2c6_e",
> +};
> +
> +static const char * const i2c7_groups[] = {
> +	"i2c7",
> +};
> +
>  static const char * const intc_groups[] = {
>  	"intc_irq0",
>  	"intc_irq1",
> @@ -4226,6 +4336,10 @@ static const struct sh_pfc_function
> pinmux_functions[] = { SH_PFC_FUNCTION(i2c1),
>  	SH_PFC_FUNCTION(i2c2),
>  	SH_PFC_FUNCTION(i2c3),
> +	SH_PFC_FUNCTION(i2c4),
> +	SH_PFC_FUNCTION(i2c5),
> +	SH_PFC_FUNCTION(i2c6),
> +	SH_PFC_FUNCTION(i2c7),
>  	SH_PFC_FUNCTION(intc),
>  	SH_PFC_FUNCTION(mmc0),
>  	SH_PFC_FUNCTION(mmc1),

-- 
Regards,

Laurent Pinchart
