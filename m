From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 14:28:02 +0200
Subject: [RFC PATCH 3/3] ARM: at91/dt: move sama5 to generic pinconf
In-Reply-To: <1377380400-11331-1-git-send-email-b.brezillon@overkiz.com>
References: <1377379926-11163-1-git-send-email-b.brezillon@overkiz.com>
 <1377380400-11331-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <CACRpkdbGWAg19Redc-KB4=dUnNOqCVvFN4H=wAAoki6Y=Zp-wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 24, 2013 at 11:40 PM, Boris BREZILLON
<b.brezillon@overkiz.com> wrote:

> Add generic pinconf definitions and reference appropriate configs in
> atmel,pins properties.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
(...)
>                         pinctrl at fffff200 {
>                                 #address-cells = <1>;
>                                 #size-cells = <1>;
> -                               compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "simple-bus";
> +                               compatible = "atmel,at91sam9x5-pinctrl", "atmel,at91rm9200-pinctrl", "generic-pinconf", "simple-bus";

What kind of compatible string is that "generic-pinconf"?

There is no driver that can instantiate against this string but I'm not
100% sure about such things. Is there some other driver doing this?

Else I think it'd just be removed.

> +                               pcfg_none: pcfg_none {
> +                                       bias-disable;
> +                               };
> +
> +                               pcfg_pull_up: pcfg_pull_up {
> +                                       bias-pull-up;
> +                               };

Nice.

> +                               pcfg_deglitch: pcfg_deglitch {
> +                                       input-deglitch = <1>;
> +                               };
> +
> +                               pcfg_pull_up_deglitch: pcfg_pull_up_deglitch {
> +                                       bias-pull-up;
> +                                       input-deglitch = <1>;
> +                               };

input-deglitch seems like a proposed generic binding but I haven't seen
these yet?

(It might be in my violently exploding INBOX though sorry in that case.)

This would need adding to
Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
Plus changes to pinctrl core for handling.

BTW: this is really moving in the right direction!

Yours,
Linus Walleij
