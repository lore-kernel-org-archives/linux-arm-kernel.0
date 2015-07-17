From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Jul 2015 09:58:01 +0200
Subject: [PATCH] Subject: pinctrl: imx1-core: Fix debug output in
 .pin_config_set callback
In-Reply-To: <1437118723-19217-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <55A85B59.5060906@gtsys.com.hk>
 <1437118723-19217-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CACRpkdbzZDLVLgRnj9n3zKNCzYT+pdNDGEfYPN0p5ZA7bO0uUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 9:38 AM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

> imx1_pinconf_set assumes that the array of pins in struct
> imx1_pinctrl_soc_info can be indexed by pin id to get the
> pinctrl_pin_desc for a pin. This used to be correct up to commit
> 607af165c047 which removed some entries from the array and so made it
> wrong to access the array by pin id.
>
> The result of this bug is a wrong pin name in the output for small pin
> ids and an oops for the bigger ones.
>
> This patch is the result of a discussion that includes patches by Markus
> Pargmann and Chris Ruehl.
>
> Fixes: 607af165c047 ("pinctrl: i.MX27: Remove nonexistent pad definitions")
> Cc: stable at vger.kernel.org
> Reported-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Patch applied for fixes with Markus' review tag.

Yours,
Linus Walleij
