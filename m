From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Wed, 30 Jul 2014 14:33:29 +0200
Subject: [PATCHv7 2/5] ARM: dts: exynos: unuse the slot-node and deprecated
 the supports-highspeed for dw-mmc
In-Reply-To: <1406514579-3769-3-git-send-email-jh80.chung@samsung.com>
References: <1406514579-3769-1-git-send-email-jh80.chung@samsung.com>
 <1406514579-3769-3-git-send-email-jh80.chung@samsung.com>
Message-ID: <53D8E619.90601@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 28.07.2014 04:29, schrieb Jaehoon Chung:
> dw-mmc controller can support multiple slots.
> But, there are no use-cases anywhere. So we don't need to support the
> slot-node for dw-mmc controller.
> And "supports-highspeed" property in dw-mmc is deprecated.
> "supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".

s/replaced to/replaced with/

> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Tushar Behera <trblinux@gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-odroidx.dts      |    8 ++------
>  arch/arm/boot/dts/exynos4412-origen.dts       |    8 ++------
>  arch/arm/boot/dts/exynos4412-trats2.dts       |    8 ++------
>  arch/arm/boot/dts/exynos5250-arndale.dts      |   18 +++++------------
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi |   26 +++++++------------------
>  arch/arm/boot/dts/exynos5250-smdk5250.dts     |   18 +++++------------
>  arch/arm/boot/dts/exynos5250-snow.dts         |    6 ++----
>  arch/arm/boot/dts/exynos5260-xyref5260.dts    |   18 +++++------------
>  arch/arm/boot/dts/exynos5410-smdk5410.dts     |   18 +++++------------
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts |   16 ++++-----------
>  arch/arm/boot/dts/exynos5420-peach-pit.dts    |   16 ++++-----------
>  arch/arm/boot/dts/exynos5420-smdk5420.dts     |   16 ++++-----------
>  arch/arm/boot/dts/exynos5800-peach-pi.dts     |   16 ++++-----------
>  13 files changed, 51 insertions(+), 141 deletions(-)
[...]
> diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> index 89ac90f..af51361 100644
> --- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> @@ -248,7 +248,6 @@
>  
>  	mmc at 12200000 {
>  		num-slots = <1>;
> -		supports-highspeed;
>  		broken-cd;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
> @@ -256,44 +255,33 @@
>  		samsung,dw-mshc-ddr-timing = <1 2>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
> -
> -		slot at 0 {
> -			reg = <0>;
> -			bus-width = <8>;
> -		};
> +		bus-width = <8>;
> +		cap-mmc-highspeed;
>  	};
>  
>  	mmc at 12220000 {
>  		num-slots = <1>;
> -		supports-highspeed;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
>  		samsung,dw-mshc-ddr-timing = <1 2>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> -
> -		slot at 0 {
> -			reg = <0>;
> -			bus-width = <4>;
> -			wp-gpios = <&gpc2 1 0>;
> -		};
> +		bus-width = <4>;
> +		wp-gpios = <&gpc2 1 0>;
> +		cap-sd-highspeed;
>  	};
>  
>  	mmc at 12230000 {
>  		num-slots = <1>;
> -		supports-highspeed;
>  		broken-cd;
>  		card-detect-delay = <200>;
>  		samsung,dw-mshc-ciu-div = <3>;
>  		samsung,dw-mshc-sdr-timing = <2 3>;
>  		samsung,dw-mshc-ddr-timing = <1 2>;
>  		/* See board-specific dts files for pin setup */
> -
> -		slot at 0 {
> -			reg = <0>;
> -			bus-width = <4>;
> -		};
> +		bus-width = <4>;
> +		cap-sd-highspeed;
>  	};
>  
>  	spi_1: spi at 12d30000 {
[...]
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index 079fdf9..17d8f53 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -329,10 +329,8 @@
>  	 */
>  	mmc at 12230000 {
>  		status = "okay";
> -		slot at 0 {
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
> -		};
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
>  	};
>  
>  	i2c at 12CD0000 {

Since you said you are targeting 3.16 still, FYI Doug asked me to do the
same change for 3.17 in my Spring series for correctness reasons. So we
shouldn't have merge conflict there.

However, we are also dropping exynos5250-cros-common.dtsi, so at some
point the above changes will need to be merged into -snow.dts as
conflict resolution.

[...]
> diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> index 7275bbd..be3e025 100644
> --- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
> +++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> @@ -40,33 +40,25 @@
>  &mmc_0 {
>  	status = "okay";
>  	num-slots = <1>;
> -	supports-highspeed;
> +	cap-mmc-highspeed;
>  	broken-cd;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
>  	samsung,dw-mshc-sdr-timing = <2 3>;
>  	samsung,dw-mshc-ddr-timing = <1 2>;
> -
> -	slot at 0 {
> -		reg = <0>;
> -		bus-width = <8>;
> -	};
> +	bus-width = <8>;
>  };
>  
>  &mmc_2 {
>  	status = "okay";
>  	num-slots = <1>;
> -	supports-highspeed;
> +	cap-sd-highspeed;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
>  	samsung,dw-mshc-sdr-timing = <2 3>;
>  	samsung,dw-mshc-ddr-timing = <1 2>;
> -
> -	slot at 0 {
> -		reg = <0>;
> -		bus-width = <4>;
> -		disable-wp;
> -	};
> +	bus-width = <4>;
> +	disable-wp;
>  };
>  
>  &uart0 {

Similarly here, I am adding an exynos5410-odroidxu.dts file that will
need to get the same changes as -smdk5410.dts then.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
