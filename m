From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Jan 2013 16:02:15 +0000
Subject: [PATCH 5/5] ARM: dts: OMAP5: Specify nonsecure PPI IRQ for arch
 timer
In-Reply-To: <1358523141-12295-6-git-send-email-santosh.shilimkar@ti.com>
References: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
 <1358523141-12295-6-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <50F97207.1030706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/01/13 15:32, Santosh Shilimkar wrote:
> From: Rajendra Nayak <rnayak@ti.com>
> 
> Specify both secure as well as nonsecure PPI IRQ for arch
> timer. This fixes the following errors seen on DT OMAP5 boot..
> 
> [    0.000000] arch_timer: No interrupt available, giving up
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 790bb2a..7a78d1b 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -35,8 +35,12 @@
>  			compatible = "arm,cortex-a15";
>  			timer {
>  				compatible = "arm,armv7-timer";
> -				/* 14th PPI IRQ, active low level-sensitive */
> -				interrupts = <1 14 0x308>;
> +				/*
> +				 * PPI secure/nonsecure IRQ,
> +				 * active low level-sensitive
> +				 */
> +				interrupts = <1 13 0x308>,
> +					     <1 14 0x308>;

Care to add the virtual and HYP timer interrupts? So KVM can get a
chance to run on this HW...

>  				clock-frequency = <6144000>;
>  			};
>  		};
> @@ -44,8 +48,12 @@
>  			compatible = "arm,cortex-a15";
>  			timer {
>  				compatible = "arm,armv7-timer";
> -				/* 14th PPI IRQ, active low level-sensitive */
> -				interrupts = <1 14 0x308>;
> +				/*
> +				 * PPI secure/nonsecure IRQ,
> +				 * active low level-sensitive
> +				 */
> +				interrupts = <1 13 0x308>,
> +					     <1 14 0x308>;

Same here.

>  				clock-frequency = <6144000>;
>  			};
>  		};
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
