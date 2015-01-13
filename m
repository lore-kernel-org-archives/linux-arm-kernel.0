From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 12 Jan 2015 21:02:30 -0800
Subject: [PATCH v3 03/13] mtd: st_spi_fsm: dt-bindings: Deprecate generic
 compatible string
In-Reply-To: <1418644760-18773-4-git-send-email-lee.jones@linaro.org>
References: <1418644760-18773-1-git-send-email-lee.jones@linaro.org>
 <1418644760-18773-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20150113050230.GP9759@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ devicetree

Please include devicetree at vger.kernel.org whenever you send DT patches
like this.

On Mon, Dec 15, 2014 at 11:59:10AM +0000, Lee Jones wrote:
> This driver now obtains platform information via DT matching, which requires
> a compatible string per platform.  This change introduces the new specific
> strings and deprecates the old generic one.
> 
> We also take out all of the old, unused properties which are no longer
> required.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/mtd/st-fsm.txt | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/st-fsm.txt b/Documentation/devicetree/bindings/mtd/st-fsm.txt
> index c248939..4e3a16c 100644
> --- a/Documentation/devicetree/bindings/mtd/st-fsm.txt
> +++ b/Documentation/devicetree/bindings/mtd/st-fsm.txt
> @@ -1,26 +1,20 @@
>  * ST-Microelectronics SPI FSM Serial (NOR) Flash Controller
>  
>  Required properties:
> -  - compatible : Should be "st,spi-fsm"
> +  - compatible : "st,spi-fsm" is now DEPRECATED

See my comments on patch 4.

In light of that, it may make sense to support both, so DTS files could
list:

	compatible = "st,stid127-spi-fsm", "st,spi-fsm";

But I'm not really privy to whatever discussion determined that you
needed to deprecate the current binding. If there really are no users of
the current upstream binding, then maybe your current deprecation plan
can work fine.

> +		 Should be one of;
> +		   "st,stid127-spi-fsm"
> +		   "st,stih407-spi-fsm"
> +		   "st,stih416-spi-fsm"
>    - reg        : Contains register's location and length.
> -  - reg-names  : Should contain the reg names "spi-fsm"
>    - interrupts : The interrupt number
>    - pinctrl-0  : Standard Pinctrl phandle (see: pinctrl/pinctrl-bindings.txt)
> -
> -Optional properties:
> -  - st,syscfg          : Phandle to boot-device system configuration registers
> -  - st,boot-device-reg : Address of the aforementioned boot-device register(s)
> -  - st,boot-device-spi : Expected boot-device value if booted via this device
> +  - st,syscfg  : Phandle to boot-device system configuration registers
>  
>  Example:
>  	spifsm: spifsm at fe902000{
> -	        compatible         = "st,spi-fsm";
> +		compatible         = "st,stih407-spi-fsm";
>  	        reg                =  <0xfe902000 0x1000>;
> -	        reg-names          = "spi-fsm";
>  	        pinctrl-0          = <&pinctrl_fsm>;
>  		st,syscfg	   = <&syscfg_rear>;
> -	        st,boot-device-reg = <0x958>;
> -	        st,boot-device-spi = <0x1a>;
> -		status = "okay";
>  	};
> -

Brian
