From: tony@atomide.com (Tony Lindgren)
Date: Wed, 7 Nov 2012 17:37:12 -0800
Subject: [PATCH v4 5/9] document: devicetree: bind pinconf with pin-single
In-Reply-To: <1352301582-12244-6-git-send-email-haojian.zhuang@gmail.com>
References: <1352301582-12244-1-git-send-email-haojian.zhuang@gmail.com>
 <1352301582-12244-6-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121108013711.GW6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Haojian Zhuang <haojian.zhuang@gmail.com> [121107 07:22]:
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> @@ -14,9 +16,33 @@ Optional properties:
>  - pinctrl-single,function-off : function off mode for disabled state if
>    available and same for all registers; if not specified, disabling of
>    pin functions is ignored
> +
>  - pinctrl-single,bit-per-mux : boolean to indicate that one register controls
>    more than one pin
>  
> +- pinctrl-single,power-source-mask : mask of setting power source in
> +  the pinmux register

My non-native english suggests:

- pinctrl-single,power-source-mask : mask for setting the power source in
  the pinmux register

> +- pinctrl-single,power-source : value of setting power source field
> +  in the pinmux register

- pinctrl-single,power-source : value for setting the power source field
  in the pinmux register

> +- pinctrl-single,bias-mask : mask of setting bias value in the pinmux
> +  register
> +
> +- pinctrl-single,bias-disable : value of disabling bias in the pinmux
> +  register
> +
> +- pinctrl-single,bias-pull-down : value of setting bias pull down in
> +  the pinmux register
> +
> +- pinctrl-single,bias-pull-up : value of setting bias pull up in the
> +  pinmux register
> +
> +- pinctrl-single,bias : value of setting bias in the pinmux register
> +
> +- pinctrl-single,input-schmitt-mask : mask of setting input schmitt
> +  in the pinmux register

And the same for the rest.

> @@ -42,6 +68,25 @@ Where 0xdc is the offset from the pinctrl register base address for the
>  device pinctrl register, 0x18 is the desired value, and 0xff is the sub mask to
>  be used when applying this change to the register.
>  
> +
> +Optional sub-node: In case some pins could be configured as GPIO in the pinmux
> +register. If both GPIO nubmer and pin base of those pins are in ascending order,
> +those pins could be defined as a GPIO range. The sub-node should be defined in
> +.dtsi files of those silicons.

I suggest you update the above to say:

Optional sub-node: In case some pins can be configured as GPIO in the pinmux
register. If both the GPIO number and pin base of those pins are in ascending
order, these pins can be defined as a GPIO range.

Then maybe clarify the sub-node part a bit, or just leave it out? Actually the
"ascending order" part is a bit unclear to me too..

Regards,

Tony
