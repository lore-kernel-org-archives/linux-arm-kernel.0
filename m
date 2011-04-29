From: robherring2@gmail.com (Rob Herring)
Date: Fri, 29 Apr 2011 13:25:03 -0500
Subject: [PATCH 00/10] ARM: SMP initialization consolidation
In-Reply-To: <1303940515-8807-1-git-send-email-robherring2@gmail.com>
References: <1303940515-8807-1-git-send-email-robherring2@gmail.com>
Message-ID: <4DBB027F.2010405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2011 04:41 PM, Rob Herring wrote:
> From: Rob Herring<rob.herring@calxeda.com>
>
> In order to avoid duplicating the same platform code yet again for a new
> platform, this series consolidates platforms using similar SMP startup code to
> a common implementation. A new kconfig entry SMP_COMMON_PEN is added for
> platforms using the common pen functions.
>
> OMAP uses a h/w mechansism for its pen, but it seems like it could use the same
> mechansism.
>
> Rob
> Rob Herring (10):
>    ARM: move Versatile SMP pen code to common location
>    ARM: ux500: convert to use common secondary pen code
>    ARM: msm: use common secondary pen code
>    ARM: add common scu_init_cpus
>    ARM: omap: use common scu_init_cpus
>    ARM: realview: use common scu_init_cpus
>    ARM: vexpress: use common scu_init_cpus
>    ARM: ux500: use common scu_init_cpus
>    ARM: shmobile: use common scu_init_cpus
>    ARM: move set_cpu_present calls to common smp code
>
>   arch/arm/Kconfig                             |    8 ++
>   arch/arm/include/asm/smp.h                   |    4 +
>   arch/arm/include/asm/smp_scu.h               |    1 +
>   arch/arm/kernel/Makefile                     |    3 +-
>   arch/arm/kernel/headsmp.S                    |   40 ++++++++++
>   arch/arm/kernel/smp.c                        |    4 +
>   arch/arm/kernel/smp_pen.c                    |  104 +++++++++++++++++++++++++
>   arch/arm/kernel/smp_scu.c                    |   19 +++++
>   arch/arm/mach-msm/Makefile                   |    2 +-
>   arch/arm/mach-msm/headsmp.S                  |   40 ----------
>   arch/arm/mach-msm/platsmp.c                  |   84 +-------------------
>   arch/arm/mach-omap2/omap-smp.c               |   25 +------
>   arch/arm/mach-realview/include/mach/smp.h    |    3 +
>   arch/arm/mach-realview/platsmp.c             |   30 +-------
>   arch/arm/mach-shmobile/include/mach/common.h |    2 +-
>   arch/arm/mach-shmobile/platsmp.c             |   20 +-----
>   arch/arm/mach-shmobile/smp-sh73a0.c          |    6 +-
>   arch/arm/mach-ux500/Kconfig                  |    1 +
>   arch/arm/mach-ux500/Makefile                 |    2 +-
>   arch/arm/mach-ux500/headsmp.S                |   37 ---------
>   arch/arm/mach-ux500/include/mach/smp.h       |    4 +-
>   arch/arm/mach-ux500/platsmp.c                |  105 +-------------------------
>   arch/arm/mach-vexpress/ct-ca9x4.c            |    9 +--
>   arch/arm/mach-vexpress/include/mach/smp.h    |    3 +
>   arch/arm/mach-vexpress/platsmp.c             |    9 +--
>   arch/arm/plat-versatile/Makefile             |    1 -
>   arch/arm/plat-versatile/headsmp.S            |   40 ----------
>   arch/arm/plat-versatile/platsmp.c            |  104 -------------------------
>   28 files changed, 210 insertions(+), 500 deletions(-)
>   create mode 100644 arch/arm/kernel/headsmp.S
>   create mode 100644 arch/arm/kernel/smp_pen.c
>   delete mode 100644 arch/arm/mach-msm/headsmp.S
>   delete mode 100644 arch/arm/mach-ux500/headsmp.S
>   delete mode 100644 arch/arm/plat-versatile/headsmp.S
>   delete mode 100644 arch/arm/plat-versatile/platsmp.c
>

Comments?

I only have a Versatile Express to test on, so any Tested-by's would be 
appreciated.

Rob
