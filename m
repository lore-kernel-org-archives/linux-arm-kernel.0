From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 27 Jun 2017 21:28:56 +0200
Subject: [PATCH] arm64: dts: rockchip: fix typo in mmc pinctrl
In-Reply-To: <20170627061904.12128-1-klaus.goger@theobroma-systems.com>
References: <20170627061904.12128-1-klaus.goger@theobroma-systems.com>
Message-ID: <1623992.6iPIWFxdC5@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 27. Juni 2017, 08:19:03 CEST schrieb Klaus Goger:
> replace all occurrences of sdmcc with sdmmc in the rockchip devicetree
> files.
> 
> Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
> ---
> 
>  arch/arm/boot/dts/rk3036.dtsi                | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi     | 2 +-

please split arm32/arm64 changes, as they go through different branches
on their way to mainline.

Otherwise looks good
Heiko

>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
> index ec91325d3b6e..bc5942023889 100644
> --- a/arch/arm/boot/dts/rk3036.dtsi
> +++ b/arch/arm/boot/dts/rk3036.dtsi
> @@ -599,7 +599,7 @@
>  				rockchip,pins = <1 15 RK_FUNC_1 &pcfg_pull_default>;
>  			};
> 
> -			sdmmc_cd: sdmcc-cd {
> +			sdmmc_cd: sdmmc-cd {
>  				rockchip,pins = <1 17 RK_FUNC_1 &pcfg_pull_default>;
>  			};
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi index
> eb5059344023..eddc6eb31286 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -1031,7 +1031,7 @@ ap_i2c_audio: &i2c8 {
>  		 * hurt and dw_mmc will ignore it.  We make sure to disable
>  		 * the pull though so we don't burn needless power.
>  		 */
> -		sdmmc_cd: sdmcc-cd {
> +		sdmmc_cd: sdmmc-cd {
>  			rockchip,pins =
>  				<0 7 RK_FUNC_1 &pcfg_pull_none>;
>  		};
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index 69c56f7316c4..21f32c42d7db
> 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1786,7 +1786,7 @@
>  					<4 RK_PB5 RK_FUNC_1 &pcfg_pull_up>;
>  			};
> 
> -			sdmmc_cd: sdmcc-cd {
> +			sdmmc_cd: sdmmc-cd {
>  				rockchip,pins =
>  					<0 RK_PA7 RK_FUNC_1 &pcfg_pull_up>;
>  			};
