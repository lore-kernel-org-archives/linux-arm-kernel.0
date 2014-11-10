From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Nov 2014 10:04:06 +0000
Subject: [PATCH 13/13] ARM: STi: DT: STih407: Add clk_ignore_unused to
 kernel bootargs
In-Reply-To: <1415361475-6218-14-git-send-email-peter.griffin@linaro.org>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
 <1415361475-6218-14-git-send-email-peter.griffin@linaro.org>
Message-ID: <20141110100406.GL21424@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 07 Nov 2014, Peter Griffin wrote:

> At the moment we don't take a reference on some core interconnect
> clocks which means when CCF turns off unused clocks the SoC will
> hang. As a temp soltuion we will boot with clk_ignore_unused
> parameter for all b2120 boards.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  arch/arm/boot/dts/stihxxx-b2120.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> index 862bb2f..7280b6d 100644
> --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
> +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> @@ -8,7 +8,7 @@
>   */
>  / {
>  	chosen {
> -		bootargs = "console=ttyAS0,115200";
> +		bootargs = "console=ttyAS0,115200 clk_ignore_unused";

Acked-by: Lee Jones <lee.jones@linaro.org>

Although, hopefully we won't require this for too much longer.

>  		linux,stdout-path = &sbc_serial0;
>  	};
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
