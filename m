From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Mar 2012 16:06:51 -0600
Subject: [PATCH 1/4 v7] pinctrl: introduce generic pin config
In-Reply-To: <1331586859-15619-1-git-send-email-linus.walleij@stericsson.com>
References: <1331586859-15619-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4F67ADFB.6000608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2012 03:14 PM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This is a split-off from the earlier patch set which adds generic
> pin configuration for the pin controllers that want it. Since
> we may have a system with mixed generic and custom pin controllers,
> we pass a boolean in the pin controller ops vtable to indicate
> if it is generic.
> 
> ChangeLog v1->v5:
> - Follow parent patch versioning number system.
> - Document the semantic meaning of return values from pin config
>   get functions, so we can iterate over pins and check their
>   properties from debugfs as part of the generic config code.
> - Use proper cast functions in the generic debugfs pin config
>   file.
> - Expand generic config to optionally cover groups too.
> ChangeLog v5->v6:
> - Update to match underlying changes.
> ChangeLog v6->v7:
> - Drop DRIVE_OFF parameter, use bias high impedance for this
> - Delete argument for drive modes push-pull, od and os. These
>   are now just state transitions.
> - Delete slew rate rising/falling due to discussions on on
>   proper semantics
> - Drop config wakeup, struct irq_chip does this for now, add
>   back if need be.
> - Set PIN_CONFIG_END to 0x7fff making room for custom config
>   parameters from 0x8000 and up.
> - Prefix accessor functions with pinconf_

I think this is probably workable. I'm still not totally convinced that
it'll really turn out to be that "generic", but I guess we may as well
try it and see, so:

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
