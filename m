From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Apr 2013 16:33:48 -0700
Subject: [PATCH] ARM: dts: add pinctrl nodes for Exynos5250 SoC
In-Reply-To: <1355403978-388-1-git-send-email-thomas.abraham@linaro.org>
References: <1355403978-388-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20130424233348.GA6603@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 06:36:18PM +0530, Thomas Abraham wrote:
> Add pinctrl device nodes for Exynos5250 SoC.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Replying to an old email of a patch that has been merged because it seems
horribly broken.


> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 581e57a..eb8d610 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -18,6 +18,7 @@
>  */
>  
>  /include/ "skeleton.dtsi"
> +/include/ "exynos5250-pinctrl.dtsi"
>  
>  / {
>  	compatible = "samsung,exynos5250";
> @@ -48,6 +49,8 @@
>  		mshc1 = &dwmmc_1;
>  		mshc2 = &dwmmc_2;
>  		mshc3 = &dwmmc_3;
> +		pinctrl0 = &pinctrl_0;
> +		pinctrl3 = &pinctrl_3;
>  	};
>  
>  	gic:interrupt-controller at 10481000 {
> @@ -79,6 +82,24 @@
>  		interrupts = <0 42 0>;
>  	};
>  
> +	pinctrl_0: pinctrl at 11400000 {
> +		compatible = "samsung,pinctrl-exynos5250";
> +		reg = <0x11400000 0x1000>;
> +		interrupts = <0 46 0>;
> +
> +		wakup_eint: wakeup-interrupt-controller {
> +			compatible = "samsung,exynos4210-wakeup-eint";
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 32 0>;
> +		};

Typo, should be "wakeup_eint". And what happened to #interrupt-cells? And the
interrupt map?

Do you have an example of a tested user or a testcase for this? I'm
trying to get interrupts going on these pins, and it's not looking like
it's even close to working.


-Olof
