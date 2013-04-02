From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Apr 2013 19:43:25 +0800
Subject: [PATCH] pinctrl: imx5: fix SD2_DATA1 pad AUDMUX_AUD4 configuration
In-Reply-To: <1364882642-25574-1-git-send-email-marex@denx.de>
References: <1364882642-25574-1-git-send-email-marex@denx.de>
Message-ID: <20130402114323.GE24039@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek,

On Tue, Apr 02, 2013 at 08:04:02AM +0200, Marek Vasut wrote:
> The IOMUXC_AUDMUX_P4_INPUT_TXCLK_AMX_SELECT_INPUT must be configured as 1
> instead of 0 to have AUD4 muxed on SD2 pins working.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/pinctrl/pinctrl-imx53.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> NOTE: Shawn, we might want this in -stable too ?

I have queued patch b466af3 (pinctrl: imx: move hard-coding data into
device tree) on my imx/dt branch to remove these tables from pinctrl
drivers.

Since there is no in-tree users for MX53_PAD_SD2_DATA1__AUDMUX_AUD4_TXFS,
and we're moving away from it, can we just patch
arch/arm/boot/dts/imx53-pinfunc.h instead?

Shawn

> 
> diff --git a/drivers/pinctrl/pinctrl-imx53.c b/drivers/pinctrl/pinctrl-imx53.c
> index 2c9c8e2..85f401c 100644
> --- a/drivers/pinctrl/pinctrl-imx53.c
> +++ b/drivers/pinctrl/pinctrl-imx53.c
> @@ -1287,7 +1287,7 @@ static struct imx_pin_reg imx53_pin_regs[] = {
>  	IMX_PIN_REG(MX53_PAD_SD2_DATA1, 0x698, 0x30C, 0, 0x000, 0), /* MX53_PAD_SD2_DATA1__ESDHC2_DAT1 */
>  	IMX_PIN_REG(MX53_PAD_SD2_DATA1, 0x698, 0x30C, 1, 0x000, 0), /* MX53_PAD_SD2_DATA1__GPIO1_14 */
>  	IMX_PIN_REG(MX53_PAD_SD2_DATA1, 0x698, 0x30C, 2, 0x848, 1), /* MX53_PAD_SD2_DATA1__KPP_COL_7 */
> -	IMX_PIN_REG(MX53_PAD_SD2_DATA1, 0x698, 0x30C, 3, 0x744, 0), /* MX53_PAD_SD2_DATA1__AUDMUX_AUD4_TXFS */
> +	IMX_PIN_REG(MX53_PAD_SD2_DATA1, 0x698, 0x30C, 3, 0x744, 1), /* MX53_PAD_SD2_DATA1__AUDMUX_AUD4_TXFS */
>  	IMX_PIN_REG(MX53_PAD_SD2_DATA1, 0x698, 0x30C, 5, 0x78C, 4), /* MX53_PAD_SD2_DATA1__CSPI_SS0 */
>  	IMX_PIN_REG(MX53_PAD_SD2_DATA1, 0x698, 0x30C, 7, 0x000, 0), /* MX53_PAD_SD2_DATA1__RTIC_SEC_VIO */
>  	IMX_PIN_REG(MX53_PAD_SD2_DATA0, 0x69C, 0x310, 0, 0x000, 0), /* MX53_PAD_SD2_DATA0__ESDHC2_DAT0 */
> -- 
> 1.7.10.4
> 
