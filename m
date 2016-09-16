From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 16 Sep 2016 13:38:54 +0000
Subject: [PATCH v1 3/3] ARM: dts: imx6qdl-apalis: Use enable-gpios
 property for backlight
In-Reply-To: <dff8d58c4021719184af2c83773e86f175ad910e.1473833908.git.maitysanchayan@gmail.com>
References: <9d2c17aa2e00e6ff4349a53de8247860d2382607.1473833908.git.maitysanchayan@gmail.com>
 <dff8d58c4021719184af2c83773e86f175ad910e.1473833908.git.maitysanchayan@gmail.com>
Message-ID: <1474033134.3103.27.camel@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-09-14 at 12:05 +0530, Sanchayan Maity wrote:
> Use enable-gpios property of PWM backlight driver for backlight
> control. While at it also fix the use of brightness levels required
> by EDT displays which require inverted PWM's.

That part I am missing below. Did you forget to include it?

> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
> ?arch/arm/boot/dts/imx6qdl-apalis.dtsi | 9 +++++++++
> ?1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 8c67dd8..9100bde 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -49,7 +49,10 @@
> ?
> ?	backlight: backlight {
> ?		compatible = "pwm-backlight";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_bl_on>;
> ?		pwms = <&pwm4 0 5000000>;
> +		enable-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
> ?		status = "disabled";
> ?	};
> ?
> @@ -614,6 +617,12 @@
> ?		>;
> ?	};
> ?
> +	pinctrl_gpio_bl_on: gpioblon {
> +		fsl,pins = <
> +			MX6QDL_PAD_EIM_DA13__GPIO3_IO13 0x1b0b0
> +		>;
> +	};
> +
> ?	pinctrl_gpio_keys: gpio1io04grp {
> ?		fsl,pins = <
> ?			/* Power button */
