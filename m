From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 3 May 2017 16:30:17 +0800
Subject: [PATCH v2 7/7] ARM: dts: imx7d-sdb: Enable PCIe peripheral
In-Reply-To: <20170418150133.31679-8-andrew.smirnov@gmail.com>
References: <20170418150133.31679-1-andrew.smirnov@gmail.com>
 <20170418150133.31679-8-andrew.smirnov@gmail.com>
Message-ID: <20170503083015.GE18578@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 18, 2017 at 08:01:33AM -0700, Andrey Smirnov wrote:
> Enable PCIe peripheral on this board.
> 
> Cc: yurovsky at gmail.com
> Cc: Dong Aisheng <aisheng.dong@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/boot/dts/imx7d-sdb.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index d6f2dda..65dda66 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -349,6 +349,12 @@
>  	};
>  };
>  
> +&pcie {
> +	pinctrl-names = "default";

No corresponding pinctrl-0 entry?  In that case, there is no point to
have pinctrl-names.

Shawn

> +	reset-gpio = <&extended_io 1 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
>  &pwm1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_pwm1>;
> -- 
> 2.9.3
> 
