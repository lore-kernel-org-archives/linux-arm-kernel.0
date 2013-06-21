From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 21 Jun 2013 01:45:43 +0000
Subject: [RFC PATCH 3/4] ARM: at91/dt: add sam9 watchdog default options
 to SoCs
In-Reply-To: <1370947890-954-4-git-send-email-b.brezillon@overkiz.com>
References: <1370947890-954-1-git-send-email-b.brezillon@overkiz.com>
 <1370947890-954-4-git-send-email-b.brezillon@overkiz.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641687DE064@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces at lists.infradead.org]
> On Behalf Of Boris BREZILLON
> Sent: 2013?6?11? 18:51
> To: Wim Van Sebroeck; Jean-Christophe Plagniol-Villard; Ferre, Nicolas
> Cc: Boris BREZILLON; Russell King; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org; linux-watchdog at vger.kernel.org
> Subject: [RFC PATCH 3/4] ARM: at91/dt: add sam9 watchdog default options to
> SoCs
> 
> Set default watchdog options in every SoC compatible with the sam9 watchdog.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> ---
>  arch/arm/boot/dts/at91sam9260.dtsi |    5 +++++
>  arch/arm/boot/dts/at91sam9263.dtsi |    5 +++++
>  arch/arm/boot/dts/at91sam9g45.dtsi |    5 +++++
>  arch/arm/boot/dts/at91sam9n12.dtsi |    5 +++++
>  arch/arm/boot/dts/at91sam9x5.dtsi  |    5 +++++
>  arch/arm/boot/dts/sama5d3.dtsi     |    5 +++++
>  6 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi
> b/arch/arm/boot/dts/at91sam9260.dtsi
> index 899a7cf..6c44c35 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -643,6 +643,11 @@
>  			watchdog at fffffd40 {
>  				compatible = "atmel,at91sam9260-wdt";
>  				reg = <0xfffffd40 0x10>;
> +				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +				atmel,watchdog-type = "hardware";
> +				atmel,reset-type = "all";
> +				atmel,dbg-halt;
> +				atmel,idle-halt;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi
> b/arch/arm/boot/dts/at91sam9263.dtsi
> index ff63811..6b31ee0 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -519,6 +519,11 @@
>  			watchdog at fffffd40 {
>  				compatible = "atmel,at91sam9260-wdt";
>  				reg = <0xfffffd40 0x10>;
> +				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +				atmel,watchdog-type = "hardware";
> +				atmel,reset-type = "all";
> +				atmel,dbg-halt;
> +				atmel,idle-halt;
>  				status = "disabled";
>  			};
> 
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi
> b/arch/arm/boot/dts/at91sam9g45.dtsi
> index faec17d..ca1a643 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -634,6 +634,11 @@
>  			watchdog at fffffd40 {
>  				compatible = "atmel,at91sam9260-wdt";
>  				reg = <0xfffffd40 0x10>;
> +				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +				atmel,watchdog-type = "hardware";
> +				atmel,reset-type = "all";
> +				atmel,dbg-halt;
> +				atmel,idle-halt;
>  				status = "disabled";
>  			};
> 
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi
> b/arch/arm/boot/dts/at91sam9n12.dtsi
> index 3166e1d..7c8a5ea 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -505,6 +505,11 @@
>  			watchdog at fffffe40 {
>  				compatible = "atmel,at91sam9260-wdt";
>  				reg = <0xfffffe40 0x10>;
> +				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +				atmel,watchdog-type = "hardware";
> +				atmel,reset-type = "all";
> +				atmel,dbg-halt;
> +				atmel,idle-halt;
>  				status = "disabled";
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi
> b/arch/arm/boot/dts/at91sam9x5.dtsi
> index e77106e..48eb1cc 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -742,6 +742,11 @@
>  			watchdog at fffffe40 {
>  				compatible = "atmel,at91sam9260-wdt";
>  				reg = <0xfffffe40 0x10>;
> +				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +				atmel,watchdog-type = "hardware";
> +				atmel,reset-type = "all";
> +				atmel,dbg-halt;
> +				atmel,idle-halt;
>  				status = "disabled";
>  			};
> 
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi
> b/arch/arm/boot/dts/sama5d3.dtsi
> index c00e158..7974723 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -885,6 +885,11 @@
>  			watchdog at fffffe40 {
>  				compatible = "atmel,at91sam9260-wdt";
>  				reg = <0xfffffe40 0x10>;
> +				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
Change it with,
				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
Because in sama5d3, watchdog interrupt is not shared with SYSC, it uses a separate interrupt line, 4.
> +				atmel,watchdog-type = "hardware";
> +				atmel,reset-type = "all";
> +				atmel,dbg-halt;
> +				atmel,idle-halt;
>  				status = "disabled";
>  			};
> 
> --
> 1.7.9.5
> 
> 
Best Regards,
Wenyou Yang
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
