From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 7 Mar 2013 11:00:27 +0800
Subject: [PATCH 1/2] imx6q: Add ECSPI3 device definition
In-Reply-To: <1362546332-11847-2-git-send-email-xobs@kosagi.com>
References: <1362546332-11847-1-git-send-email-xobs@kosagi.com>
 <1362546332-11847-2-git-send-email-xobs@kosagi.com>
Message-ID: <20130307030018.GD5369@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For imx6q dts patches, please have something like "ARM: dts: imx6q: ..."
be the prefix.

On Wed, Mar 06, 2013 at 05:05:31AM +0000, Sean Cross wrote:
> This adds device tree support for the ECSPI3 device.
> ---
>  arch/arm/boot/dts/imx6q.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index cba021e..65b3a849 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -96,6 +96,16 @@
>  					};
>  				};
>  
> +				ecspi3 {
> +					pinctrl_ecspi3_1: ecspi3grp-1 {
> +						fsl,pins = <
> +							526 0x100b1	/* MX6Q_PAD_DISP0_DAT2__ECSPI3_MISO */
> +							518 0x100b1	/* MX6Q_PAD_DISP0_DAT1__ECSPI3_MOSI */
> +							511 0x100b1	/* MX6Q_PAD_DISP0_DAT0__ECSPI3_SCLK */

We're moving to using macro for pin function name in dts.  Please have
both patches generated based on my imx/dt branch below.

 git://git.linaro.org/people/shawnguo/linux-2.6.git imx/dt

Shawn

> +						>;
> +					};
> +				};
> +
>  				enet {
>  					pinctrl_enet_1: enetgrp-1 {
>  						fsl,pins = <
> -- 
> 1.7.9.5
> 
