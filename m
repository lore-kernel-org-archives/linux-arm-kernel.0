From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 30 Nov 2016 17:36:03 +0900
Subject: [PATCH v2] arm64: dts: exynos: Add flash led dt node for TM2 board
In-Reply-To: <1480481337-3941-1-git-send-email-sw0312.kim@samsung.com>
References: <1480480062-3472-1-git-send-email-sw0312.kim@samsung.com>
 <CGME20161130045045epcas1p330bd83a82261c43e36c5519e3d5ed2d0@epcas1p3.samsung.com>
 <1480481337-3941-1-git-send-email-sw0312.kim@samsung.com>
Message-ID: <583E8F73.2060804@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Seung-Woo,

I think that this patch looks good to me.
But, When I tested this patch on my TM2 board,
the flash turn off after some millisecond automatically.

It is strange situation. Unfortunately, I don't know the cause.
I think that we better to check this issue for more time.

Best Regards,
Chanwoo Choi

On 2016? 11? 30? 13:48, Seung-Woo Kim wrote:
> From: Ingi Kim <ingi2.kim@samsung.com>
> 
> This patch adds Kinetic ktd2692 flash led device node for TM2 board.
> 
> Signed-off-by: Ingi Kim <ingi2.kim@samsung.com>
> Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
> ---
> Change from v1:
> - gpio active value is set with defined macro instead of value.
> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2.dts |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> index f21bdc2..0d454aa 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
> @@ -58,6 +58,19 @@
>  		reg = <0x0 0x20000000 0x0 0xc0000000>;
>  	};
>  
> +	camera-flash {
> +		compatible = "kinetic,ktd2692";
> +		ctrl-gpios = <&gpc0 1 GPIO_ACTIVE_HIGH>;
> +		aux-gpios = <&gpc0 2 GPIO_ACTIVE_HIGH>;
> +
> +		flash-led {
> +			label = "ktd2692-flash";
> +			led-max-microamp = <300000>;
> +			flash-max-microamp = <1500000>;
> +			flash-max-timeout-us = <1835000>;
> +		};
> +	};
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  
> 
