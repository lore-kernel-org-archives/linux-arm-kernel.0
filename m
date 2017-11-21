From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 21 Nov 2017 16:06:38 +0100
Subject: [PATCH] ARM: dts: exynos: correct trats2 panel reset line
In-Reply-To: <20171121112424.GA6650@lineageos.org>
References: <CGME20171121112435epcas4p25f529481eebd076f0fde78c500b04395@epcas4p2.samsung.com>
 <20171121112424.GA6650@lineageos.org>
Message-ID: <59887245-ed25-ac1b-3bd4-b72c8fd1dd74@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On 2017-11-21 12:24, Simon Shields wrote:
> trats2 uses gpf2-1 as the panel reset GPIO. gpy4-5 was only used
> on early revisions of the board.
>
> Fixes: 420ae8451a22 ("ARM: dts: exynos4412-trats2: add panel node")
> Signed-off-by: Simon Shields <simon@lineageos.org>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

It looks that this has been accidentally copy/pasted from the previous
dts used for early version of the development board. I've checked the
Trats2 schematic and indeed gpf2-1 is the correct pin for panel reset
line.

> ---
>   arch/arm/boot/dts/exynos4412-trats2.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index 220cdf109405..9f4672ba9943 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -454,7 +454,7 @@
>   		reg = <0>;
>   		vdd3-supply = <&lcd_vdd3_reg>;
>   		vci-supply = <&ldo25_reg>;
> -		reset-gpios = <&gpy4 5 GPIO_ACTIVE_HIGH>;
> +		reset-gpios = <&gpf2 1 GPIO_ACTIVE_HIGH>;
>   		power-on-delay= <50>;
>   		reset-delay = <100>;
>   		init-delay = <100>;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
