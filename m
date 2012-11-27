From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 27 Nov 2012 14:58:24 +0100
Subject: [PATCH] clk: ux500: assume PRCC clocks are off by default
In-Reply-To: <1354024310-22021-1-git-send-email-linus.walleij@stericsson.com>
References: <1354024310-22021-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAPDyKFrqvtFJZHi3tGQ6x8tyHXv6-S7K8_CrqCYf8TQJ0h6jFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 November 2012 14:51, Linus Walleij <linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> The code for the PRCC clock assumed that on boot all the PRCC
> clocks were on, defining them as enabled. However some such
> clocks like the clock for the GPIO block 6 in the PER2
> peripheral group are not on at all.
>
> This would manifest itself as a GPIO block seeming to be
> clocked and working from the debugfs point of view when
> actually it was not clocked at all.
>
> So instead assume that the PRCC clocks are *not* on, and
> everything starts working. This may cause a few extra writes
> to the enable registers but it's worth it. We cannot read
> the status registers to find out if the clock is on at
> this point as that means we first have to turn on the
> clock to the peripheral cluster.
>
> Reported-by: Lee Jones <lee.jones@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Philippe Begnic <philippe.begnic@st.com>
> Cc: Per Forlin <per.forlin@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Mike: this needs to go into v3.7. (Yes, sorry for not seeing
> this earlier, but the problem did manifest itself in very
> strange ways.) If v3.7 is not possible, make sure to add the

Hold on!

I see what you are trying to solve. But the next problem when going
ahead with this patch is that some clocks, which are default on, will
be kept on unless some client explicit disables it. This is not OK. I
will get back to you with some more ideas how to proceed.

Kind regards
Ulf Hansson
