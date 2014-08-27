From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 27 Aug 2014 23:44:56 +0200
Subject: [PATCH 1/2] ARM: dts: rockchip: add hym8563 rtc to Radxa Rock
 board
In-Reply-To: <2306550.nl6CA81PdX@phil>
References: <2306550.nl6CA81PdX@phil>
Message-ID: <6745529.KGldgCPX1B@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 20. August 2014, 21:07:22 schrieb Heiko St?bner:
> The Radxa Rock uses a hym8563 as rtc. Add the i2c device and necessary
> pinconfig for the interrupt pin - labeled rtc_int in the schematics.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Added both patches to my v3.18-next/dts branch.


> ---
> if nobody complains I'll queue this into my v3.18-next/dts branch
> 
>  arch/arm/boot/dts/rk3188-radxarock.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts
> b/arch/arm/boot/dts/rk3188-radxarock.dts index ef72faf..ff35acfa 100644
> --- a/arch/arm/boot/dts/rk3188-radxarock.dts
> +++ b/arch/arm/boot/dts/rk3188-radxarock.dts
> @@ -80,6 +80,17 @@
>  	status = "okay";
>  	clock-frequency = <400000>;
> 
> +	rtc at 51 {
> +		compatible = "haoyu,hym8563";
> +		reg = <0x51>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&rtc_int>;
> +		#clock-cells = <0>;
> +		clock-output-names = "xin32k";
> +	};
> +
>  	act8846: act8846 at 5a {
>  		compatible = "active-semi,act8846";
>  		reg = <0x5a>;
> @@ -196,6 +207,12 @@
>  		};
>  	};
> 
> +	hym8563 {
> +		rtc_int: rtc-int {
> +			rockchip,pins = <RK_GPIO0 0 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
>  	ir-receiver {
>  		ir_recv_pin: ir-recv-pin {
>  			rockchip,pins = <RK_GPIO0 10 RK_FUNC_GPIO &pcfg_pull_none>;
