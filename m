From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Nov 2012 12:08:44 -0700
Subject: [PATCH v5 07/10] document: devicetree: bind pinconf with pin
 single
In-Reply-To: <1352968600-15345-8-git-send-email-haojian.zhuang@gmail.com>
References: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
 <1352968600-15345-8-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <50B3BE3C.2040600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15/2012 01:36 AM, Haojian Zhuang wrote:
> Add comments with pinconf & gpio range in the document of
> pinctrl-single.

> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt

> +- pinctrl-single,power-source : array of value that are used to configure
> +  power source in the pinmux register. They're value of power source field
> +  and power source mask.
> +
> +		/* power source, mask */
> +		pinctrl-single,power-source = <0x1000 0x1800>;
> +
> +- pinctrl-single,bias : array of value that are used to configure the input
> +  bias in the pinmux register.  They're value of bias field, bias mask,
> +  bias disable value, bias pull down value & bias pull up value.
> +
> +		/* bias, mask, disable, pull down, pull up */
> +		pinctrl-single,bias = <0xc000 0xe000 0 0xa000 0xc000>;
> +
> +- pinctrl-single,input-schmitt : array of value that are used to configure
> +  input schmitt in the pinmux register. They're value of input schmitt field,
> +  mask, & disable value.
> +
> +		/* input schmitt value, mask, disable */
> +		pinctrl-single,input-schmitt = <0x40 0x70 0x40>;

For all 3 of those, the first cell in the property is "value". What does
"value" represent? Surely the properties in the pinmux controller node
itself just specify how to write to the field (so should specify field
mask, and perhaps values for specific enums). However, any "value" to be
actually written to the field should be specified by the pin
configuration (sub) nodes, not the global top-level properties.
