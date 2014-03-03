From: jg1.han@samsung.com (Jingoo Han)
Date: Mon, 03 Mar 2014 16:40:47 +0900
Subject: [PATCH 4/7] ARM: dts: exynos5440: fix PCIe interrupt mapping
In-Reply-To: <1393608523-17509-5-git-send-email-l.stach@pengutronix.de>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <1393608523-17509-5-git-send-email-l.stach@pengutronix.de>
Message-ID: <000401cf36b3$e4aa0fb0$adfe2f10$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, March 01, 2014 2:29 AM, Lucas Stach wrote:
> 
> So it actually works.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/boot/dts/exynos5440.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> index 02a0a1226cef..65d425d9ec27 100644
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -274,7 +274,7 @@
>  			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /* non-prefetchable memory */
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 0 0>;
> -		interrupt-map = <0x0 0 &gic 53>;
> +		interrupt-map = <0 0 0 0 &gic GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;

It makes build errors as below:

DTC     arch/arm/boot/dts/exynos5440-ssdk5440.dtb
Error: arch/arm/boot/dts/exynos5440.dtsi:289.33-34 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [arch/arm/boot/dts/exynos5440-ssdk5440.dtb] Error 1
make: *** [exynos5440-ssdk5440.dtb] Error 2

Would you fix it?

Best regards,
Jingoo Han

>  		num-lanes = <4>;
>  		status = "disabled";
>  	};
> @@ -295,7 +295,7 @@
>  			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /* non-prefetchable memory */
>  		#interrupt-cells = <1>;
>  		interrupt-map-mask = <0 0 0 0>;
> -		interrupt-map = <0x0 0 &gic 56>;
> +		interrupt-map = <0 0 0 0 &gic GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
>  		num-lanes = <4>;
>  		status = "disabled";
>  	};
> --
> 1.8.5.3
