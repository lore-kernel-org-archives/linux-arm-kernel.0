From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Nov 2012 16:53:52 -0800
Subject: [GIT PULL] OMAP: PM: misc. fixes for v3.8
In-Reply-To: <877gpy2t0n.fsf@deeprootsystems.com>
References: <877gpy2t0n.fsf@deeprootsystems.com>
Message-ID: <20121107005352.GT6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [121106 15:49]:
> Tony,
> 
> Here's a small series that fixes some errata to make suspend/resume
> work on OMAP4460.
> 
> This is not a regression and has been broken for awhile, so this is v3.8
> material, not v3.7.
> 
> Kevin
> 
> The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:
> 
>   Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.8-fixes-pm

Thanks pulling into omap-for-v3.8/fixes-non-critical.

Regards,

Tony

> 
> for you to fetch changes up to cd8ce159031813eb870a5f3d5b27c3be36cd6e3a:
> 
>   ARM: OMAP4: retrigger localtimers after re-enabling gic (2012-11-05 14:26:43 -0800)
> 
> ----------------------------------------------------------------
> Some non-regression fixes for OMAP4460 PM support.
> 
> ----------------------------------------------------------------
> Colin Cross (1):
>       ARM: OMAP4: retrigger localtimers after re-enabling gic
> 
> Santosh Shilimkar (1):
>       ARM: OMAP4460: Workaround for ROM bug because of CA9 r2pX GIC control register change.
> 
> Tero Kristo (1):
>       ARM: OMAP4: PM: add errata support
> 
>  arch/arm/mach-omap2/common.h              |  4 +++
>  arch/arm/mach-omap2/omap-headsmp.S        | 38 ++++++++++++++++++++++++++++
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c |  9 ++++++-
>  arch/arm/mach-omap2/omap-smp.c            | 39 +++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/omap4-common.c        | 42 ++++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/pm.h                  |  9 +++++++
>  arch/arm/mach-omap2/pm44xx.c              |  1 +
>  7 files changed, 139 insertions(+), 3 deletions(-)
