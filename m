From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 30 Jun 2015 10:08:38 +0200
Subject: [PATCH] Add dts info for wandboard GPIO lines.
In-Reply-To: <1375306847-14340-2-git-send-email-panetta.mike@gmail.com>
References: <1375306847-14340-1-git-send-email-panetta.mike@gmail.com>
 <1375306847-14340-2-git-send-email-panetta.mike@gmail.com>
Message-ID: <20150630080838.GA18829@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

while starting to use the GPIO lines being available on the JP4
connector of the wand board I stumbled over this patch on the linux arm
kernel mailing list:

On Wed, Jul 31, 2013 at 05:40:47PM -0400, Michael Panetta wrote:
> diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> index a55113e..b40bbe1 100644
> --- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
> @@ -84,6 +84,23 @@
>  			>;
>  		};
>  	};
> +
> +	gpio {
> +		pinctrl_gpio: gpiogrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_EIM_DA12__GPIO3_IO12   0x80000000 /* GPIO3_12 EDM pin 255 */

Looking at the "Wandboard User Guide, Revision B1"[1] I'd say EDM pin
255 on the board drives the signal GPIO3_11 and so TP128 on the board.
Instead it's pad MX6QDL_PAD_EIM_DA11 (and so GPIO3_IO11) that is
connected to EDM pin 256 which is called GPIO3_12 for the Wandboard.

Unless I'm failing to read the schematics, this is an unfortunate naming
mismatch that someone might want to fix?!

Best regards
Uwe

PS: The patch was never applied to the mainline kernel.

[1] http://www.wandboard.org/images/downloads/wbquad-revb1-userguide.pdf

> +				MX6QDL_PAD_EIM_DA11__GPIO3_IO11   0x80000000 /* GPIO3_11 EDM pin 256 */
> +				MX6QDL_PAD_EIM_DA10__GPIO3_IO10   0x80000000 /* GPIO3_10 EDM pin 257 */
> +				MX6QDL_PAD_EIM_D27__GPIO3_IO27    0x80000000 /* GPIO3_27 EDM pin 258 */
> +				MX6QDL_PAD_EIM_D26__GPIO3_IO26    0x80000000 /* GPIO3_26 EDM pin 259 */
> +				MX6QDL_PAD_EIM_BCLK__GPIO6_IO31   0x80000000 /* GPIO6_31 EDM pin 260 */
> +				MX6QDL_PAD_EIM_DA8__GPIO3_IO08    0x80000000 /* GPIO3_8  EDM pin 261 */
> +				MX6QDL_PAD_ENET_RX_ER__GPIO1_IO24 0x80000000 /* GPIO1_24 EDM pin 262 */
> +				MX6QDL_PAD_GPIO_19__GPIO4_IO05    0x80000000 /* GPIO4_5  EDM pin 263 */
> +				MX6QDL_PAD_SD3_RST__GPIO7_IO08    0x80000000 /* GPIO7_8  EDM pin 264 */
> +			>;
> +		};
> +	};
>  };

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
