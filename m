From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 13 Aug 2015 10:57:38 +0200
Subject: [PATCH 2/9] PM / Domains: Remove dev->driver check for runtime PM
In-Reply-To: <7hfv3onv5c.fsf@deeprootsystems.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-3-git-send-email-lina.iyer@linaro.org>
 <7hfv3onv5c.fsf@deeprootsystems.com>
Message-ID: <CAMuHMdVeffa-jgXuSjDQBKTrhgW-d87OKzs1iXX+4y-9U_AJbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Wed, Aug 12, 2015 at 9:50 PM, Kevin Hilman <khilman@kernel.org> wrote:
> Lina Iyer <lina.iyer@linaro.org> writes:
>
>> Remove check for driver of a device, for runtime PM. Device may be
>> suspended without an explicit driver. This check seems to be vestigial
>> and incorrect in the current context.
>
> This one should probably have been RFC.
>
> For a little more context here, this was uncovered when experimenting
> with using runtime PM for CPU devices which don't have a dev->driver.
>
> This check might have made sense before PM domains, but with PM domains,
> it's entirely possible to have a simple device without a driver and the
> PM domain handles all the necesary PM, so I think this check
> could/should be removed.
>
> Thoughts?

Simple devices without a driver aren't handled automatically.
At minimum, the driver should call pm_runtime_enable(), cfr.
drivers/bus/simple-pm-bus.c.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
