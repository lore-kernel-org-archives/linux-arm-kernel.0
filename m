From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Nov 2013 23:45:53 +0100
Subject: [PATCH 5/8] gpio: twl4030: Fix regression for twl gpio output
In-Reply-To: <1384396537-3486-6-git-send-email-tony@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-6-git-send-email-tony@atomide.com>
Message-ID: <CACRpkdY22=YFjg_OM+c6cs7hAWnGO+ufa6uAGWGK0KexN+0s0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 3:35 AM, Tony Lindgren <tony@atomide.com> wrote:

> Commit c111feabe2e2 (gpio: twl4030: Cache the direction and output
> states in private data) improved things in general, but caused a
> regression for setting the GPIO output direction.
>
> The change reorganized twl_direction_out() and twl_set() and swapped
> the function names around in the process. While doing that, a bug got
> introduced that's not obvious while reading the patch as it appears
> as no change to the code.
>
> The bug is we now call function twl4030_set_gpio_dataout() twice in
> both twl_direction_out() and twl_set(). Instead, we should first
> call twl_direction_out() in twl_direction_out() followed by
> twl4030_set_gpio_dataout() in twl_set().
>
> This regression probably has gone unnoticed for a long time as the
> bootloader may have set the GPIO direction properly in many cases.
> This fixes at least the LCD panel not turning on omap3 LDP for
> example.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: linux-gpio at vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>
> If this looks OK, I'd like to merge this as a fix via arm-soc tree
> along with the other patches in this series as my later patches
> depend on patches in this series.

Sure:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
