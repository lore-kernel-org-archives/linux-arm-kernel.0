From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 23 Apr 2013 18:23:05 -0400
Subject: [PATCHv1 3/3] hwmon: Add DT documentation for g762 driver
In-Reply-To: <6ee748f450ba2a80c87aba08c0672105e2800f93.1366753420.git.arno@natisbad.org>
References: <cover.1366753420.git.arno@natisbad.org>
 <6ee748f450ba2a80c87aba08c0672105e2800f93.1366753420.git.arno@natisbad.org>
Message-ID: <20130423222305.GD13884@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 12:06:20AM +0200, Arnaud Ebalard wrote:
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  Documentation/devicetree/bindings/hwmon/g762.txt |   57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/g762.txt b/Documentation/devicetree/bindings/hwmon/g762.txt
> new file mode 100644
> index 0000000..87d7cf5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/g762.txt
> @@ -0,0 +1,57 @@
> +GMT G762/G763 PWM Fan controller
> +
> +Required node properties:
> +
> + - "compatible": must be either "gmt,g762" or "gmt,g763"
> + - "reg": I2C bus address of the device
> +
> +Optional properties:
> +
> + - "pwm_mode": fan driving mode. 1 for PWM mode, 0 for linear. Default
> +               value is 0, i.e. linear.
> +
> + - "pwm_enable": fan speed control. 1 for open-loop, 2 for closed-loop.
> +               Default value is 2, i.e. closed-loop.
> +
> + - "pwm_freq": reference clock frequency for PWM mode in Hz. Default is
> +               32768.
> +
> + - "fan_pulses": number of pulses per fan revolution. Supported values
> +               are 2 and 4. Default is 2.
> +
> + - "fan_div": fan clock frequency divisor value. Supported values are 1,
> +               2, 4 and 8. Default is 1.
> +
> + - "fan_target": initial target fan speed in RPM. By default, current
> +               value is not modified. Only works in closed-loop fan speed
> +	       control, i.e. when pwm_enable has already been set to 2.
> +
> + - "fan_startv": fan startup voltage. Accepted values are 0, 1, 2 and 3.
> +               Default value is 1. The higher the more.
> +
> + - "pwm_polarity": pwm polarity. Accepted values are 0 (positive duty)
> +               and 1 (negative duty). Default is 0 i.e. positive duty.
> +
> + - "fan_gear_mode": fan gear mode. Supported values are 0, 1 and 2.
> +               Default is 0.
> +
> +
> +Additional information on operational parameters for the device is available
> +in Documentation/hwmon/g762. A detailed datasheet for the device is available
> +at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
> +
> +Example g762 node:
> +
> +   g762: g762 at 3e {
> +        compatible = "gmt,g762";
> +   	reg = <0x3e>;
> +   	pwm_mode = <1>;      /* closed-loop control */
> +   	pwm_enable = <2>;    /* PWM mode */
> +   	pwm_freq = <8192>;   /* PWM reference clock freq */
> +   	fan_pulses = <2>;    /* 2 pulses per rev */
> +   	fan_div = <2>;       /* fan clock divisor */
> +   	fan_target = <2000>; /* target fan speed at 2000 RPM */
> +        fan_gear_mode = <0>; /* default */
> +        fan_startv = <1>;    /* default */
> +        pwm_polarity = <0>;  /* default */
> +   };

I was just giving this quick overview and noticed that you have
leading whitespace issues in the above block...

thx,

Jason,
