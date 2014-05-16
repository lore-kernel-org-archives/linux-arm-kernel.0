From: horms@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:51:00 +0900
Subject: [GIT PULL] Renesas SoC Clock Cleanups for v3.16
In-Reply-To: <cover.1399967755.git.horms+renesas@verge.net.au>
References: <cover.1399967755.git.horms+renesas@verge.net.au>
Message-ID: <20140516005100.GA13595@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ Corrected truncatedsubject: These updates are for v3.16 not v3.1 ]

On Tue, May 13, 2014 at 05:03:41PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas SoC Clock Cleanups for v3.16.
> 
> This pull request is based a merge of the following to provide dependencies
> and avoid conflicts.
> 
> * Renesas ARM Based SoC Board Updates for v3.16,
>   tagged as renesas-boards-for-v3.16, which you have already pulled.
> 
> * Renesas ARM Based SoC Clock Updates for v3.16,
>   tagged as renesas-clock-for-v3.16, which you have already pulled.
> 
> * The cmt-mtu2-tmu-cleanups-for-v3.16 branch of
>   Daniel Lezcano's tree.
> 
>   git://git.linaro.org/people/daniel.lezcano/linux.git clockevents/cmt-mtu2-tmu-cleanups
> 
> 
> The following changes since commit 1c41ecb60b3de08d341be13de1dfc3d907b82694:
> 
>   Merge branch 'clockevents/cmt-mtu2-tmu-cleanups' of git://git.linaro.org/people/daniel.lezcano/linux into cmt-mtu2-tmu-cleanups-for-v3.16 (2014-04-23 10:01:02 +0900)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock-cleanup2-for-v3.16
> 
> for you to fetch changes up to c17fcfbcc0f6b4f3cae761149e1a6108dd6750e7:
> 
>   ARM: shmobile: r7s72100: Switch to new style MTU2 device (2014-05-11 19:35:28 +0900)
> 
> ----------------------------------------------------------------
> Renesas SoC Clock Cleanups for v3.16
> 
> Work from Laurent Pinchart to switch all Renesas platforms to the new style
> CMT, MTU2 and TMU device platform data. This is in preparation for
> initialising these devices using DT on ARM Based Renesas SoCs.
> 
> ----------------------------------------------------------------
> Laurent Pinchart (15):
>       sh: Switch to new style CMT device
>       ARM: shmobile: sh7372: Switch to new style CMT device
>       ARM: shmobile: sh73a0: Switch to new style CMT device
>       ARM: shmobile: r8a73a4: Switch to new style CMT device
>       ARM: shmobile: r8a7740: Switch to new style CMT device
>       ARM: shmobile: r8a7790: Switch to new style CMT device
>       ARM: shmobile: r8a7791: Switch to new style CMT device
>       sh: Switch to new style TMU device
>       ARM: shmobile: sh7372: Switch to new style TMU device
>       ARM: shmobile: sh73a0: Switch to new style TMU device
>       ARM: shmobile: r8a7740: Switch to new style TMU device
>       ARM: shmobile: r8a7778: Switch to new style TMU device
>       ARM: shmobile: r8a7779: Switch to new style TMU device
>       sh: Switch to new style MTU2 device
>       ARM: shmobile: r7s72100: Switch to new style MTU2 device
> 
>  arch/arm/mach-shmobile/board-koelsch-reference.c |   2 +-
>  arch/arm/mach-shmobile/board-lager-reference.c   |   2 +-
>  arch/arm/mach-shmobile/clock-r7s72100.c          |   2 +-
>  arch/arm/mach-shmobile/clock-r8a73a4.c           |   2 +-
>  arch/arm/mach-shmobile/clock-r8a7740.c           |  10 +-
>  arch/arm/mach-shmobile/clock-r8a7778.c           |   4 +-
>  arch/arm/mach-shmobile/clock-r8a7779.c           |   4 +-
>  arch/arm/mach-shmobile/clock-r8a7790.c           |   2 +-
>  arch/arm/mach-shmobile/clock-r8a7791.c           |   2 +-
>  arch/arm/mach-shmobile/clock-sh7372.c            |   9 +-
>  arch/arm/mach-shmobile/clock-sh73a0.c            |   5 +-
>  arch/arm/mach-shmobile/setup-r7s72100.c          |  26 +-
>  arch/arm/mach-shmobile/setup-r8a73a4.c           |  17 +-
>  arch/arm/mach-shmobile/setup-r8a7740.c           | 133 ++--------
>  arch/arm/mach-shmobile/setup-r8a7778.c           |  28 +--
>  arch/arm/mach-shmobile/setup-r8a7779.c           |  66 +----
>  arch/arm/mach-shmobile/setup-r8a7790.c           |  17 +-
>  arch/arm/mach-shmobile/setup-r8a7791.c           |  17 +-
>  arch/arm/mach-shmobile/setup-sh7372.c            |  89 ++-----
>  arch/arm/mach-shmobile/setup-sh73a0.c            |  92 ++-----
>  arch/sh/kernel/cpu/clock-cpg.c                   |  10 +-
>  arch/sh/kernel/cpu/sh2/setup-sh7619.c            |  66 +----
>  arch/sh/kernel/cpu/sh2a/clock-sh7264.c           |   4 +-
>  arch/sh/kernel/cpu/sh2a/clock-sh7269.c           |   4 +-
>  arch/sh/kernel/cpu/sh2a/setup-mxg.c              |  98 +-------
>  arch/sh/kernel/cpu/sh2a/setup-sh7201.c           |  98 +-------
>  arch/sh/kernel/cpu/sh2a/setup-sh7203.c           | 133 ++--------
>  arch/sh/kernel/cpu/sh2a/setup-sh7206.c           | 164 ++-----------
>  arch/sh/kernel/cpu/sh2a/setup-sh7264.c           | 140 ++---------
>  arch/sh/kernel/cpu/sh2a/setup-sh7269.c           | 133 ++--------
>  arch/sh/kernel/cpu/sh3/setup-sh7705.c            |  78 +-----
>  arch/sh/kernel/cpu/sh3/setup-sh770x.c            |  78 +-----
>  arch/sh/kernel/cpu/sh3/setup-sh7710.c            |  78 +-----
>  arch/sh/kernel/cpu/sh3/setup-sh7720.c            | 228 ++---------------
>  arch/sh/kernel/cpu/sh4/setup-sh4-202.c           |  78 +-----
>  arch/sh/kernel/cpu/sh4/setup-sh7750.c            | 138 ++---------
>  arch/sh/kernel/cpu/sh4/setup-sh7760.c            |  78 +-----
>  arch/sh/kernel/cpu/sh4a/clock-sh7343.c           |   2 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7366.c           |   2 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7722.c           |   6 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7723.c           |  10 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7724.c           |  10 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7734.c           |  12 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7757.c           |   4 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7785.c           |   8 +-
>  arch/sh/kernel/cpu/sh4a/clock-sh7786.c           |  16 +-
>  arch/sh/kernel/cpu/sh4a/clock-shx3.c             |   8 +-
>  arch/sh/kernel/cpu/sh4a/setup-sh7343.c           |  96 +-------
>  arch/sh/kernel/cpu/sh4a/setup-sh7366.c           |  96 +-------
>  arch/sh/kernel/cpu/sh4a/setup-sh7722.c           |  96 +-------
>  arch/sh/kernel/cpu/sh4a/setup-sh7723.c           | 172 ++-----------
>  arch/sh/kernel/cpu/sh4a/setup-sh7724.c           | 173 ++-----------
>  arch/sh/kernel/cpu/sh4a/setup-sh7734.c           | 235 ++----------------
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c           |  48 +---
>  arch/sh/kernel/cpu/sh4a/setup-sh7763.c           | 154 +-----------
>  arch/sh/kernel/cpu/sh4a/setup-sh7770.c           | 230 ++---------------
>  arch/sh/kernel/cpu/sh4a/setup-sh7780.c           | 154 +-----------
>  arch/sh/kernel/cpu/sh4a/setup-sh7785.c           | 154 +-----------
>  arch/sh/kernel/cpu/sh4a/setup-sh7786.c           | 299 ++---------------------
>  arch/sh/kernel/cpu/sh4a/setup-shx3.c             | 150 +-----------
>  arch/sh/kernel/cpu/sh5/setup-sh5.c               |  79 +-----
>  61 files changed, 553 insertions(+), 3796 deletions(-)
> 
