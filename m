From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 Jan 2015 10:35:10 +0100
Subject: [PATCH 8/8] PM / Domains: Handle errors from genpd's
 ->attach_dev() callback
In-Reply-To: <1422389625-11730-9-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
 <1422389625-11730-9-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAMuHMdXQ7SUBunaZQs0_xBgnYR2mbwjCVuuy3xe6S1qbyBsUWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 9:13 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> When __pm_genpd_add_device() is invoked through the generic OF-based PM
> domain look-up path, the device is being probed. Returning an error
> will mean the device won't be attached to its PM domain. Errors of
> -EPROBE_DEFER get special treatment and is propagated to the driver

are propagated

> core.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
