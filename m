From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Oct 2015 14:18:01 +0200
Subject: [PATCH] ARM: at91/dt: sama5d4: add the macb1 node
In-Reply-To: <1444997510-8841-1-git-send-email-gregory.clement@free-electrons.com>
References: <1444997510-8841-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20151016121801.GP3421@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/10/2015 at 14:11:50 +0200, Gregory CLEMENT wrote :
> The second macb is present on all sama5d4 soc. Let's add a node
> reflecting it in the device tree.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/at91-vinco.dts |  5 +----
>  arch/arm/boot/dts/sama5d4.dtsi   | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
> index b8036f5..2215e2e 100644
> --- a/arch/arm/boot/dts/at91-vinco.dts
> +++ b/arch/arm/boot/dts/at91-vinco.dts
> @@ -82,10 +82,7 @@
>  		apb {
>  
>  			adc0: adc at fc034000 {
> -				/* The vref depends on JP22 of EK. If connect 1-2 then use 3.3V. connect 2-3 use 3.0V */
> -				atmel,adc-vref = <3300>;
> -				/*atmel,adc-ts-wires = <4>;*/	/* Set up ADC touch screen */
> -				status = "okay";		/* Enable ADC IIO support */
> +				status = "okay"; /* Enable ADC IIO support */
>  			};
>  
>  			mmc0: mmc at f8000000 {

This probably shouldn't be part of that patch.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
