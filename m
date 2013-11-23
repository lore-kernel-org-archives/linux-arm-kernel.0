From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 23 Nov 2013 19:37:37 +0100
Subject: [PATCH RESEND 3/5] ARM: brcmstb: add misc. DT bindings for brcm,
 brcmstb
In-Reply-To: <529003BB.9030604@gmail.com>
References: <529003BB.9030604@gmail.com>
Message-ID: <201311231937.38235.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 November 2013, Marc C wrote:
> +This node describes the register block which is used for generic reset control.
> +
> +    - compatible: "brcm,brcmstb-sun-top-ctrl"
> +    - properties:
> +        o reg = <base_of_sun_top_ctrl_regs length>;
> +        o reset-source-enable-reg = <offset_from_base>;
> +        o sw-master-reset-reg = <offset_from_base>;

Normally the "compatible" string identifies the register layout and you keep the
offsets in the device driver. Do you have strong reasons to do it differently
here?

I would also suggest moving this block into a separate file for the reset
controller. Make sure you follow the rules from
Documentation/devicetree/bindings/reset/reset.txt, most importantly adding
a "#reset-cells" property so other drivers can refer to this node using
the reset API.

	Arnd
