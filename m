From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Nov 2013 23:16:01 +0800
Subject: [PATCHv8][ 3/5] ARM: dts: Add support for the i.MX35.
In-Reply-To: <1384255459-15134-3-git-send-email-denis@eukrea.com>
References: <1384255459-15134-1-git-send-email-denis@eukrea.com>
 <1384255459-15134-3-git-send-email-denis@eukrea.com>
Message-ID: <20131113151559.GC17816@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 12:24:17PM +0100, Denis Carikli wrote:
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx35.dtsi
> @@ -0,0 +1,312 @@
> +/*
> + * Copyright 2012 Steffen Trumtrar, Pengutronix
> + *
> + * based on imx27.dtsi
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation.
> + */
> +
> +#include "skeleton.dtsi"
> +#include "imx35-pinfunc.h"
> +#include "imx35-pingrp.h"
> +
> +/ {
> +	aliases {
> +		gpio0 = &gpio1;
> +		gpio1 = &gpio2;
> +		gpio2 = &gpio3;
> +		serial0 = &uart1;
> +		serial1 = &uart2;
> +		serial2 = &uart3;
> +	};
> +
> +	avic: avic-interrupt-controller at 68000000 {
> +		compatible = "fsl,imx35-avic", "fsl,avic";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x68000000 0x10000000>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ckil {
> +			compatible = "fsl,imx-ckil", "fixed-clock";
> +			clock-frequency = <32768>;
> +		};
> +
> +		osc {
> +			compatible = "fsl,imx-osc", "fixed-clock";
> +			clock-frequency = <24000000>;
> +		};
> +	};

Are these clocks available for imx35?  If not, please remove them.

Shawn
