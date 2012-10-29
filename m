From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 29 Oct 2012 22:10:15 +0100
Subject: [PATCH] Add device tree file for the armadeus apf27
In-Reply-To: <1351268980-25347-1-git-send-email-tremyfr@yahoo.fr>
References: <1351268980-25347-1-git-send-email-tremyfr@yahoo.fr>
Message-ID: <20121029211015.GX1641@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 06:29:40PM +0200, Philippe Reynes wrote:
> Signed-off-by: Philippe Reynes <tremyfr@yahoo.fr>
> Signed-off-by: Eric Jarrige <eric.jarrige@armadeus.org>
> ---
>  arch/arm/boot/dts/imx27-apf27.dts |   96 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 96 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx27-apf27.dts
> 
> diff --git a/arch/arm/boot/dts/imx27-apf27.dts b/arch/arm/boot/dts/imx27-apf27.dts
> new file mode 100644
> index 0000000..b7d11e0
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx27-apf27.dts
> @@ -0,0 +1,96 @@
> +/*
> + * Copyright 2012 Philippe Reynes <tremyfr@yahoo.fr>
> + * Copyright 2012 Armadeus Systems <support@armadeus.com>
> + *
> + * Based on code which is: Copyright 2012 Sascha Hauer, Pengutronix
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +/include/ "imx27.dtsi"
> +
> +/ {
> +	model = "Armadeus apf27";
> +	compatible = "armadeus,imx27-apf27", "fsl,imx27";
> +
> +	memory {
> +		reg = <0xa0000000 0x04000000>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		osc26m {
> +			compatible = "fsl,imx-osc26m", "fixed-clock";
> +			clock-frequency = <33554432>;

Is this really correct? The Datasheet specificies 26MHz, some boards
have 27Mhz, but 33?

> +		};
> +	};
> +
> +	soc {
> +		aipi at 10000000 {
> +			wdog at 10002000 {
> +				status = "okay";
> +			};

This node is not necessary. The watchdog is enabled already in the dtsi
file.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
