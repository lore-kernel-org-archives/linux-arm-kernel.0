From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 22 Apr 2016 08:51:42 +0530
Subject: [PATCH 5/8] cpufreq: shmobile: Use generic platdev driver
In-Reply-To: <CAMuHMdUnzgr==S86Wiz0fGk2gSWW2=j+maiq3=3x9Ozy7AoOZw@mail.gmail.com>
References: <cover.1461228081.git.viresh.kumar@linaro.org>
 <ab29df38f70453e67089e3f3dbb9085336eef1c2.1461228081.git.viresh.kumar@linaro.org>
 <CAMuHMdUnzgr==S86Wiz0fGk2gSWW2=j+maiq3=3x9Ozy7AoOZw@mail.gmail.com>
Message-ID: <20160422032142.GN29799@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-04-16, 15:04, Geert Uytterhoeven wrote:
> Hi Viresh,
> 
> On Thu, Apr 21, 2016 at 10:43 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -29,6 +29,18 @@ static const struct of_device_id machines[] = {
> >         { .compatible = "samsung,exynos5800", },
> >  #endif
> >
> 
> I think an #ifdef CONFIG_ARCH_RENESAS block wouldn't hurt, likewise
> for the other SoCs.
> Soon you'll have this file filled with lots of compatible values for random\
> SoCs...

This is going to be done once per boot and this shouldn't hurt. And for new
platforms we may do things differently as they are going to use opp-v2 bindings.

And, so I am not really in favor of ifdef hackery :)

-- 
viresh
