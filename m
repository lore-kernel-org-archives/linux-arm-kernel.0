From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 29 Nov 2011 03:02:13 +0100
Subject: [AT91 PULL] gpio cleanup pull request for 3.3
In-Reply-To: <201111281858.54217.arnd@arndb.de>
References: <20111123171935.GC15531@game.jcrosoft.org>
 <201111281858.54217.arnd@arndb.de>
Message-ID: <20111129020213.GI15008@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:58 Mon 28 Nov     , Arnd Bergmann wrote:
> On Wednesday 23 November 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >         this pull containt the first patch series that rework the gpio to make it more standard
> >         and to allow the multi soc and simplify the adding of the DT
> >         
> >         this pull depends on previous one for the ioremaps
> >         
> > The following changes since commit 55c71f1a3e29cc7cd761a358deac96d3e952128f:
> > 
> >   ARM: at91: make rm9200 rtc drivers soc independent (2011-11-23 23:00:11 +0800)
> > 
> 
> For some reason, this series contains another patch that you have
> not mentioned: "macb: unify at91 and avr32 platform data" from Jamie.
> The patch looks ok, but it seems that you have included it unintentionally.
> 
> What should I do with this? I can rebase the series to leave that patch out,
> or I could apply it as well.
I just rebase it yesterday to avoid the conflict for you

I repush against rc3 and include the patch from Jamie
the pull was in my to send sorry

send now gain

The following changes since commit d28bdfc5c80fb64bf50824920bf9b554732dec74:

  ARM: at91: make rm9200 rtc drivers soc independent (2011-11-28 22:50:39 +0800)

are available in the git repository at:
  git at github.com:at91linux/linux-at91.git for-arnd-3.3-gpio

Jamie Iles (1):
      macb: unify at91 and avr32 platform data

Jean-Christophe PLAGNIOL-VILLARD (12):
      ARM: at91: switch gpio clock to clkdev
      ARM: at91: gpio make struct at91_gpio_bank an initdata
      ARM: at91/boards: use -EINVAL for invalid gpio
      ARM: at91/soc: use gpio_is_valid to check the gpio
      ARM: at91/pata: use gpio_is_valid to check the gpio
      ARM: at91/ide: use gpio_is_valid to check the gpio
      ARM: at91/mmc: use gpio_is_valid to check the gpio
      ARM: at91/nand: use gpio_is_valid to check the gpio
      ARM: at91/ohci: use gpio_is_valid to check the gpio
      ARM: at91/udc: use gpio_is_valid to check the gpio
      ARM: at91/gpio: drop PIN_BASE
      ARM: at91/gpio: fix display of number of irq setuped

 arch/arm/mach-at91/at91cap9.c               |   10 +-
 arch/arm/mach-at91/at91cap9_devices.c       |   26 +-
 arch/arm/mach-at91/at91rm9200.c             |   10 +-
 arch/arm/mach-at91/at91rm9200_devices.c     |   28 ++--
 arch/arm/mach-at91/at91sam9260.c            |    8 +-
 arch/arm/mach-at91/at91sam9260_devices.c    |   32 ++--
 arch/arm/mach-at91/at91sam9261.c            |    8 +-
 arch/arm/mach-at91/at91sam9261_devices.c    |   14 +-
 arch/arm/mach-at91/at91sam9263.c            |   12 +-
 arch/arm/mach-at91/at91sam9263_devices.c    |   32 ++--
 arch/arm/mach-at91/at91sam9g45.c            |   12 +-
 arch/arm/mach-at91/at91sam9g45_devices.c    |   26 +-
 arch/arm/mach-at91/at91sam9rl.c             |   10 +-
 arch/arm/mach-at91/at91sam9rl_devices.c     |   16 +-
 arch/arm/mach-at91/board-1arm.c             |    4 +-
 arch/arm/mach-at91/board-afeb-9260v1.c      |   10 +-
 arch/arm/mach-at91/board-cam60.c            |    6 +-
 arch/arm/mach-at91/board-cap9adk.c          |   17 +-
 arch/arm/mach-at91/board-carmeva.c          |    9 +-
 arch/arm/mach-at91/board-cpu9krea.c         |   10 +-
 arch/arm/mach-at91/board-cpuat91.c          |    7 +-
 arch/arm/mach-at91/board-csb337.c           |    7 +-
 arch/arm/mach-at91/board-csb637.c           |    4 +-
 arch/arm/mach-at91/board-dt.c               |    1 +
 arch/arm/mach-at91/board-eb9200.c           |   11 +-
 arch/arm/mach-at91/board-ecbat91.c          |    7 +-
 arch/arm/mach-at91/board-eco920.c           |    7 +-
 arch/arm/mach-at91/board-flexibity.c        |    5 +-
 arch/arm/mach-at91/board-foxg20.c           |    9 +-
 arch/arm/mach-at91/board-gsia18s.c          |    7 +-
 arch/arm/mach-at91/board-kafa.c             |    4 +-
 arch/arm/mach-at91/board-kb9202.c           |    8 +-
 arch/arm/mach-at91/board-neocore926.c       |    7 +-
 arch/arm/mach-at91/board-pcontrol-g20.c     |    4 +-
 arch/arm/mach-at91/board-picotux200.c       |    5 +-
 arch/arm/mach-at91/board-qil-a9260.c        |   14 +-
 arch/arm/mach-at91/board-rm9200dk.c         |   13 +-
 arch/arm/mach-at91/board-rm9200ek.c         |    5 +-
 arch/arm/mach-at91/board-rsi-ews.c          |    4 +-
 arch/arm/mach-at91/board-sam9-l9260.c       |   10 +-
 arch/arm/mach-at91/board-sam9260ek.c        |   14 +-
 arch/arm/mach-at91/board-sam9261ek.c        |    9 +-
 arch/arm/mach-at91/board-sam9263ek.c        |   10 +-
 arch/arm/mach-at91/board-sam9g20ek.c        |   11 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c     |    6 +-
 arch/arm/mach-at91/board-sam9rlek.c         |    7 +-
 arch/arm/mach-at91/board-snapper9260.c      |    8 +-
 arch/arm/mach-at91/board-stamp9g20.c        |   14 +-
 arch/arm/mach-at91/board-usb-a926x.c        |    8 +-
 arch/arm/mach-at91/board-yl-9200.c          |    9 +-
 arch/arm/mach-at91/generic.h                |    1 -
 arch/arm/mach-at91/gpio.c                   |   79 ++++---
 arch/arm/mach-at91/include/mach/board.h     |   42 ++--
 arch/arm/mach-at91/include/mach/gpio.h      |  328 +++++++++++++--------------
 arch/avr32/boards/atngw100/setup.c          |    2 +-
 arch/avr32/boards/atstk1000/atstk1002.c     |    2 +-
 arch/avr32/boards/favr-32/setup.c           |    2 +-
 arch/avr32/boards/hammerhead/setup.c        |    2 +-
 arch/avr32/boards/merisc/setup.c            |    2 +-
 arch/avr32/boards/mimc200/setup.c           |    2 +-
 arch/avr32/mach-at32ap/at32ap700x.c         |    8 +-
 arch/avr32/mach-at32ap/include/mach/board.h |    7 +-
 drivers/ata/pata_at91.c                     |    6 +-
 drivers/ide/at91_ide.c                      |    2 +-
 drivers/mmc/host/at91_mci.c                 |   30 ++--
 drivers/mtd/nand/atmel_nand.c               |    8 +-
 drivers/net/ethernet/cadence/at91_ether.c   |    3 +-
 drivers/net/ethernet/cadence/at91_ether.h   |    4 +-
 drivers/net/ethernet/cadence/macb.c         |   10 +-
 drivers/usb/gadget/at91_udc.c               |   14 +-
 drivers/usb/host/ohci-at91.c                |   12 +-
 include/linux/platform_data/macb.h          |   17 ++
 72 files changed, 628 insertions(+), 490 deletions(-)
 create mode 100644 include/linux/platform_data/macb.h

Best Regards,
J.
