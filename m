From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 31 Mar 2014 16:47:31 +0200
Subject: [PATCH 3/4] ARM: sun7i: dt: add PWM support
In-Reply-To: <1396267649-18009-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1396267649-18009-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1396267649-18009-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140331144731.GI26751@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 02:07:28PM +0200, Alexandre Belloni wrote:
> Adds the PWM bindings for the Allwinner A20.
> Also adds the pinctrl descriptions for both PWM channels.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 6f25cf559ad0..0dd15fcb8955 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -366,6 +366,20 @@
>  			#size-cells = <0>;
>  			#gpio-cells = <3>;
>  
> +			pwm0_pins_a: pwm0 at 0 {
> +				allwinner,pins = "PB2";
> +				allwinner,function = "pwm";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
> +			pwm1_pins_a: pwm1 at 0 {
> +				allwinner,pins = "PI3";
> +				allwinner,function = "pwm";
> +				allwinner,drive = <0>;
> +				allwinner,pull = <0>;
> +			};
> +
>  			uart0_pins_a: uart0 at 0 {
>  				allwinner,pins = "PB22", "PB23";
>  				allwinner,function = "uart0";
> @@ -446,6 +460,14 @@
>  			clocks = <&osc24M>;
>  		};
>  
> +		pwm: pwm at 01c20e00 {
> +			compatible = "allwinner,sun7i-pwm";
> +			reg = <0x01c20e00 0xc>;
> +			clocks = <&osc24M>;
> +			#pwm-cells = <3>;
> +			status = "disabled";
> +		};
> +

Can you make this two separate patches? One for the muxing options and
one for the introduction of the new IP.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140331/25ba0d2c/attachment-0001.sig>
