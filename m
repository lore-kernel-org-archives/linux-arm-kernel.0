From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 17 Apr 2013 18:56:06 -0500
Subject: [PATCH 1/2] ARM: dts: OMAP5: add PWM capability to timer nodes
 missing it
In-Reply-To: <1366240995-53538-1-git-send-email-s-anna@ti.com>
References: <1366240995-53538-1-git-send-email-s-anna@ti.com>
Message-ID: <516F3696.9080008@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 04/17/2013 06:23 PM, Suman Anna wrote:
> OMAP5 has 6 timers (GPTimers 5, 6, 8 to 11) that are capable of PWM.
> The PWM capability property is missing from the node definitions of
> couple of timers, and this has been fixed.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 790bb2a..0d155f5 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -422,6 +422,7 @@
>  			interrupts = <0 41 0x4>;
>  			ti,hwmods = "timer5";
>  			ti,timer-dsp;
> +			ti,timer-pwm;
>  		};
>  
>  		timer6: timer at 4013a000 {
> @@ -458,6 +459,7 @@
>  			reg = <0x4803e000 0x80>;
>  			interrupts = <0 45 0x4>;
>  			ti,hwmods = "timer9";
> +			ti,timer-pwm;
>  		};
>  
>  		timer10: timer at 48086000 {
> @@ -465,6 +467,7 @@
>  			reg = <0x48086000 0x80>;
>  			interrupts = <0 46 0x4>;
>  			ti,hwmods = "timer10";
> +			ti,timer-pwm;
>  		};
>  
>  		timer11: timer at 48088000 {

Make sure you copy the linux-arm and device-tree mailing lists.

Acked-by: Jon Hunter <jon-hunter@ti.com>

Thanks!
Jon
