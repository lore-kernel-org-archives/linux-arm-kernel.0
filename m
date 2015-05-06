From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 6 May 2015 15:23:48 +0200
Subject: [PATCH] gpio: omap: Allow building as a loadable module
In-Reply-To: <1429833382-28532-1-git-send-email-tony@atomide.com>
References: <1429833382-28532-1-git-send-email-tony@atomide.com>
Message-ID: <CACRpkdapSYfA=SniQQJs_r=X25sw+XujH7UxouU3=RUXNoqdMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 24, 2015 at 1:56 AM, Tony Lindgren <tony@atomide.com> wrote:

> We currently get all kinds of errors building the omap gpio driver
> as a module starting with:
>
> undefined reference to `omap2_gpio_resume_after_idle'
> undefined reference to `omap2_gpio_prepare_for_idle'
> ...
>
> Let's fix the issue by adding inline functions to the header.
> Note that we can now also remove the two unused functions for
> omap_set_gpio_debounce and omap_set_gpio_debounce_time.
>
> Then doing rmmod on the module produces further warnings
> because of missing exit related functions. Let's add those.
>
> And finally, we can make the Kconfig entry just a tristate
> option that's selected for omaps.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Patch applied for v4.2.

Yours,
Linus Walleij
