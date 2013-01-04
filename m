From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 4 Jan 2013 13:13:06 +0800
Subject: [PATCH v2] ARM: mx25pdk: Add device tree support
In-Reply-To: <1357230455-12690-1-git-send-email-fabio.estevam@freescale.com>
References: <1357230455-12690-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130104051304.GA1887@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 03, 2013 at 02:27:35PM -0200, Fabio Estevam wrote:
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx25-pdk.dts
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright 2013 Freescale Semiconductor, Inc.
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
> +/include/ "imx25.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX25 Product Development Kit";
> +	compatible = "fsl,imx25-pdk", "fsl,imx25";
> +
> +	memory {
> +		reg = <0x80000000 0x4000000>;

Isn't imx25-pdk equipped with a 128 MB DDR?

> +	};
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&fec {
> +	status = "okay";
> +	phy-mode = "rmii";

Let the "status" be the last one.

Shawn

> +};
> +
> +&nfc {
> +	nand-on-flash-bbt;
> +	status = "okay";
> +};
> -- 
> 1.7.9.5
> 
> 
