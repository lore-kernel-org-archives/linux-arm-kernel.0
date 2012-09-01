From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Sep 2012 02:14:07 +0200
Subject: [PATCH v2] ARM: ks8695: convert to generic time and clocksource
In-Reply-To: <1346456995-21572-1-git-send-email-linus.walleij@linaro.org>
References: <1346456995-21572-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdY0i77U5kGoNzWj2KwtyJ=ayptNGTE_7=95tJ0v4Tv5xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 1, 2012 at 1:49 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> Old platforms using ancient gettimeoffset() and other arcane
> APIs are standing in the way of cleaning up the ARM kernel.
>
> This is an attempt at blind-coding a generic time and clocksource
> driver for the platform by way of a datasheet and looking at the
> old code, it'd be great if someone who is actually using this
> machine could test it.
>
> If noone volunteers to do this I will instead propose a patch
> deleting the machine altogether.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Corrected the mask when setting clockevents from & TMCON_T1EN
>   to & ~TMCON_T1EN so it doesn't shut down the clock source.

BTW: Greg if this would happen to work - could you try to enable
CONFIG_TICK_ONESHOT and CONFIG_NO_HZ as well to see
if we can work fine in oneshot mode as well?

Yours,
Linus Walleij
