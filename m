From: robh@kernel.org (Rob Herring)
Date: Tue, 17 Nov 2015 13:32:18 -0600
Subject: [PATCH 2/7] Documentation: bindings: Define CPU reset controller
In-Reply-To: <1447772202-12418-3-git-send-email-carlo@caione.org>
References: <1447772202-12418-1-git-send-email-carlo@caione.org>
 <1447772202-12418-3-git-send-email-carlo@caione.org>
Message-ID: <20151117193218.GA2096@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 03:56:37PM +0100, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>

Same here, a more specific subject please.

Otherwise, looks fine.

> 
> The clock controller on Amlogic Meson8b SoCs has been extended with a
> reset controller used to reset the CPU cores. It is used during SMP
> bringup.
> 
> With this patch we extend the clock controller documentation.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
> index 2b7b3fa..feeb4de 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
> +++ b/Documentation/devicetree/bindings/clock/amlogic,meson8b-clkc.txt
> @@ -1,7 +1,8 @@
>  * Amlogic Meson8b Clock and Reset Unit
>  
>  The Amlogic Meson8b clock controller generates and supplies clock to various
> -controllers within the SoC.
> +controllers within the SoC and also implements a reset controller for the CPU
> +cores.
>  
>  Required Properties:
>  
> @@ -13,16 +14,19 @@ Required Properties:
>  	   mapped region.
>  
>  - #clock-cells: should be 1.
> +- #reset-cells: should be 1.
>  
>  Each clock is assigned an identifier and client nodes can use this identifier
>  to specify the clock which they consume. All available clocks are defined as
>  preprocessor macros in the dt-bindings/clock/meson8b-clkc.h header and can be
>  used in device tree sources.
> +Similar identifiers exist for the CPU core reset lines.
>  
>  Example: Clock controller node:
>  
>  	clkc: clock-controller at c1104000 {
>  		#clock-cells = <1>;
> +		#reset-cells = <1>;
>  		compatible = "amlogic,meson8b-clkc";
>  		reg = <0xc1108000 0x4>, <0xc1104000 0x460>;
>  	};
> -- 
> 2.5.0
> 
