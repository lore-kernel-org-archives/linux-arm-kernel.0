From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 19 Nov 2014 16:57:56 +0100
Subject: [PATCH 5/6] ARM: at91/dt: add trng node
In-Reply-To: <1412093987-30241-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1412093987-30241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412093987-30241-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <546CBE04.1000705@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/2014 18:19, Boris Brezillon :
> Add a DT node for the TRNG (True Random Number Generator) block.
> 
> Keep this block enabled as it does not depend on any external connection,
> and thus should be available on all boards.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

For patches 2 to 5, you can add my:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

while re-sending a series. Maybe add linux-crypto and the "HARDWARE
RANDOM NUMBER GENERATOR CORE" guys to the CC list.

Bye,

> ---
>  arch/arm/boot/dts/at91sam9g45.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 932a669..790c890 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -934,6 +934,13 @@
>  				status = "disabled";
>  			};
>  
> +			trng at fffcc000 {
> +				compatible = "atmel,at91sam9g45-trng";
> +				reg = <0xfffcc000 0x4000>;
> +				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
> +				clocks = <&trng_clk>;
> +			};
> +
>  			i2c0: i2c at fff84000 {
>  				compatible = "atmel,at91sam9g10-i2c";
>  				reg = <0xfff84000 0x100>;
> 


-- 
Nicolas Ferre
