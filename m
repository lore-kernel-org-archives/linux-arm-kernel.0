From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 18 Jun 2011 18:21:46 +0200
Subject: [PATCH 1/3] serial/imx: add device tree support
In-Reply-To: <1308410354-21387-2-git-send-email-shawn.guo@linaro.org>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <201106181821.46574.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 18 June 2011 17:19:12 Shawn Guo wrote:
>
> +Required properties:
> +- compatible : should be "fsl,<soc>-uart", "fsl,imx-uart"
> +- reg : address and length of the register set for the device
> +- interrupts : should contain uart interrupt
> +- id : should be the port ID defined by soc
> +
> +Optional properties:
> +- fsl,has-rts-cts : indicate it has rts-cts
> +- fsl,irda-mode : support irda mode
> +
> +Example:
> +
> +uart at 73fbc000 {
> +	compatible = "fsl,imx51-uart", "fsl,imx-uart";
> +	reg = <0x73fbc000 0x4000>;
> +	interrupts = <31>;
> +	id = <1>;
> +	fsl,has-rts-cts;
> +};

Should this also support the "clock-frequency" property that 8250-style
serial ports support [1]?

For the flow-control properties, should we name that more generic? The
same property certainly makes sense for other serial-ports if it does
here. OTOH, I'm not sure it's actually reliable, because it also depends
on whether the other side of the connection and the cable support hw flow
control.


	Arnd

[1] http://playground.sun.com/1275/bindings/devices/html/serial-1_0d.html#HDR9
