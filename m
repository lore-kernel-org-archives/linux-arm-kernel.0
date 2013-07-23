From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 23 Jul 2013 21:38:02 +0800
Subject: [PATCH] ARM: dts: mxs: Add spi alias
In-Reply-To: <1374526049-29649-1-git-send-email-festevam@gmail.com>
References: <1374526049-29649-1-git-send-email-festevam@gmail.com>
Message-ID: <20130723133800.GA17327@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 05:47:29PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> After providing spi alias, we can get the following message during probe:
> 
> m25p80 spi1.0: sst25vf016b (2048 Kbytes)
> 
> ,which looks better than the original one:
> 
> m25p80 spi32766.0: sst25vf016b (2048 Kbytes)
> 
> While at it, keep the alias entries in alphabetical order.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx23.dtsi | 2 ++
>  arch/arm/boot/dts/imx28.dtsi | 6 ++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index 1e528db..28b5ce2 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -20,6 +20,8 @@
>  		gpio2 = &gpio2;
>  		serial0 = &auart0;
>  		serial1 = &auart1;
> +		spi0 = &ssp0;
> +		spi1 = &ssp1;
>  	};
>  
>  	cpus {
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index db67eb6..89d98a1 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -15,6 +15,8 @@
>  	interrupt-parent = <&icoll>;
>  
>  	aliases {
> +		ethernet0 = &mac0;
> +		ethernet1 = &mac1;
>  		gpio0 = &gpio0;
>  		gpio1 = &gpio1;
>  		gpio2 = &gpio2;
> @@ -22,13 +24,13 @@
>  		gpio4 = &gpio4;
>  		saif0 = &saif0;
>  		saif1 = &saif1;
> +		spi0 = &ssp1;
> +		spi1 = &ssp2;

So this should be put after serial, right?

Shawn

>  		serial0 = &auart0;
>  		serial1 = &auart1;
>  		serial2 = &auart2;
>  		serial3 = &auart3;
>  		serial4 = &auart4;
> -		ethernet0 = &mac0;
> -		ethernet1 = &mac1;
>  	};
>  
>  	cpus {
> -- 
> 1.8.1.2
> 
