From: caesar.upstream@gmail.com (Caesar Wang)
Date: Mon, 30 Nov 2015 22:00:41 +0800
Subject: [PATCH 2/2] ARM: dts: rockchip: override thermal settings on
 veyron-speedy
In-Reply-To: <2523702.pCcOIjvoVs@diego>
References: <2402718.WBE9iyTUZ2@diego> <2523702.pCcOIjvoVs@diego>
Message-ID: <565C5689.60208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

? 2015?11?30? 21:14, Heiko St?bner ??:
> According to a commit on the ChromeOS kernel, the temperature of the Speedy
> surface is over skin temperature spec. So adjust the thermal settings
> to mimic the ChromeOS tree to stay within these spec limits.
>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@collabora.com>
> ---
>   arch/arm/boot/dts/rk3288-veyron-speedy.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288-veyron-speedy.dts b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> index a7ea7d0..b34a7b5 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-speedy.dts
> @@ -88,6 +88,14 @@
>   	};
>   };
>   
> +&cpu_alert0 {
> +	temperature = <65000>;
> +};
> +
> +&cpu_alert1 {
> +	temperature = <70000>;
> +};
> +


Yep, as the mass of thermal data from OEM with all kinds of testing.
The 65/70 degree is very suit for speedy. (e.g.: Power, Performance).

So,  feel free add my tag: :-)

Reviewed-by: Caesar Wang <wxt@rock-chips.com>


>   &rk808 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pmic_int_l>;
