From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 9 Jun 2017 17:46:52 +0200
Subject: [PATCH] ARM64: Kconfig: Fix the missing hi655x common clk
In-Reply-To: <CAPDyKFqWptneK2V7wCR8LGbgU7=U9kBCKkHrtgGmZKmNQJ4s7g@mail.gmail.com>
References: <CALAqxLVn9r9R-wnrZbrFqYfwqZD-tegbJrZLsUeBjjBc4_Q89w@mail.gmail.com>
 <1496686434-13181-1-git-send-email-daniel.lezcano@linaro.org>
 <CAPDyKFqWptneK2V7wCR8LGbgU7=U9kBCKkHrtgGmZKmNQJ4s7g@mail.gmail.com>
Message-ID: <20170609154652.GG2244@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 04:17:40PM +0200, Ulf Hansson wrote:
> On 5 June 2017 at 20:13, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > With the addition of the hi655x common clock, the config option is missing
> > for the ARM64's hi6220 platform. That leads to a non functionnal WiFi because
> > the hi655x clock driver misses when initializing the power sequence via DT.
> >
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Wei Xu <xuwei5@hisilicon.com>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Would be nice to get this trivial fix in for 4.12 rcs to make the WiFi
> work for Hikey.
> 

I'm wondering if I submitted this patch for the right path.

Shall it go through arm-soc ?

+Olof, +Arnd

> 
> > ---
> >  arch/arm64/Kconfig.platforms | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> > index 73272f4..6dfe72c 100644
> > --- a/arch/arm64/Kconfig.platforms
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -79,6 +79,7 @@ config ARCH_LG1K
> >  config ARCH_HISI
> >         bool "Hisilicon SoC Family"
> >         select ARM_TIMER_SP804
> > +       select COMMON_CLK_HI655X
> >         select HISILICON_IRQ_MBIGEN if PCI
> >         select PINCTRL
> >         help
> > --
> > 2.7.4
> >

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
