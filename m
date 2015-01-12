From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Jan 2015 14:48:59 -0800
Subject: [GIT PULL v2] Renesas ARM Based SoC DT PM Updates for v3.20
In-Reply-To: <cover.1420429758.git.horms+renesas@verge.net.au>
References: <cover.1420429758.git.horms+renesas@verge.net.au>
Message-ID: <20150112224859.GM22090@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Jan 05, 2015 at 12:52:15PM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC DT PM updates for v3.20.
> 
> 
> As requested by Geert Uytterhoeven I have dropped
> "ARM: shmobile: R-Mobile: Enable module clocks if !CONFIG_PM_RUNTIME"
> from v2 of this pull-request.
> 
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt-pm-for-v3.20
> 
> for you to fetch changes up to b21cadc64dc34fb531ad49d462021c2b6a14cfff:
> 
>   ARM: shmobile: r8a7740 dtsi: Add PM domain support (2014-12-31 15:28:31 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC DT PM Updates for v3.20
> 
> * DT support from PM domains
> * Enable DT support for PM domains on r8a7740
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (5):
>       PM / Domains: Add DT bindings for the R-Mobile System Controller
>       ARM: shmobile: R-Mobile: Use generic_pm_domain.attach_dev() for pm_clk setup
>       ARM: shmobile: R-Mobile: Store SYSC base address in rmobile_pm_domain
>       ARM: shmobile: R-Mobile: Add DT support for PM domains
>       ARM: shmobile: r8a7740 dtsi: Add PM domain support
> 
>  .../bindings/power/renesas,sysc-rmobile.txt        |  98 ++++++++
>  arch/arm/boot/dts/r8a7740.dtsi                     |  99 ++++++++
>  arch/arm/mach-shmobile/Kconfig                     |   3 +-
>  arch/arm/mach-shmobile/pm-r8a7740.c                |  14 ++
>  arch/arm/mach-shmobile/pm-rmobile.c                | 273 +++++++++++++++++++--
>  arch/arm/mach-shmobile/pm-rmobile.h                |   3 +-
>  arch/arm/mach-shmobile/pm-sh7372.c                 |  11 +

I think the dts change and the binding change here should go in a dt
branch, and the rest should probably to in an SoC branch.

Would you mind respinning, or should I cherry-pick them between the branches
here?


-Olof
