From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Oct 2013 12:08:49 +0100
Subject: [PATCH 1/5] ARM: ux500: fix clock for GPIO block 8
In-Reply-To: <1382087060-31584-1-git-send-email-linus.walleij@linaro.org>
References: <1382087060-31584-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131018110849.GZ19112@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013, Linus Walleij wrote:

> The clock assignment in the device tree for GPIO block 8 was
> incorrect, indicating this was managed by bit 1 on PRCC 6
> while it was in fact bit 1 on PRCC 5.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/ste-dbx5x0.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> index 2ef30c1..55abf12 100644
> --- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> @@ -227,7 +227,7 @@
>  			#gpio-cells = <2>;
>  			gpio-bank = <8>;
>  
> -			clocks = <&prcc_pclk 6 1>;
> +			clocks = <&prcc_pclk 5 1>;
>  		};
>  
>  		pinctrl {

Nice one: Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
