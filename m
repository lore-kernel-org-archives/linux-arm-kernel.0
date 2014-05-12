From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 12 May 2014 13:51:21 +0900
Subject: [PATCH v3 2/4] ARM: dts: enable dp-controller for exynos5250 based
 snow board
In-Reply-To: <1399630186-22610-3-git-send-email-rahul.sharma@samsung.com>
References: <1399630186-22610-1-git-send-email-rahul.sharma@samsung.com>
 <1399630186-22610-3-git-send-email-rahul.sharma@samsung.com>
Message-ID: <001601cf6d9d$d21bbd00$76533700$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 09, 2014 7:10 PM, Rahul Sharma wrote:
> 
> From: Rahul Sharma <Rahul.Sharma@samsung.com>
> 
> Enable dp-controller for snow board.
> 
> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
>  arch/arm/boot/dts/exynos5250-snow.dts |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index 796954c..7b10e32 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -207,6 +207,35 @@
>  		};
>  	};
> 
> +	dp-controller at 145B0000 {
> +		status = "okay";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&dp_hpd>;
> +		samsung,color-space = <0>;
> +		samsung,dynamic-range = <0>;
> +		samsung,ycbcr-coeff = <0>;
> +		samsung,color-depth = <1>;
> +		samsung,link-rate = <0x0a>;
> +		samsung,lane-count = <2>;
> +		samsung,hpd-gpio = <&gpx0 7 0>;
> +
> +		display-timings {
> +			native-mode = <&timing1>;
> +
> +			timing1: timing at 1 {
> +				clock-frequency = <70589280>;
> +				hactive = <1366>;
> +				vactive = <768>;
> +				hfront-porch = <40>;
> +				hback-porch = <40>;
> +				hsync-len = <32>;
> +				vback-porch = <10>;
> +				vfront-porch = <12>;
> +				vsync-len = <6>;
> +			};
> +		};
> +	};
> +
>  	fimd at 14400000 {
>  		status = "okay";
>  		samsung,invert-vclk;
> --
> 1.7.9.5
