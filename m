From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 14 Aug 2015 09:24:49 +0200
Subject: [PATCH 2/9] PM / Domains: Remove dev->driver check for runtime PM
In-Reply-To: <7hwpwylepx.fsf@deeprootsystems.com>
References: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
 <1438731339-58317-3-git-send-email-lina.iyer@linaro.org>
 <7hfv3onv5c.fsf@deeprootsystems.com>
 <CAMuHMdVeffa-jgXuSjDQBKTrhgW-d87OKzs1iXX+4y-9U_AJbg@mail.gmail.com>
 <7hwpwylepx.fsf@deeprootsystems.com>
Message-ID: <CAMuHMdW-T9rUWXsQeffwtXspHbjfGqo_0G4QMB1o0TwTLJAQAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Fri, Aug 14, 2015 at 5:40 AM, Kevin Hilman <khilman@kernel.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> On Wed, Aug 12, 2015 at 9:50 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>> This check might have made sense before PM domains, but with PM domains,
>>> it's entirely possible to have a simple device without a driver and the
>>> PM domain handles all the necesary PM, so I think this check
>>> could/should be removed.
>>>
>>> Thoughts?
>>
>> Simple devices without a driver aren't handled automatically.
>> At minimum, the driver should call pm_runtime_enable(), cfr.
>> drivers/bus/simple-pm-bus.c.
>
> That's correct, and in the proof-of-concept stuff I hacked up and in
> Lina's series, the CPU "devices" do indeed to this.  Without that, they
> wouldn't end up ever taking this codepath through genpd's
> runtime_suspend and power_off hooks.
>
> Also, I'm not sure if your comment was meant to be an objection to the
> patch?  or if you're OK with it.

My comment was purely meant as a response to "it's entirely possible to have a
simple device without a driver and the PM domain handles all the necesary PM".

I have no objections to the patch (read: I'm not sufficiently familiar with
the code to make educated guesses about the side effects of this change ;-).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
