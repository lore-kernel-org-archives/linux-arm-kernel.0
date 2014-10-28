From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 28 Oct 2014 21:31:35 +0100
Subject: [PATCH 4/4] PM / Domains: Let the ->attach_dev() callback return
 an error code
In-Reply-To: <1414507090-516-5-git-send-email-ulf.hansson@linaro.org>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
 <1414507090-516-5-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAMuHMdVn2mfk5v8MQshU0gko+dL9xtCT_zBuqyntHHrmxjwfSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf, Rafael,

On Tue, Oct 28, 2014 at 3:38 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Typically an ->attach_dev() callback would fetch some PM resourses.
>
> Those operations, like for example clk_get() may fail with different
> errors, including -EPROBE_DEFER. Instead of ignoring these errors and
> potentially only print an error message, let's propagate them to give
> callers the option to handle them.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Given that several patch series using ->attach_dev() are already floating
around and will be in -next soon, what is the plan of getting this in?
Doing it ASAP (in v3.18-rc3)?
Delaying this to v3.19-rc2, which will require an atomic fixing of its users?
Any other option?

Gr{oetje,eeting}s,

                        Geert, who's about to resubmit his pm-rmobile patches

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
