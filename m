From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 12 Sep 2014 15:59:01 +0800
Subject: [PATCH 1/2] ARM: dts: vf610: Add ARM Global Timer
In-Reply-To: <1410437175-6636-1-git-send-email-stefan@agner.ch>
References: <1410437175-6636-1-git-send-email-stefan@agner.ch>
Message-ID: <20140912075900.GK18566@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 02:06:14PM +0200, Stefan Agner wrote:
> Add Global Timer support which is part of the Snoop Control Unit
> of the Cortex-A5 processor. This Global Timer is compatible with the
> Cortex-A9 implementation. It's a 64-bit timer and is clocked by the
> peripheral clock, which is typically 133 or 166MHz on Vybrid.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/boot/dts/vf610.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index 4d2ec32..a03abf6 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -11,6 +11,7 @@
>  #include "vf610-pinfunc.h"
>  #include <dt-bindings/clock/vf610-clock.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  
>  / {
>  	aliases {
> @@ -83,6 +84,13 @@
>  				      <0x40002100 0x100>;
>  			};
>  
> +			global_timer: global-timer at 40002200 {

I think it's more idiomatic to use the generic name 'timer' for the
node.

Shawn

> +				compatible = "arm,cortex-a9-global-timer";
> +				reg = <0x40002200 0x20>;
> +				interrupts = <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clks VF610_CLK_PLATFORM_BUS>;
> +			};
> +
>  			L2: l2-cache at 40006000 {
>  				compatible = "arm,pl310-cache";
>  				reg = <0x40006000 0x1000>;
> -- 
> 2.1.0
> 
