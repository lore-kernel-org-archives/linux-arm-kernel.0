From: kieran.bingham@ideasonboard.com (Kieran Bingham)
Date: Thu, 15 Feb 2018 12:32:51 +0000
Subject: [PATCH 1/8] pinctrl: sh-pfc: r8a77995: Add DU support
In-Reply-To: <1518683903-10681-2-git-send-email-kbingham@kernel.org>
References: <1518683903-10681-1-git-send-email-kbingham@kernel.org>
 <1518683903-10681-2-git-send-email-kbingham@kernel.org>
Message-ID: <9ac40731-eb13-4727-864d-0e3b7059b9f8@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch duplicates work performed by Ulrich.

Please consider this patch dropped, and no need for review.

(especially the obvious error in the pin-values)

Oh well - it was a fun exercise to go through :-)

--
Regards

Kieran

On 15/02/18 08:38, Kieran Bingham wrote:
> From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> 
> Provide pin control support for the DU parallel RGB output signals.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a77995.c | 101 ++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
> index a4927b78a17b..277b0d6972f7 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a77995.c
> @@ -1114,6 +1114,87 @@ static const unsigned int canfd1_data_mux[] = {
>  	CANFD1_TX_MARK, CANFD1_RX_MARK,
>  };
>  
> +/* - DU --------------------------------------------------------------------- */
> +static const unsigned int du_rgb666_pins[] = {
> +	/* R[7:2], G[7:2], B[7:2] */
> +	RCAR_GP_PIN(1, 23), RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 21),
> +	RCAR_GP_PIN(1, 20), RCAR_GP_PIN(1, 19), RCAR_GP_PIN(1, 18),
> +	RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 13),
> +	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 11), RCAR_GP_PIN(1, 10),
> +	RCAR_GP_PIN(1, 7),  RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 5),
> +	RCAR_GP_PIN(1, 4),  RCAR_GP_PIN(1, 3),  RCAR_GP_PIN(1, 2),
> +};
> +static const unsigned int du_rgb666_mux[] = {
> +	DU_DR7_MARK, DU_DR6_MARK, DU_DR5_MARK, DU_DR4_MARK,
> +	DU_DR3_MARK, DU_DR2_MARK,
> +	DU_DG7_MARK, DU_DG6_MARK, DU_DG5_MARK, DU_DG4_MARK,
> +	DU_DG3_MARK, DU_DG2_MARK,
> +	DU_DB7_MARK, DU_DB6_MARK, DU_DB5_MARK, DU_DB4_MARK,
> +	DU_DB3_MARK, DU_DB2_MARK,
> +};
> +static const unsigned int du_rgb888_pins[] = {
> +	/* R[7:0], G[7:0], B[7:0] */
> +	RCAR_GP_PIN(1, 23), RCAR_GP_PIN(1, 22), RCAR_GP_PIN(1, 21),
> +	RCAR_GP_PIN(1, 20), RCAR_GP_PIN(1, 19), RCAR_GP_PIN(1, 18),
> +	RCAR_GP_PIN(1, 17), RCAR_GP_PIN(1, 16),
> +	RCAR_GP_PIN(1, 15), RCAR_GP_PIN(1, 14), RCAR_GP_PIN(1, 13),
> +	RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 11), RCAR_GP_PIN(1, 10),
> +	RCAR_GP_PIN(1, 9),  RCAR_GP_PIN(1, 8),
> +	RCAR_GP_PIN(1, 7),  RCAR_GP_PIN(1, 6),  RCAR_GP_PIN(1, 5),
> +	RCAR_GP_PIN(1, 4),  RCAR_GP_PIN(1, 3),  RCAR_GP_PIN(1, 2),
> +	RCAR_GP_PIN(1, 1),  RCAR_GP_PIN(1, 0),
> +};
> +static const unsigned int du_rgb888_mux[] = {
> +	DU_DR7_MARK, DU_DR6_MARK, DU_DR5_MARK, DU_DR4_MARK,
> +	DU_DR3_MARK, DU_DR2_MARK, DU_DR1_MARK, DU_DR0_MARK,
> +	DU_DG7_MARK, DU_DG6_MARK, DU_DG5_MARK, DU_DG4_MARK,
> +	DU_DG3_MARK, DU_DG2_MARK, DU_DG1_MARK, DU_DG0_MARK,
> +	DU_DB7_MARK, DU_DB6_MARK, DU_DB5_MARK, DU_DB4_MARK,
> +	DU_DB3_MARK, DU_DB2_MARK, DU_DB1_MARK, DU_DB0_MARK,
> +};
> +static const unsigned int du_dotclkout0_pins[] = {
> +	/* CLKOUT */
> +	RCAR_GP_PIN(1, 24),
> +};
> +static const unsigned int du_dotclkout0_mux[] = {
> +	DU_DOTCLKOUT0_MARK
> +};
> +static const unsigned int du_sync_pins[] = {
> +	/* HSYNC, VSYNC */
> +	RCAR_GP_PIN(1, 25), RCAR_GP_PIN(1, 26),
> +};
> +static const unsigned int du_sync_mux[] = {
> +	DU_HSYNC_MARK, DU_VSYNC_MARK
> +};
> +static const unsigned int du_disp_pins[] = {
> +	/* DISP */
> +	RCAR_GP_PIN(2, 1),
> +};
> +static const unsigned int du_disp_mux[] = {
> +	DU_DISP_MARK,
> +};
> +static const unsigned int du_dotclkin1_pins[] = {
> +	/* DOTCLKOUT0 */
> +	RCAR_GP_PIN(1, 28),
> +};
> +static const unsigned int du_dotclkin1_mux[] = {
> +	DU_DOTCLKIN1_MARK,
> +};
> +static const unsigned int du_disp_cde_pins[] = {
> +	/* DISP/CDE */
> +	RCAR_GP_PIN(1, 28),
> +};
> +static const unsigned int du_disp_cde_mux[] = {
> +	DU_DISP_CDE_MARK,
> +};
> +static const unsigned int du_cde_pins[] = {
> +	/* CDE */
> +	RCAR_GP_PIN(1, 29),
> +};
> +static const unsigned int du_cde_mux[] = {
> +	DU_CDE_MARK,
> +};
> +
>  /* - I2C -------------------------------------------------------------------- */
>  static const unsigned int i2c0_pins[] = {
>  	/* SCL, SDA */
> @@ -1568,6 +1649,14 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
>  	SH_PFC_PIN_GROUP(can_clk),
>  	SH_PFC_PIN_GROUP(canfd0_data),
>  	SH_PFC_PIN_GROUP(canfd1_data),
> +	SH_PFC_PIN_GROUP(du_rgb666),
> +	SH_PFC_PIN_GROUP(du_rgb888),
> +	SH_PFC_PIN_GROUP(du_dotclkout0),
> +	SH_PFC_PIN_GROUP(du_sync),
> +	SH_PFC_PIN_GROUP(du_disp),
> +	SH_PFC_PIN_GROUP(du_dotclkin1),
> +	SH_PFC_PIN_GROUP(du_disp_cde),
> +	SH_PFC_PIN_GROUP(du_cde),
>  	SH_PFC_PIN_GROUP(i2c0),
>  	SH_PFC_PIN_GROUP(i2c1),
>  	SH_PFC_PIN_GROUP(i2c2_a),
> @@ -1664,6 +1753,17 @@ static const char * const canfd1_groups[] = {
>  	"canfd1_data",
>  };
>  
> +static const char * const du_groups[] = {
> +	"du_rgb666",
> +	"du_rgb888",
> +	"du_dotclk_out_0",
> +	"du_sync",
> +	"du_disp",
> +	"du_dotclk_in_1",
> +	"du_disp_cde",
> +	"du_cde",
> +};
> +
>  static const char * const i2c0_groups[] = {
>  	"i2c0",
>  };
> @@ -1779,6 +1879,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
>  	SH_PFC_FUNCTION(can_clk),
>  	SH_PFC_FUNCTION(canfd0),
>  	SH_PFC_FUNCTION(canfd1),
> +	SH_PFC_FUNCTION(du),
>  	SH_PFC_FUNCTION(i2c0),
>  	SH_PFC_FUNCTION(i2c1),
>  	SH_PFC_FUNCTION(i2c2),
> 
