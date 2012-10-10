From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 10 Oct 2012 21:04:37 +0200
Subject: [PATCH 5/6] ARM: ux500: Enable SDI4 port on the u9540 when
 booting with Device Tree
In-Reply-To: <1349882335-6786-6-git-send-email-lee.jones@linaro.org>
References: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
 <1349882335-6786-6-git-send-email-lee.jones@linaro.org>
Message-ID: <20121010190437.GU12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:18 Wed 10 Oct     , Lee Jones wrote:
> Here we add the device node for the SDI4 (MMC) port to the u9540
> Device Tree source file. This will allow successful probing of
> the internal MMC storage device when booting with DT enabled.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/u9540.dts |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/u9540.dts b/arch/arm/boot/dts/u9540.dts
> index 28efe20..2dade76 100644
> --- a/arch/arm/boot/dts/u9540.dts
> +++ b/arch/arm/boot/dts/u9540.dts
> @@ -21,7 +21,6 @@
>  	};
>  
>  	soc-u9500 {
> -
why?
>  		uart at 80120000 {
>  			status = "okay";
>  		};
> @@ -33,5 +32,16 @@
>  		uart at 80007000 {
>  			status = "okay";
>  		};
> +
> +		// On-board eMMC
no c++ comment
> +		sdi4_per2 at 80114000 {
> +			arm,primecell-periphid = <0x10480180>;
> +		        max-frequency = <50000000>;
> +			bus-width = <8>;
> +			mmc-cap-mmc-highspeed;
> +			vmmc-supply = <&ab8500_ldo_aux2_reg>;
you need add the pinctrl here

Best Regards,
J.
