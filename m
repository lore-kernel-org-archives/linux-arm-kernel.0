From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Feb 2018 14:31:33 +0800
Subject: [PATCH 1/2] ARM: dts: imx6: RDU2: Add RAVE SP device
In-Reply-To: <20180226144943.9835-1-andrew.smirnov@gmail.com>
References: <20180226144943.9835-1-andrew.smirnov@gmail.com>
Message-ID: <20180228063132.GI3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 06:49:41AM -0800, Andrey Smirnov wrote:
> With MFD and watchdog drivers for RAVE SP device support added by
> 538ee27290fa ("mfd: Add driver for RAVE Supervisory Processor") and
> c3bb33345721 ("watchdog: Add RAVE SP watchdog driver") add
> corresponding DT node for RDU2.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 72f52fcecee1..460931089509 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -305,6 +305,17 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart4>;
>  	status = "okay";
> +
> +	rave-sp {
> +		compatible = "zii,rave-sp-rdu2";
> +		current-speed = <1000000>;
> +		status = "okay";

The okay status is to flip the state of devices that are initially
disabled.  I think it's unnecessary for the case here.

> +
> +		watchdog {
> +			compatible = "zii,rave-sp-watchdog";
> +			status = "okay";

Ditto

Shawn

> +		};
> +	};
>  };
>  
>  &ecspi1 {
> -- 
> 2.14.3
> 
