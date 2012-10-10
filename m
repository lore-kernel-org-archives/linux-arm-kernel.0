From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 10 Oct 2012 21:03:25 +0200
Subject: [PATCH 4/6] ARM: ux500: Add UART support to the u9540 Device Tree
In-Reply-To: <1349882335-6786-5-git-send-email-lee.jones@linaro.org>
References: <1349882335-6786-1-git-send-email-lee.jones@linaro.org>
 <1349882335-6786-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20121010190325.GT12801@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:18 Wed 10 Oct     , Lee Jones wrote:
> Add the 3 UART nodes required to enable serial ports on the u9540.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/u9540.dts |   13 ++++++++++++-
dts? it's dtsi

it's the soc not the board
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/u9540.dts b/arch/arm/boot/dts/u9540.dts
> index 0a66f34..28efe20 100644
> --- a/arch/arm/boot/dts/u9540.dts
> +++ b/arch/arm/boot/dts/u9540.dts
> @@ -21,6 +21,17 @@
>  	};
>  
>  	soc-u9500 {
> -	};
>  
> +		uart at 80120000 {
> +			status = "okay";
> +		};
> +
> +		uart at 80121000 {
> +			status = "okay";
> +		};
> +
> +		uart at 80007000 {
> +			status = "okay";
> +		};
do not enable device by default in the soc

Best Regards,
J.
> +	};
>  };
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
