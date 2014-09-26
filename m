From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Sep 2014 09:41:27 +0800
Subject: [PATCH v2 2/3] ARM: dts: vf610: Add ARM Global Timer
In-Reply-To: <1411575610-20895-3-git-send-email-stefan@agner.ch>
References: <1411575610-20895-1-git-send-email-stefan@agner.ch>
 <1411575610-20895-3-git-send-email-stefan@agner.ch>
Message-ID: <20140926014126.GE21077@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 06:20:09PM +0200, Stefan Agner wrote:
> Add Global Timer support which is part of the private peripherals
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
> index 4d2ec32..3232b9a 100644
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
> +			timer: global-timer at 40002200 {

The renaming to "timer" should be applied on node name, not the label
name.  I change it as below and applied the patch.

	global_timer: timer at 40002200

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
