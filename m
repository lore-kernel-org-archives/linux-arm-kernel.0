From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 3 Mar 2010 22:05:38 +0100
Subject: LPC32XX architecture files (updated v5)
In-Reply-To: <20100302201833.GA29471@pengutronix.de>
References: <1267228430-27193-1-git-send-email-wellsk40@gmail.com>
	<083DF309106F364B939360100EC290F805CCF9315D@eu1rdcrdc1wx030.exi.nxp.com>
	<20100302201833.GA29471@pengutronix.de>
Message-ID: <083DF309106F364B939360100EC290F805CCFFE002@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> Hello Kevin,
> 
> On Tue, Mar 02, 2010 at 06:19:20PM +0100, Kevin Wells wrote:
> > Can I submit these patches to the patch tracker? Or is there
> > another way to get them accepted? I'm sure we'll continue
> > finding small issues here and there over time, but we are
> > committed to maintaining and improving them in the long run.
> > (And I would like to start getting the other drivers outside
> > of the ARM area going).
> I don't like using the patch system for patch series, so you can ask
> Russell to pull from a git repository.  As you wrote to work for a
> company using M$ Exchange this might not be easy :-), so you can ask him
> to pull from my repo, see below.  (I only fixed up the subjects using
> s,ARM: LPC32XX,arm/lpc32xx, added a missing 'A' and fixed two checkpatch
> warnings.)  Obviously I didn't added patches 12 and 13 which maybe
> should better go via the i2c resp. watchdog trees.
> 

Hi Uwe,

Thank you for helping check out and hosting these patches! We do have
*cough* some limitations with what we can do with our IT support, but we
are working on getting a public GIT server up that will make this
easier on the next arch and future changes.

I just pulled the patches from your server and it all looks good!

thanks for your help!
Kevin

> Best regards
> Uwe
> 
> The following changes since commit
> 13dda80e48439b446d0bc9bab34b91484bc8f533:
>   Linus Torvalds (1):
>         Merge branch 'davinci-for-linus' of
> git://git.kernel.org/.../khilman/linux-davinci
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/ukl/linux-2.6.git wells/lpc32xx
> 
> Kevin Wells (11):
>       arm/lpc32xx: Initial arch header files
>       arm/lpc32xx: Debug and IRQ macros
>       arm/lpc32xx: Clock driver
>       arm/lpc32xx: GPIO, timer, and IRQ drivers
>       arm/lpc32xx: System suspend support
>       arm/lpc32xx: Serial support code
>       arm/lpc32xx: Misc support functions
>       arm/lpc32xx: Phytec 3250 platform support
>       arm/lpc32xx: Arch config menu supoport and makefiles
>       arm/lpc32xx: Default PHY3250 kernel config (ramdisk)
>       arm: Add support for the LPC32XX arch
> 
>  arch/arm/Kconfig                                 |   15 +
>  arch/arm/Makefile                                |    1 +
>  arch/arm/configs/phy3250_defconfig               | 1099
> +++++++++++++++++++++
>  arch/arm/mach-lpc32xx/Kconfig                    |   33 +
>  arch/arm/mach-lpc32xx/Makefile                   |    8 +
>  arch/arm/mach-lpc32xx/Makefile.boot              |    4 +
>  arch/arm/mach-lpc32xx/clock.c                    | 1137
> ++++++++++++++++++++++
>  arch/arm/mach-lpc32xx/clock.h                    |   38 +
>  arch/arm/mach-lpc32xx/common.c                   |  271 +++++
>  arch/arm/mach-lpc32xx/common.h                   |   73 ++
>  arch/arm/mach-lpc32xx/gpiolib.c                  |  446 +++++++++
>  arch/arm/mach-lpc32xx/include/mach/clkdev.h      |   25 +
>  arch/arm/mach-lpc32xx/include/mach/debug-macro.S |   31 +
>  arch/arm/mach-lpc32xx/include/mach/entry-macro.S |   47 +
>  arch/arm/mach-lpc32xx/include/mach/gpio.h        |   74 ++
>  arch/arm/mach-lpc32xx/include/mach/hardware.h    |   34 +
>  arch/arm/mach-lpc32xx/include/mach/i2c.h         |   63 ++
>  arch/arm/mach-lpc32xx/include/mach/io.h          |   27 +
>  arch/arm/mach-lpc32xx/include/mach/irqs.h        |  117 +++
>  arch/arm/mach-lpc32xx/include/mach/memory.h      |   27 +
>  arch/arm/mach-lpc32xx/include/mach/platform.h    |  694 +++++++++++++
>  arch/arm/mach-lpc32xx/include/mach/system.h      |   52 +
>  arch/arm/mach-lpc32xx/include/mach/timex.h       |   28 +
>  arch/arm/mach-lpc32xx/include/mach/uncompress.h  |   60 ++
>  arch/arm/mach-lpc32xx/include/mach/vmalloc.h     |   24 +
>  arch/arm/mach-lpc32xx/irq.c                      |  432 ++++++++
>  arch/arm/mach-lpc32xx/phy3250.c                  |  397 ++++++++
>  arch/arm/mach-lpc32xx/pm.c                       |  145 +++
>  arch/arm/mach-lpc32xx/serial.c                   |  190 ++++
>  arch/arm/mach-lpc32xx/suspend.S                  |  151 +++
>  arch/arm/mach-lpc32xx/timer.c                    |  182 ++++
>  31 files changed, 5925 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/configs/phy3250_defconfig
>  create mode 100644 arch/arm/mach-lpc32xx/Kconfig
>  create mode 100644 arch/arm/mach-lpc32xx/Makefile
>  create mode 100644 arch/arm/mach-lpc32xx/Makefile.boot
>  create mode 100644 arch/arm/mach-lpc32xx/clock.c
>  create mode 100644 arch/arm/mach-lpc32xx/clock.h
>  create mode 100644 arch/arm/mach-lpc32xx/common.c
>  create mode 100644 arch/arm/mach-lpc32xx/common.h
>  create mode 100644 arch/arm/mach-lpc32xx/gpiolib.c
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/clkdev.h
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/debug-macro.S
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/entry-macro.S
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/gpio.h
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/hardware.h
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/i2c.h
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/io.h
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/irqs.h
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/memory.h
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/platform.h
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/system.h
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/timex.h
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/uncompress.h
>  create mode 100644 arch/arm/mach-lpc32xx/include/mach/vmalloc.h
>  create mode 100644 arch/arm/mach-lpc32xx/irq.c
>  create mode 100644 arch/arm/mach-lpc32xx/phy3250.c
>  create mode 100644 arch/arm/mach-lpc32xx/pm.c
>  create mode 100644 arch/arm/mach-lpc32xx/serial.c
>  create mode 100644 arch/arm/mach-lpc32xx/suspend.S
>  create mode 100644 arch/arm/mach-lpc32xx/timer.c
> 
> 
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
