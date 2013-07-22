From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Jul 2013 00:31:45 +0200
Subject: [PATCH V2 1/5] gpio: clean up gpio-ranges documentation
In-Reply-To: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
References: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <CACRpkdYsZ0aMnANPpTiGuD1U23PCqyvVGS7vOOnOQUks5KSk9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 8:40 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> This change makes documentation of the the gpio-ranges property shorter
> and more succinct, more consistent with the style of the rest of the
> document, and not mention Linux-specifics such as the API
> pinctrl_request_gpio(); DT binding documents should be OS independant
> where at all possible.

This is all good.

> This change also removes any mention of the #gpio-range-cells property.
> Such properties are useful when one node references a second node, and
> that second node dictates the format of the reference. However, that is
> not the case here; the definition of gpio-ranges itself always dictates
> its format entirely, and hence the value #gpio-range-cells must always
> be 3, and hence there is no point requiring any referenced node to
> include this property.
>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Can this mention the newly introduced Backus-Naur Form
description of the ranges.

> ---
> Patches 2-6 need to be applied in the same branch, since they all build
> upon each-other.
> ---

Still waiting for the OF maintainers to ACK so can't apply this. :-(

> +It is useful to represent which GPIOs correspond to which pins on which pin
> +controllers. The gpio-ranges property described below represents this, and
> +contains information strucutres as follows:

speling of strucutres

Should you mention that this is given in BNF?
Or is that implicit for all bindings?

>
> -This makes it logical to let gpio drivers announce their pin ranges to
> -the pin ctrl subsystem and call 'pinctrl_request_gpio' in order to
> -request the corresponding pin before any gpio usage.
> +       gpio-range-list ::= <single-gpio-range> [gpio-range-list]
> +       single-gpio-range ::=
> +                       <pinctrl-phandle> <gpio-base> <pinctrl-base> <count>
> +       gpio-phandle : phandle to pin controller node.
> +       gpio-base : Base GPIO ID in the GPIO controller
> +       pinctrl-base : Base pinctrl pin ID in the pin controller
> +       count : The number of GPIOs/pins in this range

Yours,
Linus Walleij
