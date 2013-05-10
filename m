From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 10 May 2013 12:31:51 +0200
Subject: [PATCH] ARM: at91: dts: request only spi cs-gpios used on sama5d3x
 cpu module
In-Reply-To: <1368181807-15182-1-git-send-email-nicolas.ferre@atmel.com>
References: <1368181807-15182-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <518CCC97.904@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/05/2013 12:30, Nicolas Ferre :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Instead of requesting all available spi cs-gpios, request only the ones used on
> the board, in our case on the cpu module.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked on at91-3.10-fixes branch.

> ---
>   arch/arm/boot/dts/sama5d3.dtsi    | 10 ----------
>   arch/arm/boot/dts/sama5d3xcm.dtsi |  4 ++++
>   2 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index 2e643ea..dee5e2f 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -75,11 +75,6 @@
>   				compatible = "atmel,at91sam9x5-spi";
>   				reg = <0xf0004000 0x100>;
>   				interrupts = <24 4 3>;
> -				cs-gpios = <&pioD 13 0
> -					    &pioD 14 0 /* conflicts with SCK0 and CANRX0 */
> -					    &pioD 15 0 /* conflicts with CTS0 and CANTX0 */
> -					    &pioD 16 0 /* conflicts with RTS0 and PWMFI3 */
> -					   >;
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&pinctrl_spi0>;
>   				status = "disabled";
> @@ -203,11 +198,6 @@
>   				compatible = "atmel,at91sam9x5-spi";
>   				reg = <0xf8008000 0x100>;
>   				interrupts = <25 4 3>;
> -				cs-gpios = <&pioC 25 0
> -					    &pioC 26 0 /* conflitcs with TWD1 and ISI_D11 */
> -					    &pioC 27 0 /* conflitcs with TWCK1 and ISI_D10 */
> -					    &pioC 28 0 /* conflitcs with PWMFI0 and ISI_D9 */
> -					   >;
>   				pinctrl-names = "default";
>   				pinctrl-0 = <&pinctrl_spi1>;
>   				status = "disabled";
> diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
> index 1f8ed40..b336e77 100644
> --- a/arch/arm/boot/dts/sama5d3xcm.dtsi
> +++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
> @@ -32,6 +32,10 @@
>
>   	ahb {
>   		apb {
> +			spi0: spi at f0004000 {
> +				cs-gpios = <&pioD 13 0>, <0>, <0>, <0>;
> +			};
> +
>   			macb0: ethernet at f0028000 {
>   				phy-mode = "rgmii";
>   			};
>


-- 
Nicolas Ferre
