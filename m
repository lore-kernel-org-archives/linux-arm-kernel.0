From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Wed, 05 Jul 2017 11:26:00 +0900
Subject: [PATCH] ARM: dts: exynos: remove num-slots from exynos platforms
In-Reply-To: <1499160322-73008-1-git-send-email-shawn.lin@rock-chips.com>
References: <CGME20170704092541epcas1p31ec29f6e6258810fcbbc1f512d68c005@epcas1p3.samsung.com>
 <1499160322-73008-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <e5d52fd9-6a2e-cba6-8098-f3d3ea1e6980@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2017 06:25 PM, Shawn Lin wrote:
> dwmmc driver deprecated num-slots and plan to get rid
> of it finally. Just move a step to cleanup it from DT.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

> ---
> 
>  arch/arm/boot/dts/exynos3250-artik5-eval.dts    | 1 -
>  arch/arm/boot/dts/exynos3250-artik5.dtsi        | 1 -
>  arch/arm/boot/dts/exynos3250-monk.dts           | 1 -
>  arch/arm/boot/dts/exynos3250-rinato.dts         | 1 -
>  arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 1 -
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 1 -
>  arch/arm/boot/dts/exynos4412-origen.dts         | 1 -
>  arch/arm/boot/dts/exynos4412-trats2.dts         | 1 -
>  arch/arm/boot/dts/exynos5250-arndale.dts        | 2 --
>  arch/arm/boot/dts/exynos5250-smdk5250.dts       | 2 --
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi   | 3 ---
>  arch/arm/boot/dts/exynos5250-spring.dts         | 2 --
>  arch/arm/boot/dts/exynos5260-xyref5260.dts      | 2 --
>  arch/arm/boot/dts/exynos5410-smdk5410.dts       | 2 --
>  arch/arm/boot/dts/exynos5420-peach-pit.dts      | 3 ---
>  arch/arm/boot/dts/exynos5800-peach-pi.dts       | 3 ---
>  16 files changed, 27 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos3250-artik5-eval.dts b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
> index 4bd2ee8..4cbfa09 100644
> --- a/arch/arm/boot/dts/exynos3250-artik5-eval.dts
> +++ b/arch/arm/boot/dts/exynos3250-artik5-eval.dts
> @@ -22,7 +22,6 @@
>  };
>  
>  &mshc_2 {
> -	num-slots = <1>;
>  	cap-sd-highspeed;
>  	disable-wp;
>  	vqmmc-supply = <&ldo3_reg>;
> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> index 59c89d7..639c2e6 100644
> --- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> @@ -304,7 +304,6 @@
>  };
>  
>  &mshc_0 {
> -	num-slots = <1>;
>  	non-removable;
>  	cap-mmc-highspeed;
>  	card-detect-delay = <200>;
> diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
> index accee81..bbdfcbc 100644
> --- a/arch/arm/boot/dts/exynos3250-monk.dts
> +++ b/arch/arm/boot/dts/exynos3250-monk.dts
> @@ -426,7 +426,6 @@
>  &mshc_0 {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
> -	num-slots = <1>;
>  	broken-cd;
>  	non-removable;
>  	cap-mmc-highspeed;
> diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
> index 443e0c9..b43e99d 100644
> --- a/arch/arm/boot/dts/exynos3250-rinato.dts
> +++ b/arch/arm/boot/dts/exynos3250-rinato.dts
> @@ -642,7 +642,6 @@
>  &mshc_0 {
>  	#address-cells = <1>;
>  	#size-cells = <0>;
> -	num-slots = <1>;
>  	broken-cd;
>  	non-removable;
>  	cap-mmc-highspeed;
> diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> index 4cd6248..14ce2c6 100644
> --- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> @@ -466,7 +466,6 @@
>  	pinctrl-names = "default";
>  	status = "okay";
>  	vmmc-supply = <&buck9_reg>;
> -	num-slots = <1>;
>  	broken-cd;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index 219d587..102acd7 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -516,7 +516,6 @@
>  	mmc-pwrseq = <&emmc_pwrseq>;
>  	status = "okay";
>  
> -	num-slots = <1>;
>  	broken-cd;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
> diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
> index 7a83e2d..8a89eb8 100644
> --- a/arch/arm/boot/dts/exynos4412-origen.dts
> +++ b/arch/arm/boot/dts/exynos4412-origen.dts
> @@ -488,7 +488,6 @@
>  	pinctrl-names = "default";
>  	status = "okay";
>  
> -	num-slots = <1>;
>  	broken-cd;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index 35e9b94..fc81da4 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -901,7 +901,6 @@
>  };
>  
>  &mshc_0 {
> -	num-slots = <1>;
>  	broken-cd;
>  	non-removable;
>  	card-detect-delay = <200>;
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 6a43246..18a7f39 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -518,7 +518,6 @@
>  
>  &mmc_0 {
>  	status = "okay";
> -	num-slots = <1>;
>  	broken-cd;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
> @@ -533,7 +532,6 @@
>  
>  &mmc_2 {
>  	status = "okay";
> -	num-slots = <1>;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
>  	samsung,dw-mshc-sdr-timing = <2 3>;
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 6632f65..062cba4 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -346,7 +346,6 @@
>  
>  &mmc_0 {
>  	status = "okay";
> -	num-slots = <1>;
>  	broken-cd;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
> @@ -360,7 +359,6 @@
>  
>  &mmc_2 {
>  	status = "okay";
> -	num-slots = <1>;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
>  	samsung,dw-mshc-sdr-timing = <2 3>;
> diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> index e1d293db..8788880 100644
> --- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
> @@ -530,7 +530,6 @@
>  /* eMMC flash */
>  &mmc_0 {
>  	status = "okay";
> -	num-slots = <1>;
>  	non-removable;
>  	samsung,dw-mshc-ciu-div = <3>;
>  	samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -544,7 +543,6 @@
>  /* uSD card */
>  &mmc_2 {
>  	status = "okay";
> -	num-slots = <1>;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
>  	samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -564,7 +562,6 @@
>   */
>  &mmc_3 {
>  	status = "okay";
> -	num-slots = <1>;
>  	non-removable;
>  	cap-sdio-irq;
>  	keep-power-in-suspend;
> diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
> index 95c3bca..d53bfcb 100644
> --- a/arch/arm/boot/dts/exynos5250-spring.dts
> +++ b/arch/arm/boot/dts/exynos5250-spring.dts
> @@ -427,7 +427,6 @@
>  
>  &mmc_0 {
>  	status = "okay";
> -	num-slots = <1>;
>  	broken-cd;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
> @@ -445,7 +444,6 @@
>   */
>  &mmc_1 {
>  	status = "okay";
> -	num-slots = <1>;
>  	broken-cd;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
> diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
> index d0cc300..73b7cdd 100644
> --- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
> +++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
> @@ -67,7 +67,6 @@
>  
>  &mmc_0 {
>  	status = "okay";
> -	num-slots = <1>;
>  	broken-cd;
>  	bypass-smu;
>  	cap-mmc-highspeed;
> @@ -83,7 +82,6 @@
>  
>  &mmc_2 {
>  	status = "okay";
> -	num-slots = <1>;
>  	cap-sd-highspeed;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
> diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> index 6cc74d9..9cb7726 100644
> --- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
> +++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> @@ -41,7 +41,6 @@
>  
>  &mmc_0 {
>  	status = "okay";
> -	num-slots = <1>;
>  	cap-mmc-highspeed;
>  	broken-cd;
>  	card-detect-delay = <200>;
> @@ -53,7 +52,6 @@
>  
>  &mmc_2 {
>  	status = "okay";
> -	num-slots = <1>;
>  	cap-sd-highspeed;
>  	card-detect-delay = <200>;
>  	samsung,dw-mshc-ciu-div = <3>;
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index f9a75bf..683a4cf 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -699,7 +699,6 @@
>  /* eMMC flash */
>  &mmc_0 {
>  	status = "okay";
> -	num-slots = <1>;
>  	mmc-hs200-1_8v;
>  	cap-mmc-highspeed;
>  	non-removable;
> @@ -717,7 +716,6 @@
>  /* WiFi SDIO module */
>  &mmc_1 {
>  	status = "okay";
> -	num-slots = <1>;
>  	non-removable;
>  	cap-sdio-irq;
>  	keep-power-in-suspend;
> @@ -737,7 +735,6 @@
>  /* uSD card */
>  &mmc_2 {
>  	status = "okay";
> -	num-slots = <1>;
>  	cap-sd-highspeed;
>  	card-detect-delay = <200>;
>  	clock-frequency = <400000000>;
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 953dc86..b2b95ff 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -667,7 +667,6 @@
>  /* eMMC flash */
>  &mmc_0 {
>  	status = "okay";
> -	num-slots = <1>;
>  	mmc-hs200-1_8v;
>  	mmc-hs400-1_8v;
>  	cap-mmc-highspeed;
> @@ -686,7 +685,6 @@
>  /* WiFi SDIO module */
>  &mmc_1 {
>  	status = "okay";
> -	num-slots = <1>;
>  	non-removable;
>  	cap-sdio-irq;
>  	keep-power-in-suspend;
> @@ -706,7 +704,6 @@
>  /* uSD card */
>  &mmc_2 {
>  	status = "okay";
> -	num-slots = <1>;
>  	cap-sd-highspeed;
>  	card-detect-delay = <200>;
>  	clock-frequency = <400000000>;
> 
