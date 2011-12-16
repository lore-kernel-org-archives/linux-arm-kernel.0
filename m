From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Dec 2011 11:48:32 -0800
Subject: [GIT PULL] ARM: OMAP2+: PRCM: add chained PRCM interrupt handler
In-Reply-To: <alpine.DEB.2.00.1112160621080.12660@utopia.booyaka.com>
References: <alpine.DEB.2.00.1112160621080.12660@utopia.booyaka.com>
Message-ID: <20111216194831.GK32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [111216 04:50]:
> Hi Tony
> 
> The following changes since commit dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:
> 
>   Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

Great good to see this getting merged. Pulling into prcm branch.

Regards,

Tony
 
> are available in the git repository at:
>   git://git.pwsan.com/linux-2.6 tk_prm_chain_handler_devel_3.3
> 
> Govindraj R (1):
>       ARM: OMAP2+: hwmod: Add API to enable IO ring wakeup
> 
> Paul Walmsley (2):
>       ARM: OMAP2+: mux: add wakeup-capable hwmod mux entries to dynamic list
>       ARM: OMAP3/4: PRM: add functions to read pending IRQs, PRM barrier
> 
> Tero Kristo (6):
>       ARM: OMAP: PRCM: add support for chain interrupt handler
>       ARM: OMAP: PRCM: add suspend prepare / finish support
>       ARM: OMAP2+: mux: add support for PAD wakeup interrupts
>       ARM: OMAP: hwmod: add support for selecting mpu_irq for each wakeup pad
>       ARM: OMAP3: pm: use prcm chain handler
>       ARM: OMAP4: PRM: use PRCM interrupt handler
> 
>  arch/arm/mach-omap2/Makefile                 |    5 +-
>  arch/arm/mach-omap2/mux.c                    |   89 +++++++-
>  arch/arm/mach-omap2/omap_hwmod.c             |  102 ++++++++
>  arch/arm/mach-omap2/pm34xx.c                 |  115 ++++------
>  arch/arm/mach-omap2/prcm-common.h            |   75 ++++++-
>  arch/arm/mach-omap2/prm2xxx_3xxx.c           |   97 ++++++++-
>  arch/arm/mach-omap2/prm2xxx_3xxx.h           |    9 +-
>  arch/arm/mach-omap2/prm44xx.c                |  116 ++++++++++
>  arch/arm/mach-omap2/prm44xx.h                |    8 +-
>  arch/arm/mach-omap2/prm_common.c             |  320 ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +
>  11 files changed, 860 insertions(+), 79 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/prm_common.c
