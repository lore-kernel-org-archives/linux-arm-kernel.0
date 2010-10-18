From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 19 Oct 2010 08:36:27 +0900
Subject: Last call for new machine support
In-Reply-To: <20101018211119.GB20376@n2100.arm.linux.org.uk>
References: <20101018211119.GB20376@n2100.arm.linux.org.uk>
Message-ID: <04d601cb6f1d$4dc32340$e94969c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> Tuesday evening my time (BST, so UTC+1h) is the last time I'm merging
> anything into my git tree.
> 
> With the upcoming change to the debug macro infrastructure, there are
> two options for people who have new board support code external to my
> tree:
> 
> 1. Send me a pull request (based on Linus' tree not mine) by Tuesday.
> 
> 2. Eat merge conflicts and build breakage for breakfast when my tree
>    merges into mainline.  ;)
> 
> No further complaints about this please - there's been plenty of warning
> about these debug macro changes.
> 
Hi Russell,

There is new machine support code for -next in my tree.
It changes ARCH_S5P6440(mach-s5p6440) to ARCH_S5P64X0(mach-s5p64x0) so that
can support S5P6440 and S5P6450 SoCs.

As a note, I fixed its debug-macro.S according to your devel tree and
's5p64x0_defconfig' is just from s5p6440_defconfig..it means no new added
defconfig :-)
And I'm not sure whether need Stephen's following fix now.

http://lkml.org/lkml/2010/10/17/224


Please pull following from:

git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-rmk


Hmm...do I have an opportunity that request pull to you for -next yet? ;-)

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit cd07202cc8262e1669edff0d97715f3dd9260917

  Linux 2.6.36-rc8

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
for-rmk

Abhilash Kesavan (1):
      ARM: S5P64X0: Replace the 6440 system device class definition with
64x0

Atul Dahiya (1):
      ARM: S5P64X0: Fix GPIO rbank support

Kukjin Kim (15):
      ARM: S5P: Move OneNAND device definitions in plat-s5p
      ARM: S5P: Moves initial map for merging S5P64X0
      ARM: S5P64X0: Update Kconfig and Makefile
      ARM: S5P64X0: Add S5P64X0(S5P6440 and S5P6450) initialization support
      ARM: S5P64X0: Update Clock for S5P6440 and S5P6450
      ARM: S5P64X0: Update IRQ support
      ARM: S5P64X0: Update Timer support
      ARM: S5P64X0: Update Audio support
      ARM: S5P64X0: Move DMA support for S5P64X0
      ARM: S5P64X0: Add S5P6450 I2C support
      ARM: S5P64X0: Move GPIO support files for merge S5P64X0
      ARM: S5P64X0: Move SMDK6440 board file and Add SMDK6450 board file
      ARM: S5P64X0: Add UART serial support for S5P6450
      ARM: s5p64x0_defconfig: Update for support S5P6440 and S5P6450
      ARM: S5PV310: Fix build error on GPIO map

Naveen Krishna Ch (1):
      ARM: S5P64X0: FIX typo in the ADC device name

SeungChull Suh (1):
      ARM: S5P64X0: Bug fix on errors of build with CONFIG_PREEMPT_NONE

arch/arm/Kconfig                                   |   11 +-
 arch/arm/Makefile                                  |    2 +-
 .../{s5p6440_defconfig => s5p64x0_defconfig}       |    3 +-
 arch/arm/mach-s5p6440/Kconfig                      |   33 -
 arch/arm/mach-s5p6440/Makefile                     |   25 -
 arch/arm/mach-s5p6440/clock.c                      |  846
--------------------
 arch/arm/mach-s5p6440/cpu.c                        |  117 ---
 arch/arm/mach-s5p6440/dev-audio.c                  |  127 ---
 arch/arm/mach-s5p6440/dev-spi.c                    |  176 ----
 arch/arm/mach-s5p6440/include/mach/debug-macro.S   |   37 -
 arch/arm/mach-s5p6440/include/mach/gpio.h          |   80 --
 arch/arm/mach-s5p6440/include/mach/io.h            |   18 -
 arch/arm/mach-s5p6440/include/mach/map.h           |   86 --
 arch/arm/mach-s5p6440/include/mach/regs-clock.h    |  130 ---
 arch/arm/mach-s5p6440/include/mach/spi-clocks.h    |   17 -
 arch/arm/mach-s5p6440/include/mach/uncompress.h    |   24 -
 arch/arm/mach-s5p6440/init.c                       |   52 --
 arch/arm/mach-s5p6442/cpu.c                        |   27 +-
 arch/arm/mach-s5p6442/include/mach/map.h           |    6 -
 arch/arm/mach-s5p64x0/Kconfig                      |   57 ++
 arch/arm/mach-s5p64x0/Makefile                     |   30 +
 .../{mach-s5p6440 => mach-s5p64x0}/Makefile.boot   |    0
 arch/arm/mach-s5p64x0/clock-s5p6440.c              |  626 +++++++++++++++
 arch/arm/mach-s5p64x0/clock-s5p6450.c              |  655 +++++++++++++++
 arch/arm/mach-s5p64x0/clock.c                      |  253 ++++++
 arch/arm/mach-s5p64x0/cpu.c                        |  209 +++++
 arch/arm/mach-s5p64x0/dev-audio.c                  |  164 ++++
 arch/arm/mach-s5p64x0/dev-spi.c                    |  232 ++++++
 arch/arm/{mach-s5p6440 => mach-s5p64x0}/dma.c      |   86 ++-
 arch/arm/{mach-s5p6440 => mach-s5p64x0}/gpio.c     |  104 ++--
 arch/arm/mach-s5p64x0/include/mach/debug-macro.S   |   33 +
 .../include/mach/dma.h                             |    0
 .../include/mach/entry-macro.S                     |    8 +-
 arch/arm/mach-s5p64x0/include/mach/gpio.h          |  139 ++++
 .../include/mach/hardware.h                        |    8 +-
 arch/arm/mach-s5p64x0/include/mach/i2c.h           |   17 +
 arch/arm/mach-s5p64x0/include/mach/io.h            |   25 +
 .../include/mach/irqs.h                            |   48 +-
 arch/arm/mach-s5p64x0/include/mach/map.h           |   83 ++
 .../include/mach/memory.h                          |   12 +-
 .../include/mach/pwm-clock.h                       |   10 +-
 arch/arm/mach-s5p64x0/include/mach/regs-clock.h    |   63 ++
 .../include/mach/regs-gpio.h                       |   28 +-
 .../include/mach/regs-irq.h                        |    8 +-
 arch/arm/mach-s5p64x0/include/mach/s5p64x0-clock.h |   46 ++
 arch/arm/mach-s5p64x0/include/mach/spi-clocks.h    |   20 +
 .../include/mach/system.h                          |    8 +-
 .../include/mach/tick.h                            |   13 +-
 .../include/mach/timex.h                           |    7 +-
 arch/arm/mach-s5p64x0/include/mach/uncompress.h    |  212 +++++
 .../include/mach/vmalloc.h                         |    5 +-
 arch/arm/mach-s5p64x0/init.c                       |   73 ++
.../{mach-s5p6440 => mach-s5p64x0}/mach-smdk6440.c |   87 ++-
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |  182 +++++
 .../{mach-s5p6440 => mach-s5p64x0}/setup-i2c0.c    |   24 +-
 .../{mach-s5p6440 => mach-s5p64x0}/setup-i2c1.c    |   20 +-
 arch/arm/mach-s5pc100/cpu.c                        |   25 +-
 arch/arm/mach-s5pc100/include/mach/map.h           |   11 +-
 arch/arm/mach-s5pv210/Kconfig                      |    9 +-
 arch/arm/mach-s5pv210/Makefile                     |    1 -
 arch/arm/mach-s5pv210/cpu.c                        |   22 +-
 arch/arm/mach-s5pv210/include/mach/map.h           |   11 +-
 arch/arm/mach-s5pv210/mach-aquila.c                |    2 +-
 arch/arm/mach-s5pv210/mach-goni.c                  |    2 +-
 arch/arm/mach-s5pv310/cpu.c                        |   26 +-
 arch/arm/mach-s5pv310/include/mach/irqs.h          |    2 +
 arch/arm/mach-s5pv310/include/mach/map.h           |    7 +-
 arch/arm/plat-s5p/Kconfig                          |    9 +-
 arch/arm/plat-s5p/Makefile                         |    1 +
 arch/arm/plat-s5p/clock.c                          |   19 +
 arch/arm/plat-s5p/cpu.c                            |   34 +-
 arch/arm/{mach-s5pv210 => plat-s5p}/dev-onenand.c  |   28 +-
 arch/arm/plat-s5p/dev-uart.c                       |   58 ++
 arch/arm/plat-s5p/include/plat/pll.h               |    7 +
 arch/arm/plat-s5p/include/plat/s5p-clock.h         |    8 +-
 arch/arm/plat-s5p/include/plat/s5p6440.h           |    7 +-
 arch/arm/plat-s5p/include/plat/s5p6450.h           |   36 +
 arch/arm/plat-samsung/include/plat/cpu.h           |    2 +-
 arch/arm/plat-samsung/include/plat/devs.h          |    7 +-
 arch/arm/plat-samsung/include/plat/s3c-dma-pl330.h |   20 +
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h   |    2 +-
 drivers/serial/Kconfig                             |    7 +-
 drivers/serial/samsung.c                           |    2 +-
 83 files changed, 3729 insertions(+), 2048 deletions(-)
