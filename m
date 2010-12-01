From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 1 Dec 2010 08:24:16 +0100
Subject: [PATCH v5 1/2] ARM: mx5: dynamically allocate pwm devices
In-Reply-To: <1291156869-4941-1-git-send-email-festevam@gmail.com>
References: <1291156869-4941-1-git-send-email-festevam@gmail.com>
Message-ID: <20101201072416.GB32355@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 08:41:08PM -0200, Fabio Estevam wrote:
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/plat-mxc/devices/platform-mxc_pwm.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> index 3d8ebdb..a5e1581 100644
> --- a/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> +++ b/arch/arm/plat-mxc/devices/platform-mxc_pwm.c
> @@ -40,6 +40,15 @@ const struct imx_mxc_pwm_data imx27_mxc_pwm_data __initconst =
>  	imx_mxc_pwm_data_entry_single(MX27, 0, , SZ_4K);
>  #endif /* ifdef CONFIG_SOC_IMX27 */
>  
> +#ifdef CONFIG_SOC_IMX51
> +const struct imx_mxc_pwm_data imx51_mxc_pwm_data[] __initconst = {
> +#define imx51_mxc_pwm_data_entry(_id, _hwid)				\
> +	imx_mxc_pwm_data_entry(MX51, _id, _hwid, SZ_16K)
> +	imx51_mxc_pwm_data_entry(0, 1),
> +	imx51_mxc_pwm_data_entry(1, 2),
> +};
> +#endif /* ifdef CONFIG_SOC_IMX51 */
> +
Does this compile?  I guess you need to rename MX51_MXC_INT_PWM1 and
MX51_MXC_INT_PWM2.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
