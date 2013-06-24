From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Jun 2013 14:37:16 +0200
Subject: [PATCH] pinctrl: document the pinctrl PM states
In-Reply-To: <20130617180212.GU20992@atomide.com>
References: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
 <51BA1FE7.4000900@wwwdotorg.org>
 <CACRpkdZV7R3MgbuvEMhs24YYv2hK8Kt9Kjmv_cpRQQ1NYviDQg@mail.gmail.com>
 <51BB3A2C.608@wwwdotorg.org> <20130617072021.GB4465@atomide.com>
 <CACRpkdYwGHMznjoJqf5bX_74pmeKSiWtTwpNF1_4GSEk+KwrZA@mail.gmail.com>
 <20130617180212.GU20992@atomide.com>
Message-ID: <CACRpkdY7hF+9s0f64yc09DHLFQCjzzhPoS-ypBmgit=kFFD0Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 8:02 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Linus Walleij <linus.walleij@linaro.org> [130617 09:11]:

>> Bear in mind that struct pinctl * forks effects in two paths,
>> one is muxing the other is config, like pull-ups etc.
>
> I also thought the plan was to merge pinmux and pinconf and
> do things based the named modes?

That is done from a consumer point of view.
Consumers only care about pinctrl * handles
and pinctrl_state * switches.

> The last time I tried using the pinconf functions it involved
> knowing the name of the pin in the consumer driver. The name
> may not be very descriptive in the device tree cases at least
> for the pinctrl-single. So I did not pay much attention to
> the pinconf functions.

Consumers should not use that interface, i.e.:

int pin_config_get(const char *dev_name, const char *name,
                                unsigned long *config);
int pin_config_set(const char *dev_name, const char *name,
                                 unsigned long config)

This needs to be deleted from <linux/pinctrl/consumer.h>
I'll see if I can get rid of it pronto to avoid any more confusion
and sorry for leaving that in place for too long.

The proper way to use it is to use the states.

Yours,
Linus Walleij
