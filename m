From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 Jan 2014 12:25:28 +0100
Subject: [PATCH v2 09/12] at91: dt: sam9261: Pinmux DT entries for the
 SMC/EBI interface
In-Reply-To: <1389270709-32662-10-git-send-email-jjhiblot@traphandler.com>
References: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
 <1389270709-32662-10-git-send-email-jjhiblot@traphandler.com>
Message-ID: <20140115112528.GR14627@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:31 Thu 09 Jan     , Jean-Jacques Hiblot wrote:
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  arch/arm/boot/dts/at91sam9261.dtsi | 54 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
> index cd219b9..695d5d2 100644
> --- a/arch/arm/boot/dts/at91sam9261.dtsi
> +++ b/arch/arm/boot/dts/at91sam9261.dtsi
> @@ -317,6 +317,60 @@
>  							 >;
>  					};
>  				};
> +				smc {
> +					pinctrl_smc_nwait: smc_nwait-0 {
> +						atmel,pins = <AT91_PIOC 2 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +					};
> +					pinctrl_smc_a23_a25: smc_a23_a25-0 {
use better name this is not clear
> +						atmel,pins =
> +							<AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_NONE
> +							 AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_NONE
> +							 AT91_PIOC 3  AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +					};
> +					pinctrl_smc_d16_d31: smc_d16_d31-0 {
> +						atmel,pins =
> +							<AT91_PIOC 16 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 17 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 18 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 19 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 20 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 21 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 22 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 23 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 24 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 25 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 26 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 27 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 28 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 29 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_NONE
> +							 AT91_PIOC 31 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +					};
> +					pinctrl_smc_ncs4: smc_ncs4-0 {
> +						atmel,pins = <AT91_PIOC 4 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +					};
> +					pinctrl_smc_ncs5: smc_ncs5-0 {
> +						atmel,pins = <AT91_PIOC 5 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +					};
> +					pinctrl_smc_nandoe: smc_nandoe-0 {
> +						atmel,pins = <AT91_PIOC 0 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +					};
> +					pinctrl_smc_ncs6: smc_ncs6-0 {
> +						atmel,pins = <AT91_PIOC 0 AT91_PERIPH_B AT91_PINCTRL_NONE>;
> +					};
> +					pinctrl_smc_nandwe: smc_nandwe-0 {
> +						atmel,pins = <AT91_PIOC 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +					};
> +					pinctrl_smc_ncs7: smc_ncs7-0 {
> +						atmel,pins = <AT91_PIOC 1 AT91_PERIPH_B AT91_PINCTRL_NONE>;
> +					};
> +					pinctrl_smc_cfce1: smc_cfce1-0 {
> +						atmel,pins = <AT91_PIOC 6 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +					};
> +					pinctrl_smc_cfce2: smc_cfce2-0 {
> +						atmel,pins = <AT91_PIOC 7 AT91_PERIPH_A AT91_PINCTRL_NONE>;
> +					};
> +				};
>  				pioA: gpio at fffff400 {
>  					compatible = "atmel,at91rm9200-gpio";
>  					reg = <0xfffff400 0x200>;
> -- 
> 1.8.5.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
