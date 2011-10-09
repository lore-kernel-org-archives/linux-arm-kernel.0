From: zoss@devai.org (Zoltan Devai)
Date: Sun,  9 Oct 2011 18:36:03 +0200
Subject: Add support for the SPMP8000 SoC and Letcool board
Message-ID: <1318178172-7965-1-git-send-email-zoss@devai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds support for the Sunplus SPMP8000 SoC, an ARM926EJ-S based
MCU, which is most commonly found in handheld game consoles and digital cams.
Most of the work was done during GSoC 2011, with Greg KH as my mentor.

The board I'm using for development is the Letcool N350JP handheld.

The patches are based on Arnds for-next branch with Jamie Iles' vic-dt patches
on top.

No static platform devices are used, everything is inited from DT, with some
hacks for drivers that don't have any bindings yet.
(Documentation for own, custom bindings will follow in next version.)

So far, these peripherals are supported, with drivers not submitted yet:
gpio, fb, cpufreq, slave-dma, mmc, ASoC (i2s, codec, pcm, card).

Reviews, instructions for mainlining it are very welcome.

Thanks, Cheers,
Zoltan

 arch/arm/Kconfig                                  |   16 +
 arch/arm/Makefile                                 |    1 +
 arch/arm/boot/dts/spmp8000-letcool.dts            |  163 ++++++
 arch/arm/boot/dts/spmp8000.dtsi                   |  169 ++++++
 arch/arm/common/vic.c                             |    1 -
 arch/arm/mach-spmp8000/Makefile                   |   11 +
 arch/arm/mach-spmp8000/Makefile.boot              |    1 +
 arch/arm/mach-spmp8000/adc.c                      |  465 ++++++++++++++++
 arch/arm/mach-spmp8000/board_letcool.c            |  154 ++++++
 arch/arm/mach-spmp8000/clkdev.c                   |  586 +++++++++++++++++++++
 arch/arm/mach-spmp8000/clock.c                    |  155 ++++++
 arch/arm/mach-spmp8000/core.c                     |  103 ++++
 arch/arm/mach-spmp8000/include/mach/clock.h       |   37 ++
 arch/arm/mach-spmp8000/include/mach/core.h        |   29 +
 arch/arm/mach-spmp8000/include/mach/debug-macro.S |   19 +
 arch/arm/mach-spmp8000/include/mach/dma.h         |   45 ++
 arch/arm/mach-spmp8000/include/mach/entry-macro.S |   14 +
 arch/arm/mach-spmp8000/include/mach/gpio.h        |   21 +
 arch/arm/mach-spmp8000/include/mach/hardware.h    |   27 +
 arch/arm/mach-spmp8000/include/mach/io.h          |   20 +
 arch/arm/mach-spmp8000/include/mach/irqs.h        |   21 +
 arch/arm/mach-spmp8000/include/mach/memory.h      |   16 +
 arch/arm/mach-spmp8000/include/mach/regs-timer.h  |   32 ++
 arch/arm/mach-spmp8000/include/mach/scu.h         |  146 +++++
 arch/arm/mach-spmp8000/include/mach/spmp8000adc.h |   29 +
 arch/arm/mach-spmp8000/include/mach/spmp8000fb.h  |   32 ++
 arch/arm/mach-spmp8000/include/mach/system.h      |   45 ++
 arch/arm/mach-spmp8000/include/mach/timex.h       |   17 +
 arch/arm/mach-spmp8000/include/mach/uncompress.h  |   37 ++
 arch/arm/mach-spmp8000/include/mach/vmalloc.h     |   16 +
 arch/arm/mach-spmp8000/pinmux.c                   |  131 +++++
 arch/arm/mach-spmp8000/pwm.c                      |  246 +++++++++
 arch/arm/mach-spmp8000/timer.c                    |  160 ++++++
 33 files changed, 2964 insertions(+), 1 deletions(-)
