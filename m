From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 Jun 2013 21:58:47 +0900
Subject: [PATCH RESEND V2] ARM: dts: Correct the base address of pinctrl_3
 on Exynos5250
In-Reply-To: <1371025425-480-1-git-send-email-padma.v@samsung.com>
References: <1371025425-480-1-git-send-email-padma.v@samsung.com>
Message-ID: <1a1601ce6b5a$6833d8a0$389b89e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padmavathi Venna wrote:
> 
> This patch corrects the base address of pinctrl_3 on Exynos5250
> platform.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>

(+ Olof)

Olof, there is no other fixes in my tree for v3.10 yet, so would be helpful
if you could take this into fixes in arm-soc for v3.10. Just note, the wrong
address added during v3.10 merge window.

If you want,
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

If any problems, please kindly let me know.

Thanks,
- Kukjin

> ---
> Changes since V1:
> 	- Added platform name in the subject line.
> 
>  arch/arm/boot/dts/exynos5250-pinctrl.dtsi |    2 +-
>  arch/arm/boot/dts/exynos5250.dtsi         |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> index d1650fb..ded558b 100644
> --- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> @@ -763,7 +763,7 @@
>  		};
>  	};
> 
> -	pinctrl at 03680000 {
> +	pinctrl at 03860000 {
>  		gpz: gpz {
>  			gpio-controller;
>  			#gpio-cells = <2>;
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> index 7154e3d..e9bfd13 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -169,9 +169,9 @@
>  		interrupts = <0 50 0>;
>  	};
> 
> -	pinctrl_3: pinctrl at 03680000 {
> +	pinctrl_3: pinctrl at 03860000 {
>  		compatible = "samsung,exynos5250-pinctrl";
> -		reg = <0x0368000 0x1000>;
> +		reg = <0x03860000 0x1000>;
>  		interrupts = <0 47 0>;
>  	};
> 
> --
> 1.7.4.4
