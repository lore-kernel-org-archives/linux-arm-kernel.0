From: sasukewxt@163.com (Caesar Wang)
Date: Thu, 19 Nov 2015 17:42:59 +0800
Subject: [PATCH] ARM: dts: rockchip: temporarily remove emmc hs200 speed
 from rk3288 minnie
In-Reply-To: <1816392.5rIXY9jxRH@phil>
References: <1816392.5rIXY9jxRH@phil>
Message-ID: <564D99A3.6050009@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

What are the problems?
I'm interesting that .....:-)

? 2015?11?19? 14:56, Heiko Stuebner ??:
> The eMMC of the minnie Chromebook doesn't like our current method of
> tuning and while there are solutions on the horizon, they still need
Hang?  That's seem normal booting up with my hand minnie board.

> investigating. Other Chromebooks tune just fine with the emmc, so
> simply disable tuning on Minnie for now.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> Already in my fixes branch, but posted for completenes sake
>
>   arch/arm/boot/dts/rk3288-veyron-minnie.dts | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> index 8fd8ef2..85f0373 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> @@ -86,6 +86,10 @@
>   	};
>   };
>   
> +&emmc {
> +	/delete-property/mmc-hs200-1_8v;
> +};
> +
>   &gpio_keys {
>   	pinctrl-0 = <&pwr_key_l &ap_lid_int_l &volum_down_l &volum_up_l>;
>   
