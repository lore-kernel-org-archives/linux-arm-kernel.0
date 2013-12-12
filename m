From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 19:15:57 +0100
Subject: [PATCH] pinctrl: pinconf: remove checks on ops->pin_config_get
In-Reply-To: <1386585509-12495-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1386585509-12495-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CACRpkdbjo-E2=V3yyxJ2ofwhj_JPT0=txy9JtS0yb2RWSK51ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 9, 2013 at 11:38 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> ops->pin_config_get() is only used in one specific path that will only be taken
> for generic pinconf drivers (ops->is_generic == true) when dumping the pinconf
> by using debugfs.
>
> By removing the check in pinconf_check_ops(), let's stop pressuring people to
> write a pin_config_get() function that will never be used and so will probably
> never be tested.
>
> Removing the check in pinconf_pins_show() allows driver to not implement
> pin_config_get() but still get a dump of the pinconf in debugfs by implementing
> pin_config_dbg_show().
>
> Finally, not implementing pin_config_get() now results in returning -ENOTSUPP
> instead of -EINVAL. While this doesn't have any real impact for now, this feels
> more right.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Yeah hm, OK patch applied.

For non-generic pinconf drivers this is more helpful.

Getting pin config or pin multiplexing from the hardware is
somewhat unimplemented in many drivers, that is one of the
holes we need to work on...

Yours,
Linus Walleij
