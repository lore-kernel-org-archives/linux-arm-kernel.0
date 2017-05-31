From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 May 2017 10:50:18 +0200
Subject: [PATCH v2] ARM: dts: at91: sama5d2_xplained: add pwm controller
In-Reply-To: <1487839757-14040-1-git-send-email-claudiu.beznea@microchip.com>
References: <1487839757-14040-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <20170531085018.tmbwqrqiiwitnm5u@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23/02/2017 at 10:49:17 +0200, Claudiu Beznea wrote:
> Add pwm controller bindings for sam5d2_xplained
> and enable it.
> 
> Changes since v1:
> - Correct the typo in patch subject.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained_common.dtsi | 4 ++++
>  arch/arm/boot/dts/sama5d2.dtsi                      | 8 ++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained_common.dtsi b/arch/arm/boot/dts/at91-sama5d2_xplained_common.dtsi
> index 9fc270f..493ea29 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained_common.dtsi
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained_common.dtsi
> @@ -318,6 +318,10 @@
>  				};
>  			};
>  
> +			pwm0: pwm at f802c000 {
> +				status = "okay";
> +			};
> +
>  			flx0: flexcom at f8034000 {
>  				atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_USART>;
>  				status = "disabled"; /* conflict with ISC_D2 & ISC_D3 data pins */


This doesn't apply on v4.12-rc1, this file doesn't exist.

> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index cd459e8..e88785e 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -1098,6 +1098,14 @@
>  				status = "disabled";
>  			};
>  
> +			pwm0: pwm at f802c000 {
> +				compatible = "atmel,sama5d2-pwm";
> +				reg = <0xf802c000 0x4000>;
> +				interrupts = <38 IRQ_TYPE_LEVEL_HIGH 7>;
> +				#pwm-cells = <3>;
> +				clocks = <&pwm_clk>;
> +			};
> +
>  			sfr: sfr at f8030000 {
>  				compatible = "atmel,sama5d2-sfr", "syscon";
>  				reg = <0xf8030000 0x98>;
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
