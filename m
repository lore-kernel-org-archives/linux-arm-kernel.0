From: olof@lixom.net (Olof Johansson)
Date: Wed, 27 Jun 2018 07:15:45 -0700
Subject: [GIT PULL] ARM: uniphier: fixes for v4.18
In-Reply-To: <CAK7LNATHQMSNV0HoHNm-Lnha3oz7z5fd=iUPcufC0L-AuK9BZg@mail.gmail.com>
References: <CAK7LNARAMcUgV2K1_dDdkupaWdtLqGMz==+huurHJKyW=JVWxQ@mail.gmail.com>
 <20180626174215.spnsyfqh5wk4tzep@localhost>
 <CAK7LNATHQMSNV0HoHNm-Lnha3oz7z5fd=iUPcufC0L-AuK9BZg@mail.gmail.com>
Message-ID: <20180627141545.ux2nzpgqxunhdcpb@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 12:51:43PM +0900, Masahiro Yamada wrote:
> Hi Olof,
> 
> 2018-06-27 2:42 GMT+09:00 Olof Johansson <olof@lixom.net>:
> > Hi,
> >
> > On Mon, Jun 25, 2018 at 11:13:04PM +0900, Masahiro Yamada wrote:
> >> Hi Arnd, Olof,
> >>
> >> Please pull some fixes of ARM UniPhier platform.
> >>
> >>
> >>
> >> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> >>
> >>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> >>
> >> are available in the git repository at:
> >>
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
> >> tags/uniphier-fixes-v4.18
> >>
> >> for you to fetch changes up to 4e62893c25bd3d5758058e15958364df3ca15fbc:
> >>
> >>   arm64: uniphier: select RESET_CONTROLLER (2018-06-25 23:00:31 +0900)
> >>
> >> ----------------------------------------------------------------
> >> UniPhier ARM SoC fixes for v4.18
> >>
> >>  - add missing cooling device properties for CPUS
> >>  - fix widget name of headphone
> >>  - select RESET_CONTROLLER
> >
> > It's unclear to me what the severity of these fixes are. and I think the
> > headphone widget name is the only bug that's causing problems for someone using
> > this kernel, is that correct?
> 
> Right.
> The others are on the boundary.
> The criteria on those is different by maintainers
> because some pull and some do not.
> 
> 
> > If so, it would also be useful to get a "Fixes:" tag for it, seems like it
> > should be:
> >
> > Fixes: fb21a0acaa2b7 ("arm64: dts: uniphier: add sound node")
> > Care to resubmit with just the bugfix? Or, if it's easier, I can cherry-pick
> > just that fix at this end and add the Fixes line. You should queue the other
> > patches up for 4.19 and include in those pull requests.
> 
> If you care to cherry-pick with Fixes: tag,
> that would be good.

Great, done now -- cherry-picked "arm64: dts: uniphier: fix widget name of
headphone for LD11/LD20 boards" into fixes.


-Olof
