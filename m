From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 29 Oct 2014 10:32:14 +0100
Subject: [PATCH 4/4] PM / Domains: Let the ->attach_dev() callback return
 an error code
In-Reply-To: <CAPDyKFpuhXx=G2yOZJK4SiUOh3OV7GzdzwrC8UK4_5et1arCag@mail.gmail.com>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
 <1414507090-516-5-git-send-email-ulf.hansson@linaro.org>
 <CAMuHMdVn2mfk5v8MQshU0gko+dL9xtCT_zBuqyntHHrmxjwfSA@mail.gmail.com>
 <CAPDyKFpuhXx=G2yOZJK4SiUOh3OV7GzdzwrC8UK4_5et1arCag@mail.gmail.com>
Message-ID: <CAMuHMdUgO7cyV+egGJrcxL+Ge5K6tfPgbPwpFrLQrmq2yUQSZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Wed, Oct 29, 2014 at 10:26 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 28 October 2014 21:31, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Tue, Oct 28, 2014 at 3:38 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> Typically an ->attach_dev() callback would fetch some PM resourses.
>>>
>>> Those operations, like for example clk_get() may fail with different
>>> errors, including -EPROBE_DEFER. Instead of ignoring these errors and
>>> potentially only print an error message, let's propagate them to give
>>> callers the option to handle them.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Given that several patch series using ->attach_dev() are already floating
>> around and will be in -next soon, what is the plan of getting this in?
>> Doing it ASAP (in v3.18-rc3)?
>> Delaying this to v3.19-rc2, which will require an atomic fixing of its users?
>> Any other option?
>
> I would prefer if we consider 3.18-rc[x|. That's applies also to the
> below patchset, which actually fixes an issue. It would simplify the
> process of handling other SOC specific patches which adds PM domain
> support.
>
> [PATCH v3 0/9] PM / Domains: Fix race conditions during boot

v3.18-rc[x] sounds fine.

> Obviously the patches needs to be reviewed, I guess we are still in
> the process of doing that.

Indeed.

Perhaps we can get just the prototype change of ->attach_dev() in first?
That leaves some time for reviewing the code changes to actually handle
the return value, and unblocks platform patches using ->attach_dev() soon,
which are planned to enter in v3.19-rc.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
