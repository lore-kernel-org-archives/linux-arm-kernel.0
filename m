From: robherring2@gmail.com (Rob Herring)
Date: Mon, 26 Sep 2011 13:39:13 -0500
Subject: [PATCH v2 0/7] Initial Calxeda Highbank support
In-Reply-To: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
References: <1314841446-11006-1-git-send-email-robherring2@gmail.com>
Message-ID: <4E80C6D1.1010601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 08/31/2011 08:43 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds initial platform support for Calxeda's Highbank ARM SOC including
> SMP, hotplug, and suspend support. One new patch to add empty version of
> l2x0_of_init. Changes for v2 are listed in each patch.
> 
> Based on rmk's for-next branch with gpio.h and io.h clean-ups plus previously
> posted GIC devicetree binding support. The GIC patches are here:
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/060570.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/060790.html
> http://lists.infradead.org/pipermail/linux-arm-kernel/2011-August/062735.html
> 
> Rob
> 
> Martin Bogomolni (1):
>   ARM: highbank: Add cpu hotplug support
> 
> Rob Herring (6):
>   ARM: l2x0: add empty l2x0_of_init
>   ARM: highbank: add devicetree source
>   ARM: add Highbank core platform support
>   MAINTAINERS: add Calxeda Highbank ARM platform
>   ARM: highbank: add SMP support
>   ARM: highbank: add suspend support
> 
>  Documentation/devicetree/bindings/arm/calxeda.txt |    8 +
>  MAINTAINERS                                       |    6 +
>  arch/arm/Kconfig                                  |   18 ++-
>  arch/arm/Makefile                                 |    1 +
>  arch/arm/boot/dts/highbank.dts                    |  224 +++++++++++++++++++++
>  arch/arm/include/asm/hardware/cache-l2x0.h        |    7 +
>  arch/arm/mach-highbank/Makefile                   |    6 +
>  arch/arm/mach-highbank/Makefile.boot              |    1 +
>  arch/arm/mach-highbank/clock.c                    |   62 ++++++
>  arch/arm/mach-highbank/core.h                     |    9 +
>  arch/arm/mach-highbank/highbank.c                 |  150 ++++++++++++++
>  arch/arm/mach-highbank/hotplug.c                  |   56 +++++
>  arch/arm/mach-highbank/include/mach/debug-macro.S |   19 ++
>  arch/arm/mach-highbank/include/mach/entry-macro.S |    7 +
>  arch/arm/mach-highbank/include/mach/gpio.h        |    1 +
>  arch/arm/mach-highbank/include/mach/io.h          |    7 +
>  arch/arm/mach-highbank/include/mach/irqs.h        |    6 +
>  arch/arm/mach-highbank/include/mach/memory.h      |    1 +
>  arch/arm/mach-highbank/include/mach/system.h      |   26 +++
>  arch/arm/mach-highbank/include/mach/timex.h       |    6 +
>  arch/arm/mach-highbank/include/mach/uncompress.h  |    9 +
>  arch/arm/mach-highbank/include/mach/vmalloc.h     |    6 +
>  arch/arm/mach-highbank/lluart.c                   |   34 +++
>  arch/arm/mach-highbank/localtimer.c               |   38 ++++
>  arch/arm/mach-highbank/platsmp.c                  |   78 +++++++
>  arch/arm/mach-highbank/pm.c                       |   55 +++++
>  arch/arm/mach-highbank/sysregs.h                  |   52 +++++
>  arch/arm/mach-highbank/system.c                   |   33 +++
>  arch/arm/mm/Kconfig                               |    2 +-
>  29 files changed, 926 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
>  create mode 100644 arch/arm/boot/dts/highbank.dts
>  create mode 100644 arch/arm/mach-highbank/Makefile
>  create mode 100644 arch/arm/mach-highbank/Makefile.boot
>  create mode 100644 arch/arm/mach-highbank/clock.c
>  create mode 100644 arch/arm/mach-highbank/core.h
>  create mode 100644 arch/arm/mach-highbank/highbank.c
>  create mode 100644 arch/arm/mach-highbank/hotplug.c
>  create mode 100644 arch/arm/mach-highbank/include/mach/debug-macro.S
>  create mode 100644 arch/arm/mach-highbank/include/mach/entry-macro.S
>  create mode 100644 arch/arm/mach-highbank/include/mach/gpio.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/io.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/irqs.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/memory.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/system.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/timex.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/uncompress.h
>  create mode 100644 arch/arm/mach-highbank/include/mach/vmalloc.h
>  create mode 100644 arch/arm/mach-highbank/lluart.c
>  create mode 100644 arch/arm/mach-highbank/localtimer.c
>  create mode 100644 arch/arm/mach-highbank/platsmp.c
>  create mode 100644 arch/arm/mach-highbank/pm.c
>  create mode 100644 arch/arm/mach-highbank/sysregs.h
>  create mode 100644 arch/arm/mach-highbank/system.c
> 

Any comments on v2?

The GIC binding series seems to be firming up. As myself and several
others are dependent on it, I was planning to send both through arm-soc
tree as 2 pulls. I also have some dependencies on rmk's tree with l2x0
DT support and mach header clean-ups.

Rob
