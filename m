From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 17 Apr 2012 10:55:24 +0200
Subject: [PATCH 00/10] ARM: at91: finnaly add multi soc in the same kernel
 support
In-Reply-To: <20120408151236.GH16641@game.jcrosoft.org>
References: <20120408151236.GH16641@game.jcrosoft.org>
Message-ID: <4F8D2FFC.1030803@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2012 05:12 PM, Jean-Christophe PLAGNIOL-VILLARD :
> HI,
> 
> 	This patch serie finally add the support of multi soc in the same
> 	kernel on at91.
> 
> 	For now on it's limited to the DT but we can compile all the core
> 	together. We still can not compile the old style board as the same API
> 	is define on all SoC but as we move to the DT this will be drop
> 	finally too.
> 
> The following changes since commit d5ae7361d16f7d628de7ed38d4bdf64379ab54d7:
> 
>   hwrng: Kconfig: remove dependency for atmel-rng driver (2012-04-08 20:00:33 +0800)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git j/at91_multisoc
> 
> for you to fetch changes up to 73bcc4309e6c1f1fa62f3c68b0724730a82a0f34:
> 
>   ARM: at91: add defconfig for device tree (2012-04-08 23:19:09 +0800)
> 
> ----------------------------------------------------------------
> Jean-Christophe PLAGNIOL-VILLARD (10):
>       ARM: at91: uncompress Store UART address in a variable
>       ARM: at91: uncompress: autodetect the uart to use
>       ARM: at91: drop at91_set_serial_console
>       ARM: at91: do not pin mux the UARTs in init_early
>       ARM: at91: move at91_init_leds to board init
>       ARM: at91: pm select memory controler at runtime
>       ARM: at91: add SOC_AT91SAM9 kconfig option to factorise select
>       ARN: at91: introduce SOC_AT91xxx define to allow to compile SoC core support
>       ARM: at91/dt: do not specify the board any more
>       ARM: at91: add defconfig for device tree

Jean-Christophe, I queue this patch series in a "cleanup" branch for 3.5
(and add my "Acked-by" to patches not tagged).

Thanks for this work.

Cheers,

> 
>  arch/arm/configs/at91_dt_defconfig            |  196 +++++++++++++++++++++++++
>  arch/arm/configs/at91rm9200_defconfig         |    1 +
>  arch/arm/mach-at91/Kconfig                    |  164 +++++++++------------
>  arch/arm/mach-at91/Makefile                   |   26 ++-
>  arch/arm/mach-at91/at91rm9200.c               |   12 --
>  arch/arm/mach-at91/at91rm9200_devices.c       |   12 --
>  arch/arm/mach-at91/at91sam9260.c              |   12 --
>  arch/arm/mach-at91/at91sam9260_devices.c      |   12 --
>  arch/arm/mach-at91/at91sam9261.c              |   12 --
>  arch/arm/mach-at91/at91sam9261_devices.c      |   12 --
>  arch/arm/mach-at91/at91sam9263.c              |   12 --
>  arch/arm/mach-at91/at91sam9263_devices.c      |   12 --
>  arch/arm/mach-at91/at91sam9g45.c              |   12 --
>  arch/arm/mach-at91/at91sam9g45_devices.c      |   12 --
>  arch/arm/mach-at91/at91sam9rl.c               |   12 --
>  arch/arm/mach-at91/at91sam9rl_devices.c       |   12 --
>  arch/arm/mach-at91/board-1arm.c               |   24 ++--
>  arch/arm/mach-at91/board-afeb-9260v1.c        |   28 ++--
>  arch/arm/mach-at91/board-cam60.c              |    8 +-
>  arch/arm/mach-at91/board-carmeva.c            |   18 +--
>  arch/arm/mach-at91/board-cpu9krea.c           |   52 +++----
>  arch/arm/mach-at91/board-cpuat91.c            |   40 +++---
>  arch/arm/mach-at91/board-csb337.c             |   13 +-
>  arch/arm/mach-at91/board-csb637.c             |    8 +-
>  arch/arm/mach-at91/board-dt.c                 |   14 +-
>  arch/arm/mach-at91/board-eb9200.c             |   24 ++--
>  arch/arm/mach-at91/board-ecbat91.c            |   20 +--
>  arch/arm/mach-at91/board-eco920.c             |   13 +-
>  arch/arm/mach-at91/board-flexibity.c          |    8 +-
>  arch/arm/mach-at91/board-foxg20.c             |   71 ++++-----
>  arch/arm/mach-at91/board-gsia18s.c            |   63 ++++----
>  arch/arm/mach-at91/board-kafa.c               |   20 +--
>  arch/arm/mach-at91/board-kb9202.c             |   32 ++---
>  arch/arm/mach-at91/board-neocore926.c         |   14 +-
>  arch/arm/mach-at91/board-pcontrol-g20.c       |   21 ++--
>  arch/arm/mach-at91/board-picotux200.c         |   18 +--
>  arch/arm/mach-at91/board-qil-a9260.c          |   31 ++---
>  arch/arm/mach-at91/board-rm9200dk.c           |   24 ++--
>  arch/arm/mach-at91/board-rm9200ek.c           |   24 ++--
>  arch/arm/mach-at91/board-rsi-ews.c            |   36 ++---
>  arch/arm/mach-at91/board-sam9-l9260.c         |   30 ++--
>  arch/arm/mach-at91/board-sam9260ek.c          |   24 ++--
>  arch/arm/mach-at91/board-sam9261ek.c          |   14 +-
>  arch/arm/mach-at91/board-sam9263ek.c          |   14 +-
>  arch/arm/mach-at91/board-sam9g20ek.c          |   24 ++--
>  arch/arm/mach-at91/board-sam9m10g45ek.c       |   16 +--
>  arch/arm/mach-at91/board-sam9rlek.c           |   14 +-
>  arch/arm/mach-at91/board-snapper9260.c        |   18 +--
>  arch/arm/mach-at91/board-stamp9g20.c          |   64 +++-----
>  arch/arm/mach-at91/board-usb-a926x.c          |    8 +-
>  arch/arm/mach-at91/board-yl-9200.c            |   36 ++---
>  arch/arm/mach-at91/generic.h                  |   11 --
>  arch/arm/mach-at91/include/mach/at91rm9200.h  |    5 -
>  arch/arm/mach-at91/include/mach/at91sam9260.h |    7 -
>  arch/arm/mach-at91/include/mach/at91sam9261.h |    4 -
>  arch/arm/mach-at91/include/mach/at91sam9263.h |    4 -
>  arch/arm/mach-at91/include/mach/at91sam9g45.h |    5 -
>  arch/arm/mach-at91/include/mach/at91sam9rl.h  |    5 -
>  arch/arm/mach-at91/include/mach/at91sam9x5.h  |    8 -
>  arch/arm/mach-at91/include/mach/board.h       |    1 -
>  arch/arm/mach-at91/include/mach/cpu.h         |   28 ++--
>  arch/arm/mach-at91/include/mach/hardware.h    |   16 +--
>  arch/arm/mach-at91/include/mach/uncompress.h  |  178 +++++++++++++++++++----
>  arch/arm/mach-at91/pm.c                       |   12 +-
>  arch/arm/mach-at91/pm.h                       |   15 +--
>  arch/arm/mach-at91/pm_slowclock.S             |    2 +-
>  arch/arm/mach-at91/soc.h                      |   14 +-
>  67 files changed, 834 insertions(+), 898 deletions(-)
>  create mode 100644 arch/arm/configs/at91_dt_defconfig
> 
> Best Regards,
> J.
> 


-- 
Nicolas Ferre
