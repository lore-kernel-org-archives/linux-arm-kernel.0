From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sat, 4 Nov 2017 16:43:31 +0800
Subject: [PATCH 1/3] arm64: dts: actions: add s900 clock controller nodes
In-Reply-To: <1509479663-8985-2-git-send-email-manivannan.sadhasivam@linaro.org>
References: <1509479663-8985-1-git-send-email-manivannan.sadhasivam@linaro.org>
 <1509479663-8985-2-git-send-email-manivannan.sadhasivam@linaro.org>
Message-ID: <a8bd3b8b-190a-6dbf-6976-207baca3030b@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 01.11.2017 um 03:54 schrieb Manivannan Sadhasivam:
> This patch adds clock controller nodes for Actions Semi s900 SoC

Please avoid "This patch". Once applied, it's a commit. :)

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/actions/s900.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
> index 11406f6..c099ef1 100644
> --- a/arch/arm64/boot/dts/actions/s900.dtsi
> +++ b/arch/arm64/boot/dts/actions/s900.dtsi
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/actions,s900-clock.h>

Alphabetical order please.

>  
>  / {
>  	compatible = "actions,s900";
> @@ -88,6 +89,24 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	losc: losc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		#clock-cells = <0>;
> +	};
> +
> +	diff_24M: diff_24M {

No underscore in node names please - maybe diff-24M or simpler diff24M?
Please double-check that name - is it from manual or from schematics?

> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		#clock-cells = <0>;
> +	};
> +
> +	clock: clock-controller at e0160000 {
> +		compatible = "actions,s900-clock";
> +		reg = <0 0xe0160000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};

This node belongs into the soc node below, ordered by unit address.
And maybe there's a better label than "clock"? "clkc" or some official
name from the manual?

> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
