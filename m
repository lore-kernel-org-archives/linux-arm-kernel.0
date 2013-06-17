From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 18:05:18 +0200
Subject: [PATCH] pinctrl: document the pinctrl PM states
In-Reply-To: <20130617072021.GB4465@atomide.com>
References: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
 <51BA1FE7.4000900@wwwdotorg.org>
 <CACRpkdZV7R3MgbuvEMhs24YYv2hK8Kt9Kjmv_cpRQQ1NYviDQg@mail.gmail.com>
 <51BB3A2C.608@wwwdotorg.org> <20130617072021.GB4465@atomide.com>
Message-ID: <CACRpkdYwGHMznjoJqf5bX_74pmeKSiWtTwpNF1_4GSEk+KwrZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 9:20 AM, Tony Lindgren <tony@atomide.com> wrote:

> First, I think the concept of remuxing (or even checking) _all_ the pins
> for a consumer device is wrong on most if not all hardware. For past 10
> years I have not seen a case where _all_ the pins for a device would need
> to be remuxed for any reason.

We may be talking past each other here. On the ux500 we use a lot
of runtime pincontrol, but none of this is *remuxing*.

We are only *reconfiguring*.

Now I know that Haojian only recently added pin config to the
pinctrl-single.c driver so maybe you have mostly seen muxing
in your driver so far, so you view of the world is a bit different.

On the Nomadik pin controller we do mostly hogged muxing
at boot time, but a lot of runtime reconfiguration. So our
needs are very different.

Bear in mind that struct pinctl * forks effects in two paths,
one is muxing the other is config, like pull-ups etc.

Yours,
Linus Walleij
