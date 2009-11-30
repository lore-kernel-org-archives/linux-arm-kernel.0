From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 30 Nov 2009 11:23:49 -0500 (EST)
Subject: Git pull request: Orion/Kirkwood/Dove stuff for next merge window
In-Reply-To: <alpine.LFD.2.00.0911262005410.2059@xanadu.home>
References: <alpine.LFD.2.00.0911262005410.2059@xanadu.home>
Message-ID: <alpine.LFD.2.00.0911301122270.5820@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ping.

On Thu, 26 Nov 2009, Nicolas Pitre wrote:

> Russell, please pull the following:
> 
> 	git://git.marvell.com/orion for-rmk
> 
> This contains updates for Kirkwood and addition of support for the Dove 
> SOC.
> 
> Lennert Buytenhek (1):
>       ARM: Add Tauros2 L2 cache controller support
> 
> Martin Michlmayr (4):
>       [ARM] Kirkwood: Add support for QNAP TS-41x Turbo NAS
>       [ARM] Kirkwood: Add MPP36 for QNAP TS-11x/TS-21x
>       [ARM] Kirkwood: Add QNAP TS-110/TS-210 to Kconfig help text
>       [ARM] Kirkwood: Remove code duplication in QNAP setup files
> 
> Saeed Bishara (2):
>       ARM: add base support for Marvell Dove SoC
>       RTC: let Dove soc select the rtc-mv driver.
> 
>  arch/arm/Kconfig                              |   13 +
>  arch/arm/Makefile                             |    1 +
>  arch/arm/boot/compressed/head.S               |    6 +
>  arch/arm/configs/dove_defconfig               | 1620 +++++++++++++++++++
>  arch/arm/include/asm/hardware/cache-tauros2.h |   11 +
>  arch/arm/mach-dove/Kconfig                    |   14 +
>  arch/arm/mach-dove/Makefile                   |    3 +
>  arch/arm/mach-dove/Makefile.boot              |    3 +
>  arch/arm/mach-dove/addr-map.c                 |  149 ++
>  arch/arm/mach-dove/common.c                   |  781 +++++++++
>  arch/arm/mach-dove/common.h                   |   40 +
>  arch/arm/mach-dove/dove-db-setup.c            |  102 ++
>  arch/arm/mach-dove/include/mach/bridge-regs.h |   58 +
>  arch/arm/mach-dove/include/mach/debug-macro.S |   20 +
>  arch/arm/mach-dove/include/mach/dove.h        |  180 ++
>  arch/arm/mach-dove/include/mach/entry-macro.S |   39 +
>  arch/arm/mach-dove/include/mach/gpio.h        |   49 +
>  arch/arm/mach-dove/include/mach/hardware.h    |   26 +
>  arch/arm/mach-dove/include/mach/io.h          |   20 +
>  arch/arm/mach-dove/include/mach/irqs.h        |  101 ++
>  arch/arm/mach-dove/include/mach/memory.h      |   10 +
>  arch/arm/mach-dove/include/mach/pm.h          |   54 +
>  arch/arm/mach-dove/include/mach/system.h      |   36 +
>  arch/arm/mach-dove/include/mach/timex.h       |    9 +
>  arch/arm/mach-dove/include/mach/uncompress.h  |   37 +
>  arch/arm/mach-dove/include/mach/vmalloc.h     |    5 +
>  arch/arm/mach-dove/irq.c                      |  133 ++
>  arch/arm/mach-dove/pcie.c                     |  238 +++
>  arch/arm/mach-kirkwood/Kconfig                |   12 +-
>  arch/arm/mach-kirkwood/Makefile               |    3 +-
>  arch/arm/mach-kirkwood/ts219-setup.c          |  108 +--
>  arch/arm/mach-kirkwood/ts41x-setup.c          |  154 ++
>  arch/arm/mach-kirkwood/tsx1x-common.c         |  113 ++
>  arch/arm/mach-kirkwood/tsx1x-common.h         |    7 +
>  arch/arm/mm/Kconfig                           |   11 +-
>  arch/arm/mm/Makefile                          |    2 +-
>  arch/arm/mm/cache-tauros2.c                   |  263 +++
>  arch/arm/mm/proc-v6.S                         |   33 +-
>  drivers/rtc/Kconfig                           |    2 +-
>  39 files changed, 4356 insertions(+), 110 deletions(-)
> 
