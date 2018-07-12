From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 12 Jul 2018 12:33:33 +0200
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: Disable internal watchdog
In-Reply-To: <1531344867-898-1-git-send-email-festevam@gmail.com>
References: <1531344867-898-1-git-send-email-festevam@gmail.com>
Message-ID: <1531391613.3163.70.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 11.07.2018, 18:34 -0300 schrieb Fabio Estevam:
> > From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> imx51-zii-rdu1 has an external watchdog in the environment
> microcontroller, so disable the internal one.
> 
> This aligns with what was done in commit 7055f714032c ("ARM: dts:
> imx6: RDU2: disable internal watchdog") for imx6 rdu2 board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> ?arch/arm/boot/dts/imx51-zii-rdu1.dts | 4 ++++
> ?1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index 257c918..0af9f67 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -668,6 +668,10 @@
> > ?	status = "okay";
> ?};
> ?
> +&wdog1 {
> > +	status = "disabled";
> +};
> +
> ?&iomuxc {
> > ?	pinctrl_ampgpio: ampgpiogrp {
> > ?		fsl,pins = <
