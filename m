From: stefan@agner.ch (Stefan Agner)
Date: Wed, 18 Nov 2015 22:36:40 -0800
Subject: [PATCH] ARM: dts: vfxxx: Fix dspi[01] spi-num-chipselects.
In-Reply-To: <1447905280-5172-1-git-send-email-cory.tusar@pid1solutions.com>
References: <1447905280-5172-1-git-send-email-cory.tusar@pid1solutions.com>
Message-ID: <a2287b99e8f9aa378e9c7c3750d1a7e5@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-11-18 19:54, Cory Tusar wrote:
> Per the Vybrid Reference Manual (section 3.8.6.1), dspi0 has 6 chip
> select signals associated with it, while dspi1 has only 4.

That is right, verified by in my RM!

Acked-by: Stefan Agner <stefan@agner.ch>

> 
> Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
> ---
>  arch/arm/boot/dts/vfxxx.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
> index 6736bae..1cca43a 100644
> --- a/arch/arm/boot/dts/vfxxx.dtsi
> +++ b/arch/arm/boot/dts/vfxxx.dtsi
> @@ -158,7 +158,7 @@
>  				interrupts = <67 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks VF610_CLK_DSPI0>;
>  				clock-names = "dspi";
> -				spi-num-chipselects = <5>;
> +				spi-num-chipselects = <6>;
>  				status = "disabled";
>  			};
>  
> @@ -170,7 +170,7 @@
>  				interrupts = <68 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clks VF610_CLK_DSPI1>;
>  				clock-names = "dspi";
> -				spi-num-chipselects = <5>;
> +				spi-num-chipselects = <4>;
>  				status = "disabled";
>  			};
