From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 05 Mar 2018 16:30:58 +0100
Subject: [PATCH v2 2/2] ARM: dts: imx51-zii-rdu1: Add node for RAVE SP
 device
In-Reply-To: <20180301192007.29278-2-andrew.smirnov@gmail.com>
References: <20180301192007.29278-1-andrew.smirnov@gmail.com>
 <20180301192007.29278-2-andrew.smirnov@gmail.com>
Message-ID: <1520263858.4095.10.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 01.03.2018, 11:20 -0800 schrieb Andrey Smirnov:
> With MFD and watchdog drivers for RAVE SP device support added by
> 538ee27290fa ("mfd: Add driver for RAVE Supervisory Processor") and
> c3bb33345721 ("watchdog: Add RAVE SP watchdog driver") add
> corresponding DT node for RDU.
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
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
> ?arch/arm/boot/dts/imx51-zii-rdu1.dts | 9 +++++++++
> ?1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index 5306b78de0ca..84ad5ceefecc 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -568,6 +568,15 @@
> ?	pinctrl-names = "default";
> ?	pinctrl-0 = <&pinctrl_uart3>;
> ?	status = "okay";
> +
> +	rave-sp {
> +		compatible = "zii,rave-sp-rdu1";
> +		current-speed = <38400>;
> +
> +		watchdog {
> +			compatible = "zii,rave-sp-watchdog";
> +		};
> +	};
> ?};
> ?
> ?&usbh1 {
