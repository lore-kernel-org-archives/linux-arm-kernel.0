From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Mar 2012 13:04:28 -0600
Subject: [PATCH v5 15/16] pwm-backlight: Add rudimentary device tree
 support
In-Reply-To: <1332945238-14897-16-git-send-email-thierry.reding@avionic-design.de>
References: <1332945238-14897-1-git-send-email-thierry.reding@avionic-design.de>
 <1332945238-14897-16-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <4F7603BC.2050300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2012 08:33 AM, Thierry Reding wrote:
> This commit adds very basic support for device tree probing. Currently,
> only a PWM and a list of distinct brightness levels can be specified.
> Enabling or disabling backlight power via GPIOs is not yet supported.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>

> diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight b/Documentation/devicetree/bindings/video/backlight/pwm-backlight
> +Required properties:
> +  - compatible: "pwm-backlight"
> +  - pwms: OF device-tree PWM specification (see PWM binding[0])
> +  - num-brightness-levels: number of distinct brightness levels

Do we need the "num-brightness-levels" property at all; it's just the
length of the brightness-levels property.

> +  - brightness-levels: Array of distinct brightness levels. Typically these
> +      are in the range from 0 to 255, but any range starting at 0 will do.
> +      The actual brightness level (PWM duty cycle) will be interpolated
> +      from these values. 0 means a 0% duty cycle (darkest/off), while the
> +      last value in the array represents a 100% duty cycle (brightest).
...> +Example:
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm 0 5000000>;
> +
> +		num-brightness-levels = <8>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +	};
