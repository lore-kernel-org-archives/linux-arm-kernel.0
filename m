From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 17 Oct 2011 18:16:14 +0200
Subject: [AT91 PULL for 3.2] boards merge + gpio rework
In-Reply-To: <20111016193301.GJ1459@game.jcrosoft.org>
References: <20111016193301.GJ1459@game.jcrosoft.org>
Message-ID: <4E9C54CE.4020300@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2011 09:33 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Hi Arnd,
> 
> 	This containts the work on
> 	 - gpio rework
> 	 - usb overcurrent support
> 	 - merge of two boards
> 	 - two new boards
> 	 - defconfig rework to have all boards compiled
> 	 - ochi clock rework

Arnd,

Can you hold on a little bit on this pull request. It seems that there
are some rework to be done. Moreover, I guess that you prefer to get
those enhancements feature-by-feature and on top of what you currently
have from at91 side...

We will come back to you with this material in a different shape.

Best regards,

> Please pull
> The following changes since commit ddf28352b80c86754a6424e3a61e8bdf9213b3c7:
> 
>   Linux 3.1-rc5 (2011-09-04 15:45:10 -0700)
> 
> are available in the git repository at:
>   git://github.com/at91linux/linux-at91.git j/for-arnd
> 
> Jean-Christophe PLAGNIOL-VILLARD (17):
>       at91: USB-A9G20 C01 & C11 board support
>       at91: ohci-at91: always provide all the clocks
>       ARM: at91/gpio: make gpio register base soc independant
>       ARM: at91/boards: use -EINVAL for invalid gpio
>       ARM: at91/soc: use gpio_is_valid to check the gpio
>       ARM: at91/pata: use gpio_is_valid to check the gpio
>       ARM: at91/ide: use gpio_is_valid to check the gpio
>       ARM: at91/mmc: use gpio_is_valid to check the gpio
>       ARM: at92/nand: use gpio_is_valid to check the gpio
>       ARM: at92/udc: use gpio_is_valid to check the gpio
>       ARM: at92/ohci: use gpio_is_valid to check the gpio
>       ARM: at91/gpio: drop PIN_BASE
>       ARM: at91/gpio: fix display of number of irq setuped
>       ARM: at91: rename at91sam9260ek_defconfig to at91sam9260_defconfig
>       ARM: at91: rename at91sam9g20ek_defconfig to at91sam9g20_defconfig
>       ARM: at91: rename at91cap9adk_defconfig to at91cap9_defconfig
>       ARM: at91: rename at91sam9rlek_defconfig to at91sam9rl_defconfig
> 
> Josef Holzmayr (1):
>       at91: add support for RSIs EWS board
> 
> Nico Erfurth (1):
>       at91: merge board USB-A9260 and USB-A9263 together
> 
> Thomas Petazzoni (3):
>       at91: ohci-at91: add vbus_pin_inverted platform attribute
>       at91: at91-ohci: support overcurrent notification
>       at91: at91-ohci: configure overcurrent pins as input GPIOs
> 
>  .../{at91cap9adk_defconfig => at91cap9_defconfig}  |    5 -
>  ...91sam9260ek_defconfig => at91sam9260_defconfig} |   14 +-
>  ...91sam9g20ek_defconfig => at91sam9g20_defconfig} |   19 +-
>  ...at91sam9rlek_defconfig => at91sam9rl_defconfig} |    5 -
>  arch/arm/mach-at91/Kconfig                         |   13 +
>  arch/arm/mach-at91/Makefile                        |    6 +-
>  arch/arm/mach-at91/at91cap9.c                      |   10 +-
>  arch/arm/mach-at91/at91cap9_devices.c              |   26 +-
>  arch/arm/mach-at91/at91rm9200.c                    |   10 +-
>  arch/arm/mach-at91/at91rm9200_devices.c            |   30 ++-
>  arch/arm/mach-at91/at91sam9260.c                   |    8 +-
>  arch/arm/mach-at91/at91sam9260_devices.c           |   34 ++-
>  arch/arm/mach-at91/at91sam9261.c                   |   35 +-
>  arch/arm/mach-at91/at91sam9261_devices.c           |   22 +-
>  arch/arm/mach-at91/at91sam9263.c                   |   12 +-
>  arch/arm/mach-at91/at91sam9263_devices.c           |   32 ++-
>  arch/arm/mach-at91/at91sam9g45.c                   |   12 +-
>  arch/arm/mach-at91/at91sam9g45_devices.c           |   26 +-
>  arch/arm/mach-at91/at91sam9rl.c                    |    8 +-
>  arch/arm/mach-at91/at91sam9rl_devices.c            |   16 +-
>  arch/arm/mach-at91/board-1arm.c                    |    1 +
>  arch/arm/mach-at91/board-afeb-9260v1.c             |    7 +-
>  arch/arm/mach-at91/board-cam60.c                   |    3 +-
>  arch/arm/mach-at91/board-cap9adk.c                 |   14 +-
>  arch/arm/mach-at91/board-carmeva.c                 |    6 +-
>  arch/arm/mach-at91/board-cpu9krea.c                |    7 +-
>  arch/arm/mach-at91/board-cpuat91.c                 |    4 +
>  arch/arm/mach-at91/board-csb337.c                  |    4 +-
>  arch/arm/mach-at91/board-csb637.c                  |    1 +
>  arch/arm/mach-at91/board-eb9200.c                  |    8 +-
>  arch/arm/mach-at91/board-ecbat91.c                 |    4 +
>  arch/arm/mach-at91/board-eco920.c                  |    4 +
>  arch/arm/mach-at91/board-flexibity.c               |    4 +-
>  arch/arm/mach-at91/board-foxg20.c                  |    6 +-
>  arch/arm/mach-at91/board-gsia18s.c                 |    4 +-
>  arch/arm/mach-at91/board-kafa.c                    |    1 +
>  arch/arm/mach-at91/board-kb9202.c                  |    5 +-
>  arch/arm/mach-at91/board-neocore926.c              |    4 +-
>  arch/arm/mach-at91/board-pcontrol-g20.c            |    1 +
>  arch/arm/mach-at91/board-picotux200.c              |    2 +
>  arch/arm/mach-at91/board-qil-a9260.c               |   11 +-
>  arch/arm/mach-at91/board-rm9200dk.c                |   10 +-
>  arch/arm/mach-at91/board-rm9200ek.c                |    2 +
>  arch/arm/mach-at91/board-rsi-ews.c                 |  233 ++++++++++++++
>  arch/arm/mach-at91/board-sam9-l9260.c              |    7 +-
>  arch/arm/mach-at91/board-sam9260ek.c               |   11 +-
>  arch/arm/mach-at91/board-sam9261ek.c               |    8 +-
>  arch/arm/mach-at91/board-sam9263ek.c               |    7 +-
>  arch/arm/mach-at91/board-sam9g20ek.c               |    8 +-
>  arch/arm/mach-at91/board-sam9m10g45ek.c            |    3 +
>  arch/arm/mach-at91/board-sam9rlek.c                |    7 +-
>  arch/arm/mach-at91/board-snapper9260.c             |    5 +
>  arch/arm/mach-at91/board-stamp9g20.c               |   11 +-
>  arch/arm/mach-at91/board-usb-a9260.c               |  230 --------------
>  .../{board-usb-a9263.c => board-usb-a926x.c}       |  184 ++++++++++--
>  arch/arm/mach-at91/board-yl-9200.c                 |    6 +-
>  arch/arm/mach-at91/generic.h                       |    2 +-
>  arch/arm/mach-at91/gpio.c                          |   62 ++--
>  arch/arm/mach-at91/include/mach/at91cap9.h         |    9 +-
>  arch/arm/mach-at91/include/mach/at91rm9200.h       |    9 +-
>  arch/arm/mach-at91/include/mach/at91sam9260.h      |    7 +-
>  arch/arm/mach-at91/include/mach/at91sam9261.h      |    7 +-
>  arch/arm/mach-at91/include/mach/at91sam9263.h      |   11 +-
>  arch/arm/mach-at91/include/mach/at91sam9g45.h      |   11 +-
>  arch/arm/mach-at91/include/mach/at91sam9rl.h       |    9 +-
>  arch/arm/mach-at91/include/mach/board.h            |    5 +
>  arch/arm/mach-at91/include/mach/gpio.h             |  328 ++++++++++----------
>  arch/arm/mach-at91/include/mach/timex.h            |    5 +
>  drivers/ata/pata_at91.c                            |    6 +-
>  drivers/ide/at91_ide.c                             |    2 +-
>  drivers/mmc/host/at91_mci.c                        |   30 +-
>  drivers/mtd/nand/atmel_nand.c                      |    8 +-
>  drivers/usb/gadget/at91_udc.c                      |   14 +-
>  drivers/usb/host/ohci-at91.c                       |  243 +++++++++++++--
>  74 files changed, 1231 insertions(+), 713 deletions(-)
>  rename arch/arm/configs/{at91cap9adk_defconfig => at91cap9_defconfig} (95%)
>  rename arch/arm/configs/{at91sam9260ek_defconfig => at91sam9260_defconfig} (89%)
>  rename arch/arm/configs/{at91sam9g20ek_defconfig => at91sam9g20_defconfig} (93%)
>  rename arch/arm/configs/{at91sam9rlek_defconfig => at91sam9rl_defconfig} (94%)
>  create mode 100644 arch/arm/mach-at91/board-rsi-ews.c
>  delete mode 100644 arch/arm/mach-at91/board-usb-a9260.c
>  rename arch/arm/mach-at91/{board-usb-a9263.c => board-usb-a926x.c} (53%)


-- 
Nicolas Ferre
