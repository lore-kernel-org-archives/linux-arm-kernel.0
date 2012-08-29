From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:31:26 -0500
Subject: [PATCH 00/10] Make mach/gpio.h optional
Message-ID: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series makes mach/gpio.h optional like we have done for other mach
headers in preparation for multi-platform kernel images. Unfortunately,
it adds more mach includes to drivers/, but really they are just now
explicitly included and easily found.

A few platforms like Samsung were such a mess I didn't convert them and
they still require a gpio.h.

This is build tested on all ARM defconfigs. There may be a few lingering
failures, but I've iterated thru builds several times.

The series plus multi-platform support is available here:

git://sources.calxeda.com/kernel/linux.git multi-plat

Rob

Rob Herring (10):
  usb: pxa27x_udc: remove IRQ_USB define
  gpio: pxa: add explicit includes for cpu_is_X macros
  serial: atmel: add explict mach/gpio.h include
  net: pxaficp_ir: add explicit mach/gpio.h includes
  ARM: at91: explicitly include mach/gpio.h
  ARM: shmobile: explicitly include mach/gpio.h
  ARM: orion: add explict mach/gpio.h includes
  ARM: omap2: add explict mach/gpio.h includes
  ARM: omap1: add explict mach/gpio.h includes
  ARM: make mach/gpio.h headers optional

 arch/arm/Kconfig                               |   17 +++++++++++++
 arch/arm/include/asm/gpio.h                    |    2 ++
 arch/arm/mach-at91/at91rm9200_devices.c        |    1 +
 arch/arm/mach-at91/at91sam9260_devices.c       |    1 +
 arch/arm/mach-at91/at91sam9261_devices.c       |    1 +
 arch/arm/mach-at91/at91sam9263_devices.c       |    1 +
 arch/arm/mach-at91/at91sam9g45_devices.c       |    1 +
 arch/arm/mach-at91/at91sam9rl_devices.c        |    1 +
 arch/arm/mach-at91/board-1arm.c                |    1 +
 arch/arm/mach-at91/board-afeb-9260v1.c         |    1 +
 arch/arm/mach-at91/board-cam60.c               |    1 +
 arch/arm/mach-at91/board-carmeva.c             |    1 +
 arch/arm/mach-at91/board-cpu9krea.c            |    1 +
 arch/arm/mach-at91/board-cpuat91.c             |    1 +
 arch/arm/mach-at91/board-csb337.c              |    1 +
 arch/arm/mach-at91/board-csb637.c              |    1 +
 arch/arm/mach-at91/board-eb9200.c              |    1 +
 arch/arm/mach-at91/board-ecbat91.c             |    1 +
 arch/arm/mach-at91/board-eco920.c              |    1 +
 arch/arm/mach-at91/board-flexibity.c           |    1 +
 arch/arm/mach-at91/board-foxg20.c              |    1 +
 arch/arm/mach-at91/board-gsia18s.c             |    1 +
 arch/arm/mach-at91/board-kafa.c                |    1 +
 arch/arm/mach-at91/board-kb9202.c              |    1 +
 arch/arm/mach-at91/board-neocore926.c          |    1 +
 arch/arm/mach-at91/board-pcontrol-g20.c        |    1 +
 arch/arm/mach-at91/board-picotux200.c          |    1 +
 arch/arm/mach-at91/board-qil-a9260.c           |    1 +
 arch/arm/mach-at91/board-rm9200dk.c            |    1 +
 arch/arm/mach-at91/board-rm9200ek.c            |    1 +
 arch/arm/mach-at91/board-rsi-ews.c             |    1 +
 arch/arm/mach-at91/board-sam9-l9260.c          |    1 +
 arch/arm/mach-at91/board-sam9260ek.c           |    1 +
 arch/arm/mach-at91/board-sam9261ek.c           |    1 +
 arch/arm/mach-at91/board-sam9263ek.c           |    1 +
 arch/arm/mach-at91/board-sam9g20ek.c           |    1 +
 arch/arm/mach-at91/board-sam9m10g45ek.c        |    1 +
 arch/arm/mach-at91/board-sam9rlek.c            |    1 +
 arch/arm/mach-at91/board-snapper9260.c         |    1 +
 arch/arm/mach-at91/board-stamp9g20.c           |    1 +
 arch/arm/mach-at91/board-usb-a926x.c           |    1 +
 arch/arm/mach-at91/board-yl-9200.c             |    1 +
 arch/arm/mach-at91/gpio.c                      |    1 +
 arch/arm/mach-at91/leds.c                      |    1 +
 arch/arm/mach-at91/pm.c                        |    1 +
 arch/arm/mach-dove/irq.c                       |    1 +
 arch/arm/mach-dove/mpp.c                       |    1 +
 arch/arm/mach-ep93xx/include/mach/gpio.h       |    1 -
 arch/arm/mach-highbank/include/mach/gpio.h     |    1 -
 arch/arm/mach-ixp4xx/include/mach/gpio.h       |    2 --
 arch/arm/mach-kirkwood/irq.c                   |    1 +
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c   |    1 +
 arch/arm/mach-mmp/include/mach/gpio.h          |    8 ------
 arch/arm/mach-msm/include/mach/gpio.h          |    1 -
 arch/arm/mach-mv78xx0/irq.c                    |    1 +
 arch/arm/mach-mxs/include/mach/gpio.h          |    1 -
 arch/arm/mach-nomadik/include/mach/gpio.h      |    4 ---
 arch/arm/mach-omap1/board-ams-delta.c          |    1 +
 arch/arm/mach-omap1/board-osk.c                |    1 +
 arch/arm/mach-omap1/gpio15xx.c                 |    1 +
 arch/arm/mach-omap1/gpio16xx.c                 |    1 +
 arch/arm/mach-omap1/gpio7xx.c                  |    1 +
 arch/arm/mach-omap1/leds-h2p2-debug.c          |    1 +
 arch/arm/mach-omap1/leds.c                     |    1 +
 arch/arm/mach-omap2/board-zoom-display.c       |    1 +
 arch/arm/mach-omap2/gpio.c                     |    1 +
 arch/arm/mach-omap2/pm24xx.c                   |    1 +
 arch/arm/mach-omap2/pm34xx.c                   |    1 +
 arch/arm/mach-orion5x/d2net-setup.c            |    1 +
 arch/arm/mach-orion5x/dns323-setup.c           |    1 +
 arch/arm/mach-orion5x/irq.c                    |    1 +
 arch/arm/mach-orion5x/net2big-setup.c          |    1 +
 arch/arm/mach-picoxcell/include/mach/gpio.h    |    1 -
 arch/arm/mach-pxa/include/mach/gpio.h          |   32 ------------------------
 arch/arm/mach-realview/include/mach/gpio.h     |    1 -
 arch/arm/mach-shmobile/board-ap4evb.c          |    1 +
 arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
 arch/arm/mach-shmobile/board-g4evm.c           |    1 +
 arch/arm/mach-shmobile/board-mackerel.c        |    1 +
 arch/arm/mach-shmobile/include/mach/gpio.h     |   14 -----------
 arch/arm/mach-shmobile/pfc-r8a7740.c           |    2 +-
 arch/arm/mach-shmobile/pfc-r8a7779.c           |    2 +-
 arch/arm/mach-shmobile/pfc-sh7367.c            |    2 +-
 arch/arm/mach-shmobile/pfc-sh7372.c            |    2 +-
 arch/arm/mach-shmobile/pfc-sh7377.c            |    2 +-
 arch/arm/mach-shmobile/pfc-sh73a0.c            |    2 +-
 arch/arm/mach-spear13xx/include/mach/gpio.h    |   19 --------------
 arch/arm/mach-spear3xx/include/mach/gpio.h     |   19 --------------
 arch/arm/mach-spear6xx/include/mach/gpio.h     |   19 --------------
 arch/arm/mach-tegra/include/mach/gpio.h        |    1 -
 arch/arm/mach-u300/include/mach/gpio.h         |    1 -
 arch/arm/mach-ux500/include/mach/gpio.h        |    5 ----
 arch/arm/mach-versatile/include/mach/gpio.h    |    1 -
 arch/arm/mach-vexpress/include/mach/gpio.h     |    1 -
 arch/arm/mach-vt8500/include/mach/gpio.h       |    1 -
 arch/arm/plat-mxc/include/mach/gpio.h          |    1 -
 arch/arm/plat-orion/mpp.c                      |    1 +
 arch/arm/plat-spear/include/plat/gpio.h        |    1 -
 drivers/gpio/gpio-omap.c                       |    2 +-
 drivers/gpio/gpio-pxa.c                        |    4 +++
 drivers/net/irda/pxaficp_ir.c                  |    3 ++-
 drivers/sh/pfc/gpio.c                          |    1 +
 drivers/tty/serial/atmel_serial.c              |    2 +-
 drivers/usb/gadget/pxa27x_udc.c                |    2 +-
 104 files changed, 103 insertions(+), 145 deletions(-)
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-mmp/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-msm/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-pxa/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-realview/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-u300/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-spear/include/plat/gpio.h

-- 
1.7.9.5
