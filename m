From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 19 May 2012 21:27:18 +0200
Subject: [GIT PULL] Renesas Emma Mobile EV2 SoC and KZM9D board support
 for v3.5
In-Reply-To: <CAOesGMgZ_rDFCQf33JYZmTLgzzyGm2w9Cfc1dmw1E7T74mwaxA@mail.gmail.com>
References: <201205182344.59703.rjw@sisk.pl> <201205182355.47754.rjw@sisk.pl>
 <CAOesGMgZ_rDFCQf33JYZmTLgzzyGm2w9Cfc1dmw1E7T74mwaxA@mail.gmail.com>
Message-ID: <201205192127.18612.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, May 19, 2012, Olof Johansson wrote:
> Hi,
> 
> On Fri, May 18, 2012 at 2:55 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > Hi,
> >
> > Please pull changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3
> >
> >    Linux 3.4-rc6
> >
> > with top-most commit 450cca47d65b7500ba05d56770adbf8c758dc87d
> >
> >    mach-shmobile: Use DT_MACHINE for KZM9D V3
> >
> > from the git repository at:
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git emev2
> >
> > to receive commits adding support for the Emma Mobile EV2 SoC and the KZM9D
> > board targeted at v3.5.
> >
> > This is based on material that I have just sent another pull request for.
> >
> > Thanks!
> >
> >
> >  arch/arm/boot/dts/emev2-kzm9d.dts           |   26 ++
> >  arch/arm/boot/dts/emev2.dtsi                |   63 ++++
> >  arch/arm/mach-shmobile/Kconfig              |   11 +
> >  arch/arm/mach-shmobile/Makefile             |    3 +
> >  arch/arm/mach-shmobile/board-kzm9d.c        |   85 +++++
> >  arch/arm/mach-shmobile/clock-emev2.c        |  249 +++++++++++++++
> >  arch/arm/mach-shmobile/include/mach/emev2.h |   19 ++
> >  arch/arm/mach-shmobile/platsmp.c            |   18 +
> >  arch/arm/mach-shmobile/setup-emev2.c        |  452 +++++++++++++++++++++++++++
> >  arch/arm/mach-shmobile/smp-emev2.c          |   97 ++++++
> >  drivers/gpio/Kconfig                        |    6 +
> >  drivers/gpio/Makefile                       |    1 +
> >  drivers/gpio/gpio-em.c                      |  418 +++++++++++++++++++++++++
> >  include/linux/platform_data/gpio-em.h       |   10 +
> >  14 files changed, 1458 insertions(+), 0 deletions(-)
> 
> This is a bit odd. The pull request says "since v3.4-rc6", but the
> branch is built on top of renesas/soc-core, so if I do a "git diff
> --stat v3.4-rc6 FETCH_HEAD" I see the whole diffstat which doesn't
> match. Did you mix and match the diffstat and the rest of the pull
> request output, per chance?
> 
> > ---------------
> >
> > Magnus Damm (8):
> >      gpio: Emma Mobile GPIO driver V2
> >      mach-shmobile: Emma Mobile EV2 SoC base support V3
> >      mach-shmobile: KZM9D board support V3
> >      mach-shmobile: Emma Mobile EV2 SMP support V3
> >      mach-shmobile: Emma Mobile EV2 GPIO support V3
> >      mach-shmobile: KZM9D board Ethernet support V3
> >      mach-shmobile: Emma Mobile EV2 DT support V3
> >      mach-shmobile: Use DT_MACHINE for KZM9D V3
> 
> I was mislead for a while when looking at the contents here since you
> introduce the board file without DT_MACHINE and switch in a later
> commit. It would have been a bit cleaner to squash it in and add it
> that way directly, especially since it's otherwise not buildable.
> Anyway, not a huge deal.
> 
> Also, please remember to use ARM: shmobile: as prefix in the future.
> 
> All that being said, I've pulled this in as renesas/emev2 and into
> next/soc.

Thanks!

> There's an add/add conflict between this and the kzm9g board
> addition but it's trivial to resolve; please double-check the for-next
> contents in arm-soc though.

I will.

> In the future, given the organization of arm-soc, it would be better
> to do the SoC portion in one branch, and the board pieces on top of
> that (in a separate branch that includes the SoC pieces), and send
> them up separately. Main reason for that is because we try to separate
> those two as topics. Again, not a huge deal but it would help a bit,
> and I don't think it'll hinder your work flow too much.

Sure, I'll remeber about that in the future.

Many thanks,
Rafael
