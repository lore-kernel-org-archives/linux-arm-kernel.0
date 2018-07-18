From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 18 Jul 2018 16:34:48 +0100
Subject: [PATCH] arm64: dts: hikey960: Remove deprecated MMC properties
In-Reply-To: <20180618180825.21497-1-ryan@edited.us>
References: <20180618180825.21497-1-ryan@edited.us>
Message-ID: <5B4F5E18.60703@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

On 2018/6/18 19:08, Ryan Grachek wrote:
> Signed-off-by: Ryan Grachek <ryan@edited.us>

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 1 -
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 8 --------
>  2 files changed, 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index c706f70ce9f2..abc991619c75 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -611,7 +611,6 @@
>  	broken-cd;
>  	/* WL_EN */
>  	vmmc-supply = <&wlan_en>;
> -	ti,non-removable;
>  	non-removable;
>  	cap-power-off-card;
>  	keep-power-in-suspend;
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 484b837757f3..74c0509f99e9 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1121,7 +1121,6 @@
>  			bus-width = <0x4>;
>  			disable-wp;
>  			cap-sd-highspeed;
> -			supports-highspeed;
>  			card-detect-delay = <200>;
>  			reg = <0x0 0xff37f000 0x0 0x1000>;
>  			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1142,12 +1141,6 @@
>  			sd-uhs-sdr50;
>  			sd-uhs-sdr104;
>  			status = "disabled";
> -
> -			slot at 0 {
> -				reg = <0x0>;
> -				bus-width = <4>;
> -				disable-wp;
> -			};
>  		};
>  
>  		/* SDIO */
> @@ -1162,7 +1155,6 @@
>  			reset-names = "reset";
>  			card-detect-delay = <200>;
>  			cap-sd-highspeed;
> -			supports-highspeed;
>  			keep-power-in-suspend;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sdio_pmx_func
> 
