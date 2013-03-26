From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Tue, 26 Mar 2013 08:37:09 +0100
Subject: [PATCH V5 9/9] pwm_bl: Add mandatory backlight power regulator
In-Reply-To: <1364260913-25490-10-git-send-email-achew@nvidia.com>
References: <1364260913-25490-1-git-send-email-achew@nvidia.com>
 <1364260913-25490-10-git-send-email-achew@nvidia.com>
Message-ID: <20130326073709.GB31388@avionic-0098.mockup.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 06:21:53PM -0700, Andrew Chew wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> index 1e4fc72..cb2d46a 100644
> --- a/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> +++ b/Documentation/devicetree/bindings/video/backlight/pwm-backlight.txt
> @@ -10,6 +10,11 @@ Required properties:
>        last value in the array represents a 100% duty cycle (brightest).
>    - default-brightness-level: the default brightness level (index into the
>        array defined by the "brightness-levels" property)
> +  - power-supply: A phandle to the regulator device tree node. This
> +      regulator will be turned on and off as the pwm is enabled and disabled.

Please use "PWM" instead of "pwm" in prose.

>  Optional properties:
>    - pwm-names: a list of names for the PWM devices specified in the
> @@ -19,10 +24,19 @@ Optional properties:
>  
>  Example:
>  
> +	bl_en: fixed-regulator {
> +                compatible = "regulator-fixed";
> +                regulator-name = "bl-en-supply";
> +                regulator-boot-on;
> +                gpio = <&some_gpio>;
> +                enable-active-high;
> +	};

This uses a mix of tabs and spaces for indentation. Please stick to
tabs.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130326/5f2190e7/attachment.sig>
