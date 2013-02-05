From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Feb 2013 15:45:53 +0800
Subject: [PATCH 1/1] arm: dts: imx6 fix fec ptp clock slow 10 time
In-Reply-To: <1360045266-4518-1-git-send-email-Frank.Li@freescale.com>
References: <1360045266-4518-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130205074551.GC16787@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 02:21:06PM +0800, Frank Li wrote:
> ptp should use enet_ref instead of pll6_enet
> pll6_enet is fixed 500Mhz.
> There are divider between enet_ref and pll6_enet
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Applied as a fix for 3.8.

Shawn

> ---
>  arch/arm/boot/dts/imx6q.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index d6265ca..ff1205e 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -866,7 +866,7 @@
>  				compatible = "fsl,imx6q-fec";
>  				reg = <0x02188000 0x4000>;
>  				interrupts = <0 118 0x04 0 119 0x04>;
> -				clocks = <&clks 117>, <&clks 117>, <&clks 177>;
> +				clocks = <&clks 117>, <&clks 117>, <&clks 190>;
>  				clock-names = "ipg", "ahb", "ptp";
>  				status = "disabled";
>  			};
> -- 
> 1.7.1
> 
> 
