From: horms@verge.net.au (Simon Horman)
Date: Sun, 20 Jul 2014 22:51:25 +0900
Subject: [GIT PULL] Renesas ARM Based SoC DT Timers Updates for v3.17
In-Reply-To: <20140719052758.GE20064@quad.lixom.net>
References: <cover.1405556312.git.horms+renesas@verge.net.au>
 <20140719052758.GE20064@quad.lixom.net>
Message-ID: <20140720135125.GB31336@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 10:27:58PM -0700, Olof Johansson wrote:
> On Thu, Jul 17, 2014 at 09:40:20AM +0900, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC DT Timers updates for v3.17.
> > 
> > This pull request is based on a merge of the following to provide
> > all dependencies and try to eliminate conflicts. It turns out the changes
> > in this pull requests are a nexus for dependencies due to modifying DT,
> > SoC, board and recently moved header files as well as requiring driver
> > changes.
> > 
> > * The clockevents/renesas-timers-dt branch of Daniel Lezcano's tree.
> >   He has indicated that this branch has stable commit ids and will
> >   be included in v3.17. Olof and arm at kernel.org were CCed on the
> >   thread where he, Laurent Pinchart and I discussed the use of that branch.
> > 
> >   The clockevents/renesas-timers-dt's branch is in turn based on v3.16-rc3.
> > 
> > * "Third Round of Renesas ARM Based SoC DT Updates for v3.17",
> >   tagged as renesas-dt3-for-v3.17, which I have sent a pull request for.
> > 
> > * "Renesas ARM Based SoC Clock Updates for v3.17",
> >   tagged as renesas-clock-for-v3.17, which you have merged
> >   into next/soc
> > 
> > * "Second Round of Renesas ARM Based SoC soc-cleanup Updates for v3.17",
> >   tagged as renesas-soc-cleanup2-for-v3.17, which you have merged
> >   into next/cleanup.
> > 
> > * "Third Round of Renesas ARM Based SoC r8a7779 Multiplatform Updates for
> >   v3.17", tagged as renesas-r8a7779-multiplatform3-for-v3.17, which
> >   you have merged into next/soc
> > 
> > * "Renesas ARM Based SoC Boards Updates for v3.17",
> >   tagged as renesas-boards-for-v3.17, which you have merged
> >   into next/boards
> > 
> > * "Third Round of Renesas ARM Based SoC Updates for v3.17",
> >   tagged as renesas-soc3-for-v3.17, which you have merged
> >   into next/soc
> > 
> > 
> > The following changes since commit 5c174afd407acc7a90701900b279578151bc007f:
> > 
> >   Merge branch 'clockevents/renesas-timers-dt' of git://git.linaro.org/people/daniel.lezcano/linux into dt-timers-for-v3.17.base (2014-07-15 16:31:45 +0900)
> > 
> > are available in the git repository at:
> > 
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-timers-for-v3.17
> > 
> > for you to fetch changes up to 9394af4314554d15762585a3464cefaa2e6d0420:
> > 
> >   ARM: shmobile: genmai-reference: Enable MTU2 in device tree (2014-07-15 21:26:42 +0900)
> > 
> > ----------------------------------------------------------------
> > Renesas ARM Based SoC DT Timers Updates for v3.17
> > 
> > * Enable timers using DT when booting boards without Legacy-C code
> > 
> > ----------------------------------------------------------------
> > Laurent Pinchart (8):
> >       ARM: shmobile: r8a7790: Add CMT devices to DT
> >       ARM: shmobile: r8a7791: Add CMT devices to DT
> >       ARM: shmobile: r8a7779: Add TMU devices to DT
> >       ARM: shmobile: lager-reference: Enable CMT0 in device tree
> >       ARM: shmobile: koelsch-reference: Enable CMT0 in device tree
> >       ARM: shmobile: marzen-reference: Enable TMU0 in device tree
> >       ARM: shmobile: r7s72100: Add MTU2 device to DT
> >       ARM: shmobile: genmai-reference: Enable MTU2 in device tree
> 
> Ok, this branch definitely contains a lot more than this. For dependent
> external branches such as clocksource, we still prefer to see a pull request so
> that we can merge in the dependency and get a clean diffstat when we do the
> merge of your branch, otherwise it gets awkward to compare that what we're
> getting is what you thought you sent (which is one of the things we check on
> merges).
> 
> Please regenerate this pull request as appropriate.

Hi Olof,

FWIW, I believe that that the diffstat between
5c174afd407acc7a90701900b279578151bc007f and
9394af4314554d15762585a3464cefaa2e6d0420 is what was included in the
pull-request. But I guess that all the merged-in branches are hampering
your verification process.

Would it help if things were arranged as follows?

1. Use the clocksource branch as a base and then;
2. Merge in each of my branches (the ones listed above) and then;
3. Add the patches on top
