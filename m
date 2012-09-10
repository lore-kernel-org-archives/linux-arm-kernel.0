From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 10 Sep 2012 18:34:20 +0200
Subject: [PATCH] ARM: dts: AM33XX: fix gpio node numbering to match
 hardware
In-Reply-To: <1347294020-22661-1-git-send-email-mporter@ti.com>
References: <1347294020-22661-1-git-send-email-mporter@ti.com>
Message-ID: <504E168C.6060603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Tony

Hi Matt,

30 minutes too late for my pull request :-(

There are a couple of am33xx patches under discussion, so I'll take them
and send a for_3.7/dts-part2 pull request if this is not too late for Tony.

On 09/10/2012 06:20 PM, Matt Porter wrote:
> On AM33xx, the datasheet and TRM refer to four GPIO instances that
> are 0-based, GPIO0-3.

Or maybe you should just update the spec to use a 1-based GPIO number
like OMAP :-)

Regards,
Benoit


> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index bb31bff..1369bfc 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -62,7 +62,7 @@
>  			reg = <0x48200000 0x1000>;
>  		};
>  
> -		gpio1: gpio at 44e07000 {
> +		gpio0: gpio at 44e07000 {
>  			compatible = "ti,omap4-gpio";
>  			ti,hwmods = "gpio1";
>  			gpio-controller;
> @@ -74,7 +74,7 @@
>  			interrupts = <96>;
>  		};
>  
> -		gpio2: gpio at 4804c000 {
> +		gpio1: gpio at 4804c000 {
>  			compatible = "ti,omap4-gpio";
>  			ti,hwmods = "gpio2";
>  			gpio-controller;
> @@ -86,7 +86,7 @@
>  			interrupts = <98>;
>  		};
>  
> -		gpio3: gpio at 481ac000 {
> +		gpio2: gpio at 481ac000 {
>  			compatible = "ti,omap4-gpio";
>  			ti,hwmods = "gpio3";
>  			gpio-controller;
> @@ -98,7 +98,7 @@
>  			interrupts = <32>;
>  		};
>  
> -		gpio4: gpio at 481ae000 {
> +		gpio3: gpio at 481ae000 {
>  			compatible = "ti,omap4-gpio";
>  			ti,hwmods = "gpio4";
>  			gpio-controller;
> 
