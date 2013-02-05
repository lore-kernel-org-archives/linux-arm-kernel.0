From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Feb 2013 10:03:47 +0800
Subject: [GIT PULL] imx6q cpuidle for 3.9
In-Reply-To: <20130130131920.GD2757@S2101-09.ap.freescale.net>
References: <20130129054635.GA21504@S2101-09.ap.freescale.net>
 <20130129175028.GC17935@quad.lixom.net>
 <20130130131920.GD2757@S2101-09.ap.freescale.net>
Message-ID: <20130205020344.GA11039@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 09:19:22PM +0800, Shawn Guo wrote:
> On Tue, Jan 29, 2013 at 09:50:28AM -0800, Olof Johansson wrote:
> > This has some small conflicts with the cleanup branch. Can you please base it
> > on top of cleanup so we can avoid the merge conflicts when things go upstream?
> > It's common to have the per-soc cleanup branches as bases for some of the
> > feature branches just for this reason.
> > 
> Ok, done as below.
> 
Ping?

Shawn

> The following changes since commit 1d7180e24e22a608cc4d7e8fd425a19a9394a7ed:
> 
>   Merge tag 'imx-cleanup-3.9' into imx6q-cpuidle (2013-01-30 21:07:14 +0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx6q-cpudile-3.9
> 
> for you to fetch changes up to e5f9dec8ff5ff3f6254412abed1f68d758f6616b:
> 
>   ARM: imx6q: support WAIT mode using cpuidle (2013-01-30 21:09:31 +0800)
> 
> ----------------------------------------------------------------
> imx6q cpuidle support for 3.9
> 
>  - It's based on imx-cleanup-3.9 to avoid conflicts.
> 
> ----------------------------------------------------------------
> Shawn Guo (4):
>       ARM: imx: return zero in case next event gets a large increment
>       ARM: imx: mask gpc interrupts initially
>       ARM: imx: move imx6q_cpuidle_driver into a separate file
>       ARM: imx6q: support WAIT mode using cpuidle
> 
>  arch/arm/mach-imx/Makefile        |    6 ++-
>  arch/arm/mach-imx/clk-imx6q.c     |   12 +++++
>  arch/arm/mach-imx/common.h        |    3 ++
>  arch/arm/mach-imx/cpuidle-imx6q.c |   95 +++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/cpuidle.h       |    5 ++
>  arch/arm/mach-imx/gpc.c           |    5 ++
>  arch/arm/mach-imx/mach-imx6q.c    |   17 +++----
>  arch/arm/mach-imx/platsmp.c       |   10 ++++
>  arch/arm/mach-imx/time.c          |    3 +-
>  9 files changed, 143 insertions(+), 13 deletions(-)
>  create mode 100644 arch/arm/mach-imx/cpuidle-imx6q.c
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
