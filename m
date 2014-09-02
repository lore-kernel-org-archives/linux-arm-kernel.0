From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 2 Sep 2014 18:33:56 +0200
Subject: [PATCH] ARM: at91/dt: at91sam9m10g45ek add rtc node
In-Reply-To: <1409655132-17735-1-git-send-email-evanluijk@interact.nl>
References: <1409655132-17735-1-git-send-email-evanluijk@interact.nl>
Message-ID: <20140902183356.7bcfdf84@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Erik,

On Tue,  2 Sep 2014 12:52:12 +0200
Erik van Luijk <evanluijk@interact.nl> wrote:

> Signed-off-by: Erik van Luijk <evanluijk@interact.nl>

Except for the nitpicks you'll find below, you have my

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

> ---
>  arch/arm/boot/dts/at91sam9g45.dtsi     | 7 +++++++
>  arch/arm/boot/dts/at91sam9m10g45ek.dts | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 932a669..bf62c18 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -1070,6 +1070,13 @@
>  				status = "disabled";
>  			};
>  
> +			rtc at fffffdb0 {
> +				compatible = "atmel,at91rm9200-rtc";
> +				reg = <0xfffffdb0 0x30>;

The RTC registers goes from 0xfffffdb0 to 0xfffffdc0, which means the
size is 0x10 and not 0x30. This is not important here, because the
following region is marked as reserved, but we prefer to keep the DT
consistent with the datasheet.

> +				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +				status = "disabled";
> +			};
> +
>  			spi0: spi at fffa4000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> index 96ccc7d..2dd2347 100644
> --- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
> +++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> @@ -70,6 +70,9 @@
>  
>  			watchdog at fffffd40 {
>  				status = "okay";
> +
> +			rtc at fffffdb0 {
> +				status = "okay";

Try to keep SoC and board changes in distinct commits.

>  			};
>  
>  			mmc0: mmc at fff80000 {


Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
