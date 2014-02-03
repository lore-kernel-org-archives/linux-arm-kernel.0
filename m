From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Feb 2014 10:24:34 +0100
Subject: [PATCH 5/5 v2] clk: versatile: respect parent rate in ICST clock
In-Reply-To: <1390254865-15488-1-git-send-email-linus.walleij@linaro.org>
References: <1390254865-15488-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdbyVkq8VQDmoP6-caKoWERMPFdEkgw8EJymbzjeFQpNjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 20, 2014 at 10:54 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:

> If the ICST clock has a parent, respect the rate of the parent
> when calculating the clock frequency. As this involves modifying
> the ICST parameter struct, make a cloned copy (the divisor
> arrays should be safe) so we can update the .ref field.
>
> Do not define the reference clock on the Integrator as we have
> the reference clock from the device tree. Keep it everywhere
> else.
>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - As Russell observed: the params are static objects, so if
>   we want to alter them, we better make a copy of them.
>
> Hi Mike, looking for an ACK for this one as well.

Hi Mike,

Ping on this!

Yours,
Linus Walleij
