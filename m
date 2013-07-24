From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 Jul 2013 21:32:54 +0200
Subject: [PATCH 2/2] clk: fixup argument order when setting VCO parameters
In-Reply-To: <1374594138-17080-3-git-send-email-jonathan.austin@arm.com>
References: <1374594138-17080-1-git-send-email-jonathan.austin@arm.com>
 <1374594138-17080-3-git-send-email-jonathan.austin@arm.com>
Message-ID: <CACRpkdbEiNPG0b89zXKpvNgXtAbsKeV9A9ibgEJCBgNa6vQvCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 5:42 PM, Jonathan Austin
<jonathan.austin@arm.com> wrote:

> The order of arguments in the call to vco_set() for the ICST clocks appears to
> have been switched in error, which results in the VCO not being initialised
> correctly. This in turn stops the integrated LCD on things like Integrator/CP
> from working correctly.
>
> This patch fixes the order and restores the expected functionality.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>

Good catch! Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
You should probably mark this for stable as well.

What I don't understand is why my CLCD VGA output has
been working all the time :-(

I thought this VCO was necessary for that as well,  but apparently
it works with the defaults.

Yours,
Linus Walleij
