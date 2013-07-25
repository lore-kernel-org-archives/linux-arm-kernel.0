From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 26 Jul 2013 00:29:08 +0200
Subject: [RESEND] cpuidle for ARM pull request
In-Reply-To: <51F1A187.5060408@linaro.org>
References: <51E536C5.1020609@linaro.org> <51F1A187.5060408@linaro.org>
Message-ID: <1766778.ZYeDKBOsjV@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 26, 2013 12:07:03 AM Daniel Lezcano wrote:
> On 07/16/2013 02:04 PM, Daniel Lezcano wrote:
> > 
> > Hi,
> > 
> > The first PR was against the linux-pm-next tree including the patch:
> > 
> > "cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq"
> > 
> > This patch has been dropped in the meantime.
> > 
> > Here is a new PR where my tree has been rebased against linux-pm-next
> > and adding the patch mentioned above.
> > 
> > As stated by Rafael, I will handle the ARM specific patches from now.
> > 
> > The following changes since commit 48f99d5a97d32d70c0738d6e314d9f4dbefd89bf:
> > 
> >   Merge branch 'pm-cpuidle-next' into linux-next (2013-07-16 02:41:06 +0200)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next
> > 
> > for you to fetch changes up to 2b7e79f4a75e803184f483985a25cc751a990f06:
> > 
> >   ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle
> > (2013-07-16 13:57:24 +0200)
> 
> ping ?

Sorry, something distracted me.  I'll pull it later today unless there are any
problems (in which case I'll let you know).

Thanks,
Rafael


> > ----------------------------------------------------------------
> > Daniel Lezcano (2):
> >       ARM: davinci: cpuidle: Fix target residency
> >       ARM: ux500: cpuidle: Move ux500 cpuidle driver to drivers/cpuidle
> > 
> > Linus Walleij (2):
> >       ARM: ux500: cpuidle: Instantiate the driver from platform device
> >       ARM: ux500: cpuidle: Remove pointless include
> > 
> > Sahara (1):
> >       cpuidle: Add Kconfig.arm and move calxeda, kirkwood and zynq
> > 
> >  arch/arm/mach-davinci/cpuidle.c                    |    2 +-
> >  arch/arm/mach-ux500/Makefile                       |    1 -
> >  drivers/cpuidle/Kconfig                            |   20 +++++---------
> >  drivers/cpuidle/Kconfig.arm                        |   29
> > ++++++++++++++++++++
> >  drivers/cpuidle/Makefile                           |    9 ++++--
> >  .../cpuidle.c => drivers/cpuidle/cpuidle-ux500.c   |   19 +++++++------
> >  drivers/mfd/db8500-prcmu.c                         |    4 +++
> >  7 files changed, 58 insertions(+), 26 deletions(-)
> >  create mode 100644 drivers/cpuidle/Kconfig.arm
> >  rename arch/arm/mach-ux500/cpuidle.c => drivers/cpuidle/cpuidle-ux500.c
> > (90%)
> > 
> > 
> 
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
