From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 16 May 2014 17:13:06 +0900
Subject: [PATCH] cpufreq: exynos: Fix the compile error
In-Reply-To: <CAKohpokxDQ8w0-fJsyp+i3pLsq5Qyfyev-W8ZXXj8gbyP11pqQ@mail.gmail.com>
References: <006c01cf70db$7e7f3b90$7b7db2b0$@samsung.com>
 <CAKohpomof3h9GG9WmyehM=H8xP=Qqdx+vtMoy4pkNqCsPvnUbg@mail.gmail.com>
 <CAKohpokxDQ8w0-fJsyp+i3pLsq5Qyfyev-W8ZXXj8gbyP11pqQ@mail.gmail.com>
Message-ID: <02f801cf70de$ad3eac10$07bc0430$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh Kumar wrote:
> 
> And please use Rafael's email id from Maintainers..
> 
> On 16 May 2014 13:25, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 16 May 2014 13:20, Jonghwan Choi <jhbird.choi@samsung.com> wrote:
> >> Commit 7da83a80 ("ARM: EXYNOS: Migrate Exynos specific macros from
> >> plat to
> >> mach")
> >
> > Why do you have a line break here ?
> >
> >> which lands in samsung tree causes build breakage for cpufreq-exynos
> >> like
> >> following:
> >
> > Enter a blank line here..
> >
> >> drivers/cpufreq/exynos-cpufreq.c: In function 'exynos_cpufreq_probe':
> >> drivers/cpufreq/exynos-cpufreq.c:166:2: error: implicit declaration
> >> of function 'soc_is_exynos4210'
> >> [-Werror=implicit-function-declaration]
> >
> > Let these cross 80 columns, don't break them, its unreadable.
> >
> >> drivers/cpufreq/exynos-cpufreq.c:168:2: error: implicit declaration
> >> of function 'soc_is_exynos4212'
> >> [-Werror=implicit-function-declaration]
> >> drivers/cpufreq/exynos-cpufreq.c:168:2: error: implicit declaration
> >> of function 'soc_is_exynos4412'
> >> [-Werror=implicit-function-declaration]
> >> drivers/cpufreq/exynos-cpufreq.c:170:2: error: implicit declaration
> >> of function 'soc_is_exynos5250'
> >> [-Werror=implicit-function-declaration]
> >> cc1: some warnings being treated as errors
> >> make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1
> >> make[2]: *** Waiting for unfinished jobs....
> >> drivers/cpufreq/exynos4x12-cpufreq.c: In function
> 'exynos4x12_set_clkdiv':
> >> drivers/cpufreq/exynos4x12-cpufreq.c:118:2: error: implicit
> >> declaration of function 'soc_is_exynos4212'
> >> [-Werror=implicit-function-declaration]
> >> cc1: some warnings being treated as errors
> >> make[2]: *** [drivers/cpufreq/exynos4x12-cpufreq.o] Error 1
> >> make[1]: *** [drivers/cpufreq] Error 2
> >
> > Two blank lines here.
> >
> >> This fixes above error with getting SoC information via DT instead of
> >> soc_is_exynosXXXX().
> >>
> >> Signed-off-by: Jonghwan Choi <jhbird.choi@samsung.com>
> >> ---
> >>  .../devicetree/bindings/cpufreq/cpufreq-exynos.txt |   18 ++++++++
> >>  drivers/cpufreq/Kconfig.arm                        |    4 +-
> >>  drivers/cpufreq/exynos-cpufreq.c                   |   47
> >> +++++++++++++++++---
> >>  drivers/cpufreq/exynos-cpufreq.h                   |    8 ++++
> >>  drivers/cpufreq/exynos4x12-cpufreq.c               |   11 ++---
> >>  5 files changed, 72 insertions(+), 16 deletions(-)
> >
> > I don't think anybody can call that a fix :)
> >
> > So what you have done is combined 'fix' with 'cleanups or improvements'.
> > That's surely wrong..
> >
Well, I think this is really _fix_ the build error, this adds support DT binding for exynos cpufreq stuff though. Because we cannot cover exynos cpufreq without this and you can see that on current -next tree.

> > Just give a simple fix for this breakage that will go in 3.15 and do
> > the DT stuff in another patch for 3.16..

In 3.15, it should be fine. Please check the -next tree and this should be sent to upstream for 3.16 not 3.15 via samsung tree with the patch (commit ID 7da83a80) which causes the build error.

Thanks,
Kukjin
