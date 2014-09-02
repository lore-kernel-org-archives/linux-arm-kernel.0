From: horms@verge.net.au (Simon Horman)
Date: Tue, 2 Sep 2014 10:08:54 +0900
Subject: [GIT PULL] Renesas ARM Based SoC r8a7740 CCF and Timers Updates
 for v3.18
In-Reply-To: <20140826091739.GB1210@verge.net.au>
References: <cover.1409030383.git.horms+renesas@verge.net.au>
 <20140826091739.GB1210@verge.net.au>
Message-ID: <20140902010854.GB12650@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 06:17:39PM +0900, Simon Horman wrote:
> On Tue, Aug 26, 2014 at 02:23:57PM +0900, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider these Renesas ARM based SoC r8a7740 CCF and timers updates
> > for v3.18.
> > 
> > These changes are in their own branch as there are SoC and board changes
> > that depend on DT changes, the reverse of the usual branch dependencies.
> 
> This pull request includes a minor conflict in
> arch/arm/mach-shmobile/board-armadillo800eva-reference.c with
> 0eb07c96ee61be10 ("ARM: shmobile: armadillo800eva-reference: Sort
> includes") which is included in the pull request
> "Renesas ARM Based SoC Boards Cleanups For v3.18"
> which is tagged as renesas-boards-cleanups-for-v3.18.

I have withdrawn the boards cleanup pull request and the
conflict above should no longer occur.

> 
> The resolution is to take both.
> The resulting #includes should be:
> 
> #include <linux/clk.h>
> #include <linux/err.h>
> #include <linux/gpio.h>
> #include <linux/io.h>
> #include <linux/kernel.h>
> #include <linux/of_platform.h>
> 
> This resolution can be found in the next branch of the renesas tree.
> 
> > The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:
> > 
> >   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r8a7740-ccf-and-timers-for-v3.18
> > 
> > for you to fetch changes up to 433306747791845677ba662435a9bbbafaa21df3:
> > 
> >   ARM: shmobile: r8a7740: Remove r8a7740_add_standard_devices_dt (2014-08-23 19:58:57 +0900)
> > 
> > ----------------------------------------------------------------
> > Renesas ARM Based SoC R8a7740 CCF and Timers Updates for v3.18
> > 
> > When booting using the r8a7740/armadillo800eva using dt-reference:
> > * Use CCF to initialise clocks via DT
> > * Initialise timers via DT
> > 
> > ----------------------------------------------------------------
> > Simon Horman (4):
> >       ARM: shmobile: r8a7740: Add CMT1 device to DT
> >       ARM: shmobile: armadillo800eva-reference: Enable CMT1 in device tree
> >       ARM: shmobile: armadillo800eva-reference: Do not use r8a7740_add_standard_devices_dt()
> >       ARM: shmobile: r8a7740: Remove r8a7740_add_standard_devices_dt
> > 
> > Ulrich Hecht (4):
> >       ARM: shmobile: r8a7740: clock register bits
> >       ARM: shmobile: r8a7740: add SoC clocks to DTS
> >       ARM: shmobile: r8a7740: add MSTP clock assignments to DT
> >       ARM: shmobile: armadillo800eva-reference: add clock overrides to DTS
> > 
> >  .../boot/dts/r8a7740-armadillo800eva-reference.dts |  17 ++
> >  arch/arm/boot/dts/r8a7740.dtsi                     | 220 ++++++++++++++++++++-
> >  .../board-armadillo800eva-reference.c              |   3 +-
> >  arch/arm/mach-shmobile/r8a7740.h                   |   1 -
> >  arch/arm/mach-shmobile/setup-r8a7740.c             |  18 +-
> >  include/dt-bindings/clock/r8a7740-clock.h          |  77 ++++++++
> >  6 files changed, 317 insertions(+), 19 deletions(-)
> >  create mode 100644 include/dt-bindings/clock/r8a7740-clock.h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
