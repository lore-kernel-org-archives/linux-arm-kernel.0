From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 Oct 2013 13:46:59 +0100
Subject: [PATCH 4/5 v2] ARM: ux500: fix I2C4 clock bit
In-Reply-To: <1382096630-23640-1-git-send-email-linus.walleij@linaro.org>
References: <1382096630-23640-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131018124659.GA19112@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Oct 2013, Linus Walleij wrote:

> The PCLK for I2C4 is controlled by bit 10 in the PCKEN registers
> while the KCLK is controlled by bit 9 on the KCKEN, it's
> one of these odd assymetric things. Correct the PCLK bit to 10.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Actually do what the commit says and update the PCLK to bit
>   10 instead of screwing with the KCLK. The KCLK was right all the time.
> ---
>  arch/arm/boot/dts/ste-dbx5x0.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> index 705bd0d..7da99fe 100644
> --- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
> @@ -694,7 +694,7 @@
>  
>  			clock-frequency = <400000>;
>  
> -			clocks = <&prcc_kclk 1 9>, <&prcc_pclk 1 9>;
> +			clocks = <&prcc_kclk 1 9>, <&prcc_pclk 1 10>;
>  			clock-names = "i2cclk", "apb_pclk";

Ah, much better:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
