From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 18 Jul 2018 16:33:25 +0100
Subject: [PATCH] arm64: dts: hikey960: Remove keep-power-in-suspend
 property
In-Reply-To: <20180713155348.24343-1-ryan@edited.us>
References: <20180713155348.24343-1-ryan@edited.us>
Message-ID: <5B4F5DC4.5010500@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ryan,

On 2018/7/13 16:53, Ryan Grachek wrote:
> Remove the keep-power-in-suspend property because it keeps wifi power
> on during suspend. This property is only required when enabling WoWLAN
> and should only be enabled based on need. Also remove dupplicate property
> 
> Signed-off-by: Ryan Grachek <ryan@edited.us>

Thanks!
Applied to the hisilicon dt tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 1 -
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi         | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index 68c5a6c819ae..a927ce4ec40b 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -586,7 +586,6 @@
>  	ti,non-removable;
>  	non-removable;
>  	cap-power-off-card;
> -	keep-power-in-suspend;
>  	#address-cells = <0x1>;
>  	#size-cells = <0x0>;
>  	status = "ok";
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 8d477dcbfa58..4588fe4e00a8 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1050,7 +1050,6 @@
>  			reset-names = "reset";
>  			card-detect-delay = <200>;
>  			supports-highspeed;
> -			keep-power-in-suspend;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&sdio_pmx_func
>  				     &sdio_clk_cfg_func
> 
