From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 01 Oct 2014 12:11:10 +0200
Subject: [PATCH 2/2] ARM: i.MX53: dts: add sahara module
In-Reply-To: <1412157931-32752-2-git-send-email-s.trumtrar@pengutronix.de>
References: <1412157931-32752-1-git-send-email-s.trumtrar@pengutronix.de>
 <1412157931-32752-2-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1412158270.3432.2.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-10-01 at 12:05 +0200, Steffen Trumtrar wrote:
> The i.MX53 has a SAHARA v4 core. Add it to the dtsi.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 76948d79f707..a4890c10465a 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -765,6 +765,16 @@
>  				resets = <&src 1>;
>  				iram = <&ocram>;
>  			};
> +
> +			sahara: crypto at 63ff8000 {
> +				compatible = "fsl,imx53-sahara";
> +				reg = <0x63ff8000 0x4000>;
> +				interrupts = <19 20>;
> +				clocks = <&clks IMX5_CLK_SAHARA_IPG_GATE>,
> +				         <&clks IMX5_CLK_SAHARA_IPG_GATE>;
> +				clock-names = "ipg", "ahb";
> +				status = "disabled";

Uhm why is this node disabled? I thought the sahara block is fully
self-contained and has no external dependencies. In that case it should
be always enabled, right?

> +			};
>  		};
>  
>  		ocram: sram at f8000000 {

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
