From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 5 Jun 2013 16:03:40 +0200
Subject: [PATCH 1/3] drivers: pinctrl sleep and idle states in the core
In-Reply-To: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
References: <1370439873-30053-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130605140338.GC2934@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 03:44:31PM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> If a device have sleep and idle states in addition to the
> default state, look up these in the core and stash them in
> the pinctrl state container.
> 
> Add accessor functions for pinctrl consumers to put the pins
> into "default", "sleep" and "idle" states passing nothing but
> the struct device * affected.
> 
> Solution suggested by Kevin Hilman, Mark Brown and Dmitry
> Torokhov in response to a patch series from Hebbar
> Gururaja.
> 
> Cc: Hebbar Gururaja <gururaja.hebbar@ti.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Some nits:

> +	if (IS_ERR(pins->sleep_state))
> +		return 0; /* No default state */

Comment wants to say "sleep state"?

> +	ret = pinctrl_select_state(pins->p, pins->sleep_state);
> +	if (ret)
> +		dev_err(dev, "failed to activate sleep pinctrl state\n");

Better say "pinctrl sleep state"?

> +	if (IS_ERR(pins->idle_state))
> +		return 0; /* No default state */
> +	ret = pinctrl_select_state(pins->p, pins->idle_state);
> +	if (ret)
> +		dev_err(dev, "failed to activate idle pinctrl state\n");

Similar issues here...

Other than that, on all 3 patches:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130605/6151fdf8/attachment.sig>
