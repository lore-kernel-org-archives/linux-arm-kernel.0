From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sat, 14 Jul 2012 15:31:09 +0200
Subject: [GIT PULL] Renesas ARM-based SoCs updates for v3.5
In-Reply-To: <201207141529.21534.rjw@sisk.pl>
References: <201207112338.36939.rjw@sisk.pl> <201207141529.21534.rjw@sisk.pl>
Message-ID: <201207141531.09545.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The subject should be "Renesas ARM-based SoCs updates for v3.6", sorry for
the mistake.  The message body is correct.

On Saturday, July 14, 2012, Rafael J. Wysocki wrote:
> Hi,
> 
> Please pull changes since commit 485802a6c524e62b5924849dd727ddbb1497cc71
> 
>     Linux 3.5-rc3
> 
> with top-most commit 0df8fa46611abc56e39f541495d667e4bf4f1060
> 
>     Merge branch 'renesas-sh7377' into renesas-soc
> 
> from the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git soc
> 
> to receive updates for Renesas ARM-based SoCs for v3.6.  Included are:
> 
> * Updates for the r8a7740, sh73a0 and sh7372 SoCs from Kuninori Morimoto.
> * Low-level power management code reorganization from Kuninori Morimoto.
> * Wakeup signaling rework for sh7372 and DT support bits for r8a7740 and
>   sh7377 from Magnus Damm.
> * Assorted fixes.
> 
> This branch also includes fixes based on top of v3.5-rc3 that have been
> already merged into arm-soc and mainline, which are not listed below.
> 
> Thanks!
> 
> 
>  arch/arm/boot/dts/r8a7740.dtsi                     |  21 ++
>  arch/arm/boot/dts/sh7377.dtsi                      |  21 ++
>  arch/arm/mach-shmobile/Kconfig                     |   1 +
>  arch/arm/mach-shmobile/Makefile                    |   2 +
>  arch/arm/mach-shmobile/board-ap4evb.c              |  16 +-
>  arch/arm/mach-shmobile/board-armadillo800eva.c     |   1 +
>  arch/arm/mach-shmobile/board-mackerel.c            |  24 +-
>  arch/arm/mach-shmobile/clock-r8a7740.c             | 150 ++++++++-
>  arch/arm/mach-shmobile/clock-r8a7779.c             |   2 +-
>  arch/arm/mach-shmobile/clock-sh7367.c              |   2 +-
>  arch/arm/mach-shmobile/clock-sh7372.c              |   2 +-
>  arch/arm/mach-shmobile/clock-sh7377.c              |   2 +-
>  arch/arm/mach-shmobile/clock-sh73a0.c              |  12 +-
>  arch/arm/mach-shmobile/include/mach/common.h       |   1 +
>  arch/arm/mach-shmobile/include/mach/dma-register.h |  84 +++++
>  arch/arm/mach-shmobile/include/mach/gpio.h         |  32 ++
>  arch/arm/mach-shmobile/include/mach/pm-rmobile.h   |  44 +++
>  arch/arm/mach-shmobile/include/mach/r8a7740.h      |  33 +-
>  arch/arm/mach-shmobile/include/mach/sh7372.h       |  45 +--
>  arch/arm/mach-shmobile/include/mach/sh73a0.h       |   7 +
>  arch/arm/mach-shmobile/intc-r8a7740.c              |  13 +-
>  arch/arm/mach-shmobile/pfc-r8a7740.c               |  24 +-
>  arch/arm/mach-shmobile/pm-r8a7740.c                |  54 ++++
>  arch/arm/mach-shmobile/pm-rmobile.c                | 167 ++++++++++
>  arch/arm/mach-shmobile/pm-sh7372.c                 | 297 +++++------------
>  arch/arm/mach-shmobile/setup-r8a7740.c             | 360 +++++++++++++++++++++
>  arch/arm/mach-shmobile/setup-sh7372.c              | 209 +++++-------
>  arch/arm/mach-shmobile/setup-sh7377.c              |  47 +++
>  arch/arm/mach-shmobile/setup-sh73a0.c              | 152 +++++++--
>  29 files changed, 1383 insertions(+), 442 deletions(-)
> 
> ---------------
> 
> Kuninori Morimoto (28):
>       ARM: shmobile: r8a7740: add HDMI interrupt support
>       ARM: shmobile: r8a7740: add HDMI clock support
>       ARM: shmobile: r8a7740: add HDMI GPIO support
>       ARM: shmobile: r8a7740: add MERAM work-around
>       ARM: shmobile: r8a7740: add CEU clock support
>       ARM: shmobile: r8a7740: add FSI parent clock support
>       ARM: shmobile: r8a7740: add FSI-B (for HDMI) GPIO support
>       ARM: shmobile: sh73a0: add FSI clock
>       ARM: shmobile: sh7372: remove unused sh7372_a3sp_init() on !CONFIG_PM
>       ARM: shmobile: add common extra gpio functions
>       ARM: shmobile: add common DMAEngine definitions
>       ARM: shmobile: r8a7740: add DMAEngine support for FSI
>       ARM: shmobile: r8a7740: add DMAEngine support for SDHI
>       ARM: shmobile: r8a7740: add DMAEngine support for USB
>       ARM: shmobile: use common DMAEngine definitions on r8a7740
>       ARM: shmobile: sh73a0: add USB clock support
>       ARM: shmobile: sh73a0: add DMAEngine support for MPDMAC
>       ARM: shmobile: use common DMAEngine definitions on sh73a0
>       ARM: shmobile: use common DMAEngine definitions on sh7372
>       ARM: shmobile: soc-core: add R-mobile PM domain common APIs
>       ARM: shmobile: r8a7740: fixup: MSEL1CR 7bit control
>       ARM: shmobile: r8a7740: add A4S pm domain support
>       ARM: shmobile: r8a7740: add A3SP pm domain support
>       ARM: shmobile: r8a7740: add A4LC pm domain support
>       ARM: shmobile: sh7372: add pm-rmobile domain support
>       ARM: shmobile: mackerel: switch to using pm-rmobile API
>       ARM: shmobile: ap4evb: switch to using pm-rmobile API
>       ARM: shmobile: sh7372: completely switch over to using pm-rmobile API
> 
> Magnus Damm (5):
>       ARM: shmobile: Use INTCA with sh7372 A3SM power domain
>       ARM: shmobile: sh7372 A3SM CPUIdle support
>       ARM: mach-shmobile: r8a7740 generic board support via DT
>       ARM: mach-shmobile: sh7377 generic board support via DT
>       ARM: shmobile: Take cpuidle dependencies into account correctly
> 
> Nobuhiro Iwamatsu (1):
>       ARM: mach-shmobile: Convert sh_clk_mstp32_register to sh_clk_mstp_register
> 
> Rafael J. Wysocki (1):
>       ARM: shmobile: Fix build problem in pm-sh7372.c for unusual .config
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
