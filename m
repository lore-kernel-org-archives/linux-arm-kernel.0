From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 26 Jun 2014 07:30:20 +0200
Subject: [PATCH 00/13] AT91: PIT: Cleanups and move to drivers/clocksource
In-Reply-To: <1403701605-26678-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1403701605-26678-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <53ABAFEC.9070500@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Maxime,

On 25/06/2014 15:06, Maxime Ripard wrote:
> Hi everyone,
>
> This series cleans up the PIT driver in order for it to not depend on
> anything in mach-at91 anymore, and in the end move it out of
> mach-at91.
>
> Along the way, these patches also do a bit of cleanup.
>
> This has been tested on a G45-EK without DT and an Xplained with DT.

Except for the 2 nitpicks in patch 9 and 13, this series looks good to me.
I was a bit afraid to see code for non DT board support go into this new
driver (or driver rework), but you managed to get rid of all global
variables and non static functions thanks to the early device approach,
and that's great!

Thanks for your work.

Boris

>
> Thanks,
> Maxime
>
> Maxime Ripard (13):
>   AT91: PIT: Follow the general coding rules
>   AT91: generic.h: Add include safe guards
>   AT91: PIT: Use of_have_populated_dt instead of CONFIG_OF
>   AT91: PIT: Rework probe functions
>   AT91: dt: Remove init_time definitions
>   AT91: PIT: Use consistent exit path in probe
>   AT91: PIT: Use pr_fmt
>   AT91: PIT: use request_irq instead of setup_irq
>   AT91: PIT: (Almost) remove the global variables
>   AT91: soc: Add init_time callback
>   AT91: Convert the boards to the init_time callback
>   AT91: PIT: Convert to an early_platform_device
>   AT91: PIT: Move the driver to drivers/clocksource
>
>  arch/arm/mach-at91/Kconfig              |   3 -
>  arch/arm/mach-at91/Makefile             |   1 -
>  arch/arm/mach-at91/at91sam9260.c        |  34 +++-
>  arch/arm/mach-at91/at91sam9261.c        |  34 +++-
>  arch/arm/mach-at91/at91sam9263.c        |  34 +++-
>  arch/arm/mach-at91/at91sam926x_time.c   | 294 ------------------------------
>  arch/arm/mach-at91/at91sam9g45.c        |  35 +++-
>  arch/arm/mach-at91/at91sam9rl.c         |  34 +++-
>  arch/arm/mach-at91/board-afeb-9260v1.c  |   2 +-
>  arch/arm/mach-at91/board-cam60.c        |   2 +-
>  arch/arm/mach-at91/board-cpu9krea.c     |   2 +-
>  arch/arm/mach-at91/board-dt-sam9.c      |  10 --
>  arch/arm/mach-at91/board-dt-sama5.c     |   9 -
>  arch/arm/mach-at91/board-flexibity.c    |   2 +-
>  arch/arm/mach-at91/board-foxg20.c       |   2 +-
>  arch/arm/mach-at91/board-gsia18s.c      |   2 +-
>  arch/arm/mach-at91/board-pcontrol-g20.c |   2 +-
>  arch/arm/mach-at91/board-sam9-l9260.c   |   2 +-
>  arch/arm/mach-at91/board-sam9260ek.c    |   2 +-
>  arch/arm/mach-at91/board-sam9261ek.c    |   4 +-
>  arch/arm/mach-at91/board-sam9263ek.c    |   2 +-
>  arch/arm/mach-at91/board-sam9g20ek.c    |   4 +-
>  arch/arm/mach-at91/board-sam9m10g45ek.c |   2 +-
>  arch/arm/mach-at91/board-sam9rlek.c     |   2 +-
>  arch/arm/mach-at91/board-snapper9260.c  |   2 +-
>  arch/arm/mach-at91/board-stamp9g20.c    |   4 +-
>  arch/arm/mach-at91/generic.h            |   8 +-
>  arch/arm/mach-at91/setup.c              |   5 +
>  arch/arm/mach-at91/soc.h                |   1 +
>  drivers/clocksource/Kconfig             |   4 +
>  drivers/clocksource/Makefile            |   1 +
>  drivers/clocksource/at91sam926x_time.c  | 304 ++++++++++++++++++++++++++++++++
>  32 files changed, 506 insertions(+), 343 deletions(-)
>  delete mode 100644 arch/arm/mach-at91/at91sam926x_time.c
>  create mode 100644 drivers/clocksource/at91sam926x_time.c
>

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
