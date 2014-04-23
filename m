From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Thu, 24 Apr 2014 00:49:46 +0200
Subject: [PATCH 5/5] ARM: berlin/dt: add sdio clocks to BG2Q
In-Reply-To: <1398261667-12621-6-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398261667-12621-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1398261667-12621-6-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140423224946.GA12738@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexandre,

On Wed, Apr 23, 2014 at 04:01:07PM +0200, Alexandre Belloni wrote:
> Add sdio clocks to the berlin2q.dtsi
> Also reorder the syspll node
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/berlin2q.dtsi | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index 5925e6a16749..0fc826305614 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -102,13 +102,6 @@
>  			reg = <0xdd0170 0x8>;
>  		};
>  
> -		syspll: syspll at ea0030 {
> -			compatible = "marvell,berlin2q-pll";
> -			clocks = <&smclk>;
> -			#clock-cells = <0>;
> -			reg = <0xea0030 0x8>;
> -		};
> -
>  		apb at e80000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> @@ -191,6 +184,27 @@
>  			};
>  		};
>  
> +		syspll: syspll at ea0030 {
> +			compatible = "marvell,berlin2q-pll";
> +			clocks = <&smclk>;
> +			#clock-cells = <0>;
> +			reg = <0xea0030 0x8>;
> +		};
> +
> +		sdio0xinclk: sdio0xinclk at ea0158 {
> +			compatible = "marvell,berlin-clk";
> +			clocks = <&syspll>;
> +			#clock-cells = <0>;
> +			reg = <0xea0158 4>;

I believe you can use

			reg = <0xea0158 0x4>;

since you used an hex value in the previous node. Plus we tend to use
hex values elsewhere too.

> +		};
> +
> +		sdio1xinclk: sdio1xinclk at ea015c {
> +			compatible = "marvell,berlin-clk";
> +			clocks = <&syspll>;
> +			#clock-cells = <0>;
> +			reg = <0xea015c 4>;

Ditto. This also applies to BG2/BG2CD and the documentation patches.

Thanks!

Antoine

> +		};
> +
>  		apb at fc0000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
