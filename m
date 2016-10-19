From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 19 Oct 2016 13:34:42 -0400 (EDT)
Subject: [PATCH 1/2] host: ehci-exynos: Convert to use the
 SET_SYSTEM_SLEEP_PM_OPS
In-Reply-To: <CANAwSgTXo_=buNVnD+UjxYXo=bHbptGj+ZXivBiQA6LK+ZjNLg@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1610191331590.1778-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Oct 2016, Anand Moon wrote:

> I might be wrong, below is the kconfig option for PM_SLEEP
> 
>  Symbol: PM_SLEEP [=y]
>  Type  : boolean
>     Defined at kernel/power/Kconfig
>      Depends on: SUSPEND [=y] || HIBERNATE_CALLBACKS [=n]
>      Selects: PM [=y]
> 
> So we cannot set CONFIG_PM_SLEEP=n and CONFIG_PM=y

You have it backward.  We cannot set CONFIG_PM_SLEEP=y and CONFIG_PM=n.
But you can have CONFIG_PM_SLEEP=n and CONFIG_PM=y.

Alan Stern

> I observed at many places were either CONFIG_PM or CONFIG_PM_SLEEP are used.
> 
> So I would like to use SIMPLE_DEV_PM_OPS macro to set struct
> dev_pm_ops exynos_ohci_pm_ops to correct the code.
> 
> Best Regards
> -Anand Moon
> 
> >
> >>
> >> CONFIG_PM_SLEEP=n or
> >> # CONFIG_PM_SLEEP is not set
> >>
> >> > 2. What will be the output with !SUSPEND && !HIBERNATE && PM?
> >>
> >> #
> >> # Power management options
> >> #
> >> # CONFIG_SUSPEND is not set
> >> # CONFIG_HIBERNATION is not set
> >> # CONFIG_PM is not set
> >>
> >> When CONFIG_SUSPEND and CONFIG_HIBERNATION are not set
> >> CONFIG_PM is disabled and so is CONFIG_PM_SLEEP.
> >
> > In my config, the CONFIG_PM was enabled thus the code changes the
> > functionality... Maybe this was intented but I really don't get it from
> > the commit message or from your explanations here.
> >
> > Krzysztof
> 
> 
