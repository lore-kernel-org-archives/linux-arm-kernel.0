From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Nov 2018 13:09:09 -0600
Subject: [PATCH v2 05/11] Doc: DT: thermal: new irq-mode for trip point
In-Reply-To: <1541610593-28542-6-git-send-email-l.luba@partner.samsung.com>
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20181107171039eucas1p2227bd4bc573fd0d2a3a97986004be16b@eucas1p2.samsung.com>
 <1541610593-28542-6-git-send-email-l.luba@partner.samsung.com>
Message-ID: <5bea0ecd.1c69fb81.d5613.1c9e@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2018 at 06:09:47PM +0100, Lukasz Luba wrote:
> Thermal trip point gets new flag in DT: irq-mode.
> Trip point may have a new explicit flag which indicate
> IRQ support when the temperature is met (so the thermal framework
> deos not need to set polling for it).
> It is useful for 'passive' cooling trip point,
> which now will not register for polling the temperature.
> 
> Update documentation about irq-mode for trip points.

This patch should come before you use it.

> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  Documentation/devicetree/bindings/thermal/thermal.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
> index ca14ba9..bee21e3 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/thermal.txt
> @@ -90,6 +90,10 @@ Required properties:
>  	"critical":	Hardware not reliable.
>    Type: string
>  
> +- irq-mode:		A flag indicating that trip rises irq, so there is no
> +  Type: bool		need of polling in thermal framework.
> +  Size: one cell

Should be optional, right?

> +
>  * Cooling device maps
>  
>  The cooling device maps node is a node to describe how cooling devices
> @@ -256,16 +260,19 @@ thermal-zones {
>  				temperature = <90000>; /* millicelsius */
>  				hysteresis = <2000>; /* millicelsius */
>  				type = "active";
> +				irq-mode;
>  			};
>  			cpu_alert1: cpu-alert1 {
>  				temperature = <100000>; /* millicelsius */
>  				hysteresis = <2000>; /* millicelsius */
>  				type = "passive";
> +				irq-mode;
>  			};
>  			cpu_crit: cpu-crit {
>  				temperature = <125000>; /* millicelsius */
>  				hysteresis = <2000>; /* millicelsius */
>  				type = "critical";
> +				irq-mode;
>  			};
>  		};
>  
> -- 
> 2.7.4
> 
