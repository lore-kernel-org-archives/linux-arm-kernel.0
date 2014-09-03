From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 03 Sep 2014 22:50:46 +0900
Subject: [PATCH] ARM: dts: exynos4x12: Fix pull setting in sd4_width8 pin
 group
In-Reply-To: <1409062405-15215-1-git-send-email-t.figa@samsung.com>
References: <1409062405-15215-1-git-send-email-t.figa@samsung.com>
Message-ID: <02ed01cfc77e$0fede790$2fc9b6b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> The group has the samsung,pin-pud property set to 4, which is not a
> correct value. This patch fixes this by replacing it with 3, which is
> the correct value for pull-up.
> 
Yes, I checked the value. You're right.

Will apply into fixes.

Thanks,
Kukjin

> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
> index 927fec6..c141931 100644
> --- a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
> @@ -691,7 +691,7 @@
>  		sd4_bus8: sd4-bus-width8 {
>  			samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-6";
>  			samsung,pin-function = <4>;
> -			samsung,pin-pud = <4>;
> +			samsung,pin-pud = <3>;
>  			samsung,pin-drv = <3>;
>  		};
> 
> --
> 2.0.4
