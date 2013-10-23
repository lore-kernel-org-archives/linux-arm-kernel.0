From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 23 Oct 2013 14:31:24 +0100
Subject: [PATCH] ARM: dts: Add max77686 RTC interrupt to cros5250-common
In-Reply-To: <1382533861-12688-1-git-send-email-dianders@chromium.org>
References: <1382533861-12688-1-git-send-email-dianders@chromium.org>
Message-ID: <777cfa1b95066d03b19252ac1b6eac2d@www.loen.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-10-23 14:11, Doug Anderson wrote:
> Without the interrupt you'll get problems if you enable
> CONFIG_RTC_DRV_MAX77686.  Setup the interrupt properly in the device
> tree.

Awesome! Thanks for fixing this, Doug. My Chromebook is much happier 
now!

> Signed-off-by: Doug Anderson <dianders@chromium.org>

Tested-by: Marc Zyngier <marc.zyngier@arm.com>

         M.

> ---
>  arch/arm/boot/dts/cros5250-common.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/cros5250-common.dtsi
> b/arch/arm/boot/dts/cros5250-common.dtsi
> index dc259e8b..9b186ac 100644
> --- a/arch/arm/boot/dts/cros5250-common.dtsi
> +++ b/arch/arm/boot/dts/cros5250-common.dtsi
> @@ -27,6 +27,13 @@
>  		i2c2_bus: i2c2-bus {
>  			samsung,pin-pud = <0>;
>  		};
> +
> +		max77686_irq: max77686-irq {
> +			samsung,pins = "gpx3-2";
> +			samsung,pin-function = <0>;
> +			samsung,pin-pud = <0>;
> +			samsung,pin-drv = <0>;
> +		};
>  	};
>
>  	i2c at 12C60000 {
> @@ -35,6 +42,11 @@
>
>  		max77686 at 09 {
>  			compatible = "maxim,max77686";
> +			interrupt-parent = <&gpx3>;
> +			interrupts = <2 0>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&max77686_irq>;
> +			wakeup-source;
>  			reg = <0x09>;
>
>  			voltage-regulators {

-- 
Fast, cheap, reliable. Pick two.
