From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 22 Apr 2016 08:41:24 +0200
Subject: [PATCH 5/8] cpufreq: shmobile: Use generic platdev driver
In-Reply-To: <20160422032142.GN29799@vireshk-i7>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
 <ab29df38f70453e67089e3f3dbb9085336eef1c2.1461228081.git.viresh.kumar@linaro.org>
 <CAMuHMdUnzgr==S86Wiz0fGk2gSWW2=j+maiq3=3x9Ozy7AoOZw@mail.gmail.com>
 <20160422032142.GN29799@vireshk-i7>
Message-ID: <CAMuHMdWXH+Oud+ZZbYFUcTN1a0v9_BJbP5cMLxx0tRWHzx4ADQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Fri, Apr 22, 2016 at 5:21 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21-04-16, 15:04, Geert Uytterhoeven wrote:
>> On Thu, Apr 21, 2016 at 10:43 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
>> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
>> > @@ -29,6 +29,18 @@ static const struct of_device_id machines[] = {
>> >         { .compatible = "samsung,exynos5800", },
>> >  #endif
>> >
>>
>> I think an #ifdef CONFIG_ARCH_RENESAS block wouldn't hurt, likewise
>> for the other SoCs.
>> Soon you'll have this file filled with lots of compatible values for random\
>> SoCs...
>
> This is going to be done once per boot and this shouldn't hurt. And for new
> platforms we may do things differently as they are going to use opp-v2 bindings.

I was mainly thinking about kernel size.
If this is done once per boot, the array should be __initconst,
(looking at the code
in next) which is fine as cpufreq_dt_platdev_init() is already __init.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
