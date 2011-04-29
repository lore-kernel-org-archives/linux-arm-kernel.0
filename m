From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 29 Apr 2011 15:06:38 +0200
Subject: [PATCH 0/5] convert stmp into mxs and delete the then obsolete
	platform
Message-ID: <1304082403-8897-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is my attempt after the RFC to clean up mach-stmp by using
mach-mxs. What we have here is consolidation of two platforms. The old
one, plat-stmp, has never seen much love after the initial commit and
has poor design (as explained in my patch descriptions). The recently
added mach-mxs can be used for a (friendly) takeover. Adding 200 lines
there could save 9500+ lines in arch/arm!

The larger patches will probably take a while until they are moderated.
You can have a look already at my public branch, coordinates below.
There are more details in those patch descriptions, so please read them
to get the bigger picture.

Looking forward for comments.

Thanks,

   Wolfram

The following changes since commit 8e10cd74342c7f5ce259cceca36f6eba084f5d58:

  Linux 2.6.39-rc5 (2011-04-26 20:48:50 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/wsa/linux-2.6.git remove_stmp

The web interface is at:

  http://git.pengutronix.de/?p=wsa/linux-2.6.git;a=shortlog;h=refs/heads/remove_stmp

Change since last version:

 * Add a mxs_defconfig and remove stmp_defconfigs
 * commit messages wrap now at column 72 :)


Wolfram Sang (5):
  arm: mach-mxs: add stmp378x-devb
  arm: configs: add defconfig for mach-mxs
  arm: mach-stmp37xx: remove mach
  arm: mach-stmp378x: remove mach
  arm: plat-stmp: remove plat

 arch/arm/Kconfig                                   |   12 -
 arch/arm/Makefile                                  |    3 -
 arch/arm/configs/mxs_defconfig                     |  129 +++
 arch/arm/configs/stmp378x_defconfig                |  128 ---
 arch/arm/configs/stmp37xx_defconfig                |  108 --
 arch/arm/mach-mxs/Kconfig                          |   10 +
 arch/arm/mach-mxs/Makefile                         |    1 +
 arch/arm/mach-mxs/mach-stmp378x_devb.c             |  120 ++
 arch/arm/mach-stmp378x/Makefile                    |    2 -
 arch/arm/mach-stmp378x/Makefile.boot               |    3 -
 arch/arm/mach-stmp378x/include/mach/entry-macro.S  |   35 -
 arch/arm/mach-stmp378x/include/mach/irqs.h         |   95 --
 arch/arm/mach-stmp378x/include/mach/pins.h         |  151 ---
 arch/arm/mach-stmp378x/include/mach/regs-apbh.h    |  101 --
 arch/arm/mach-stmp378x/include/mach/regs-apbx.h    |  119 --
 arch/arm/mach-stmp378x/include/mach/regs-audioin.h |   63 --
 .../arm/mach-stmp378x/include/mach/regs-audioout.h |  104 --
 arch/arm/mach-stmp378x/include/mach/regs-bch.h     |   56 -
 arch/arm/mach-stmp378x/include/mach/regs-clkctrl.h |   88 --
 arch/arm/mach-stmp378x/include/mach/regs-dcp.h     |   87 --
 arch/arm/mach-stmp378x/include/mach/regs-digctl.h  |   38 -
 arch/arm/mach-stmp378x/include/mach/regs-dram.h    |   27 -
 arch/arm/mach-stmp378x/include/mach/regs-dri.h     |   45 -
 arch/arm/mach-stmp378x/include/mach/regs-ecc8.h    |   39 -
 arch/arm/mach-stmp378x/include/mach/regs-emi.h     |   25 -
 arch/arm/mach-stmp378x/include/mach/regs-gpmi.h    |   78 --
 arch/arm/mach-stmp378x/include/mach/regs-i2c.h     |   55 -
 arch/arm/mach-stmp378x/include/mach/regs-icoll.h   |   45 -
 arch/arm/mach-stmp378x/include/mach/regs-ir.h      |   23 -
 arch/arm/mach-stmp378x/include/mach/regs-lcdif.h   |  195 ----
 arch/arm/mach-stmp378x/include/mach/regs-lradc.h   |   99 --
 arch/arm/mach-stmp378x/include/mach/regs-ocotp.h   |   40 -
 arch/arm/mach-stmp378x/include/mach/regs-pinctrl.h |   90 --
 arch/arm/mach-stmp378x/include/mach/regs-power.h   |   63 --
 arch/arm/mach-stmp378x/include/mach/regs-pwm.h     |   53 -
 arch/arm/mach-stmp378x/include/mach/regs-pxp.h     |  140 ---
 arch/arm/mach-stmp378x/include/mach/regs-rtc.h     |   59 -
 arch/arm/mach-stmp378x/include/mach/regs-saif.h    |   21 -
 arch/arm/mach-stmp378x/include/mach/regs-spdif.h   |   49 -
 arch/arm/mach-stmp378x/include/mach/regs-ssp.h     |  102 --
 arch/arm/mach-stmp378x/include/mach/regs-sydma.h   |   23 -
 arch/arm/mach-stmp378x/include/mach/regs-timrot.h  |   68 --
 arch/arm/mach-stmp378x/include/mach/regs-tvenc.h   |   67 --
 arch/arm/mach-stmp378x/include/mach/regs-uartapp.h |   87 --
 arch/arm/mach-stmp378x/include/mach/regs-uartdbg.h |  268 -----
 arch/arm/mach-stmp378x/include/mach/regs-usbctrl.h |   40 -
 arch/arm/mach-stmp378x/include/mach/regs-usbphy.h  |   37 -
 arch/arm/mach-stmp378x/stmp378x.c                  |  299 -----
 arch/arm/mach-stmp378x/stmp378x.h                  |   25 -
 arch/arm/mach-stmp378x/stmp378x_devb.c             |  332 ------
 arch/arm/mach-stmp37xx/Makefile                    |    2 -
 arch/arm/mach-stmp37xx/Makefile.boot               |    3 -
 arch/arm/mach-stmp37xx/include/mach/entry-macro.S  |   37 -
 arch/arm/mach-stmp37xx/include/mach/irqs.h         |   99 --
 arch/arm/mach-stmp37xx/include/mach/pins.h         |  147 ---
 arch/arm/mach-stmp37xx/include/mach/regs-apbh.h    |   97 --
 arch/arm/mach-stmp37xx/include/mach/regs-apbx.h    |  113 --
 arch/arm/mach-stmp37xx/include/mach/regs-audioin.h |   61 --
 .../arm/mach-stmp37xx/include/mach/regs-audioout.h |  111 --
 arch/arm/mach-stmp37xx/include/mach/regs-clkctrl.h |   72 --
 arch/arm/mach-stmp37xx/include/mach/regs-digctl.h  |   24 -
 arch/arm/mach-stmp37xx/include/mach/regs-ecc8.h    |   37 -
 arch/arm/mach-stmp37xx/include/mach/regs-gpmi.h    |   63 --
 arch/arm/mach-stmp37xx/include/mach/regs-i2c.h     |   55 -
 arch/arm/mach-stmp37xx/include/mach/regs-icoll.h   |   43 -
 arch/arm/mach-stmp37xx/include/mach/regs-lcdif.h   |   89 --
 arch/arm/mach-stmp37xx/include/mach/regs-lradc.h   |   97 --
 arch/arm/mach-stmp37xx/include/mach/regs-pinctrl.h |   88 --
 arch/arm/mach-stmp37xx/include/mach/regs-power.h   |   56 -
 arch/arm/mach-stmp37xx/include/mach/regs-pwm.h     |   51 -
 arch/arm/mach-stmp37xx/include/mach/regs-rtc.h     |   57 -
 arch/arm/mach-stmp37xx/include/mach/regs-ssp.h     |  101 --
 arch/arm/mach-stmp37xx/include/mach/regs-timrot.h  |   49 -
 arch/arm/mach-stmp37xx/include/mach/regs-uartapp.h |   85 --
 arch/arm/mach-stmp37xx/include/mach/regs-uartdbg.h |  268 -----
 arch/arm/mach-stmp37xx/include/mach/regs-usbctl.h  |   22 -
 arch/arm/mach-stmp37xx/include/mach/regs-usbctrl.h |   22 -
 arch/arm/mach-stmp37xx/include/mach/regs-usbphy.h  |   37 -
 arch/arm/mach-stmp37xx/stmp37xx.c                  |  219 ----
 arch/arm/mach-stmp37xx/stmp37xx.h                  |   24 -
 arch/arm/mach-stmp37xx/stmp37xx_devb.c             |   99 --
 arch/arm/plat-stmp3xxx/Kconfig                     |   37 -
 arch/arm/plat-stmp3xxx/Makefile                    |    5 -
 arch/arm/plat-stmp3xxx/clock.c                     | 1134 --------------------
 arch/arm/plat-stmp3xxx/clock.h                     |   61 --
 arch/arm/plat-stmp3xxx/core.c                      |  128 ---
 arch/arm/plat-stmp3xxx/devices.c                   |  389 -------
 arch/arm/plat-stmp3xxx/dma.c                       |  464 --------
 arch/arm/plat-stmp3xxx/include/mach/clkdev.h       |   18 -
 arch/arm/plat-stmp3xxx/include/mach/cputype.h      |   33 -
 arch/arm/plat-stmp3xxx/include/mach/debug-macro.S  |   39 -
 arch/arm/plat-stmp3xxx/include/mach/dma.h          |  153 ---
 arch/arm/plat-stmp3xxx/include/mach/gpio.h         |   28 -
 arch/arm/plat-stmp3xxx/include/mach/gpmi.h         |   12 -
 arch/arm/plat-stmp3xxx/include/mach/hardware.h     |   32 -
 arch/arm/plat-stmp3xxx/include/mach/io.h           |   25 -
 arch/arm/plat-stmp3xxx/include/mach/memory.h       |   22 -
 arch/arm/plat-stmp3xxx/include/mach/mmc.h          |   14 -
 arch/arm/plat-stmp3xxx/include/mach/pinmux.h       |  157 ---
 arch/arm/plat-stmp3xxx/include/mach/pins.h         |   30 -
 arch/arm/plat-stmp3xxx/include/mach/platform.h     |   68 --
 arch/arm/plat-stmp3xxx/include/mach/stmp3xxx.h     |   54 -
 arch/arm/plat-stmp3xxx/include/mach/system.h       |   49 -
 arch/arm/plat-stmp3xxx/include/mach/timex.h        |   20 -
 arch/arm/plat-stmp3xxx/include/mach/uncompress.h   |   53 -
 arch/arm/plat-stmp3xxx/include/mach/vmalloc.h      |   12 -
 arch/arm/plat-stmp3xxx/irq.c                       |   50 -
 arch/arm/plat-stmp3xxx/pinmux.c                    |  550 ----------
 arch/arm/plat-stmp3xxx/timer.c                     |  186 ----
 109 files changed, 260 insertions(+), 9838 deletions(-)

-- 
1.7.2.5
