From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Mon, 6 Mar 2017 09:38:51 +0100
Subject: [PATCH v4 2/5] arm: dts: Add the burst and esc clock frequency
 properties to DSI node
In-Reply-To: <1488775343-6236-3-git-send-email-hoegeun.kwon@samsung.com>
References: <1488775343-6236-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170306044234epcas1p22e9481182e11330cea0d169ce0ad2666@epcas1p2.samsung.com>
 <1488775343-6236-3-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170306093851.3870ab29@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 06 Mar 2017 13:42:20 +0900 Hoegeun Kwon wrote:
> The OF graph is not needed because the panel is a child of dsi. Add
>
This is obviously from your patch #5 and doesn't make sense in this
context.

> the burst and esc clock frequency properties to the parent (DSI node).
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  arch/arm/boot/dts/exynos3250-rinato.dts | 2 ++
>  arch/arm/boot/dts/exynos4210-trats.dts  | 2 ++
>  arch/arm/boot/dts/exynos4412-trats2.dts | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
> index 548413e..c9f191c 100644
> --- a/arch/arm/boot/dts/exynos3250-rinato.dts
> +++ b/arch/arm/boot/dts/exynos3250-rinato.dts
> @@ -215,6 +215,8 @@
>  &dsi_0 {
>  	vddcore-supply = <&ldo6_reg>;
>  	vddio-supply = <&ldo6_reg>;
> +	samsung,burst-clock-frequency = <250000000>;
> +	samsung,esc-clock-frequency = <20000000>;
>  	samsung,pll-clock-frequency = <24000000>;
>  	status = "okay";
>  
> diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
> index 0ca1b4d..1743ca8 100644
> --- a/arch/arm/boot/dts/exynos4210-trats.dts
> +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> @@ -197,6 +197,8 @@
>  &dsi_0 {
>  	vddcore-supply = <&vusb_reg>;
>  	vddio-supply = <&vmipi_reg>;
> +	samsung,burst-clock-frequency = <500000000>;
> +	samsung,esc-clock-frequency = <20000000>;
>  	samsung,pll-clock-frequency = <24000000>;
>  	status = "okay";
>  
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index 41ecd6d..82221a0 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -385,6 +385,8 @@
>  &dsi_0 {
>  	vddcore-supply = <&ldo8_reg>;
>  	vddio-supply = <&ldo10_reg>;
> +	samsung,burst-clock-frequency = <500000000>;
> +	samsung,esc-clock-frequency = <20000000>;
>  	samsung,pll-clock-frequency = <24000000>;
>  	status = "okay";
>  


Lothar Wa?mann
