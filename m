From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 24 Mar 2017 14:12:50 +0800
Subject: [PATCH v3] ARM: dts: imx6: add ZII RDU2 boards
In-Reply-To: <20170323142429.8835-1-l.stach@pengutronix.de>
References: <20170323142429.8835-1-l.stach@pengutronix.de>
Message-ID: <20170324061249.GI30608@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 03:24:29PM +0100, Lucas Stach wrote:
> This adds support for the Zodiac Inflight Innovations RDU2 board,
> which has both a Quad and a QuadPlus variant.
> 
> The board supports different panels, with the bootloader patching
> in the correct compatible, depending on the hardware configuration.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Tested-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Tested-by: Chris Healy <cphealy@gmail.com>

I applied it with a couple of small fix-up below.

<snip>

> +&sata {
> +	status = "okay";
> +	target-supply = <&reg_3p3v_ssd>;

To keep it consistency with other nodes, I switched these two lines.

> +};

<snip>

> +&iomuxc {
> +	pinctrl-names = "default";

There is no point to have this when we do not have pinctrl-0 thing, so I
dropped it.

Shawn

> +
> +	pinctrl_accel: accelgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_SD1_CMD__GPIO1_IO18		0x4001b000
> +			MX6QDL_PAD_SD1_CLK__GPIO1_IO20		0x4001b000
> +		>;
> +	};
